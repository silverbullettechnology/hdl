//
// (c) Copyright 2010 - 2014 Xilinx, Inc. All rights reserved.
//
//                                                                 
// This file contains confidential and proprietary information
// of Xilinx, Inc. and is protected under U.S. and
// international copyright and other intellectual property
// laws.
// 
// DISCLAIMER
// This disclaimer is not a license and does not grant any
// rights to the materials distributed herewith. Except as
// otherwise provided in a valid license issued to you by
// Xilinx, and to the maximum extent permitted by applicable
// law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
// WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
// AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
// BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
// INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
// (2) Xilinx shall not be liable (whether in contract or tort,
// including negligence, or under any other theory of
// liability) for any loss or damage of any kind or nature
// related to, arising under or in connection with these
// materials, including for any direct, or any indirect,
// special, incidental, or consequential loss or damage
// (including loss of data, profits, goodwill, or any type of
// loss or damage suffered as a result of any action brought
// by a third party) even if such damage or loss was
// reasonably foreseeable or Xilinx had been advised of the
// possibility of the same.
// 
// CRITICAL APPLICATIONS
// Xilinx products are not designed or intended to be fail-
// safe, or for use in any application requiring fail-safe
// performance, such as life-support or safety devices or
// systems, Class III medical devices, nuclear facilities,
// applications related to the deployment of airbags, or any
// other applications that could lead to death, personal
// injury, or severe property or environmental damage
// (individually and collectively, "Critical
// Applications"). Customer assumes the sole risk and
// liability of any use of Xilinx products in Critical
// Applications, subject only to applicable laws and
// regulations governing limitations on product liability.
// 
// THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
// 	PART OF THIS FILE AT ALL TIMES.                                
`timescale 1ps/1ps
module dstream_seg_srio_gen2_0
(
    input             clk,
    input             reset,

    output reg        ireq_tvalid,
    input             ireq_tready,
    output reg        ireq_tlast,
    output reg [63:0] ireq_tdata,
    output reg  [7:0] ireq_tkeep,
    output reg [31:0] ireq_tuser,

    input             user_ireq_tvalid,
    output            user_ireq_tready,
    input             user_ireq_tlast,
    input  [63:0]     user_ireq_tdata,
    input   [7:0]     user_ireq_tkeep,
    input  [31:0]     user_ireq_tuser
);

localparam IDLE = 1'b0;
localparam WAIT_FOR_TLAST = 1'b1;


reg type = 1'b0; // if type_i = 1'b1 : it is ftype-9 packet
reg state = IDLE;

reg [15:0] count_data = 16'h0000;
reg [39:0] last = 40'h0000000000;
reg [15:0] size = 16'h0000;
reg [5:0] count_256 = 6'b000000;
wire count_256_done_i;
wire greater_than_256_i;
wire count_data_greater_256_i;
wire pad_i;
wire odd_i;
reg pad_reg_i = 1'b0;
reg odd_reg_i = 1'b0;

wire [7:0] last_tkeep_i;
reg user_ireq_tready_i = 1'b1;

wire [15:0] actual_size;
assign user_ireq_tready = ((count_data <= 8)|| (count_256 != 6'b011111)) &  ireq_tready;  // assumes tready signal high before tvalid


assign last_tkeep_i = (size[2:0] == 3'b111)? 8'b11111111: (size[2:0] == 3'b110)? 8'b11111100 : (size[2:0] == 3'b101)? 8'b11111100 : (size[2:0] == 3'b100)? 8'b11110000 : (size[2:0] == 3'b011)? 8'b11110000: (size[2:0] == 3'b010)? 8'b11000000 : (size[2:0] ==3'b001) ? 8'b11000000: 8'b11111111;

assign pad_i = (user_ireq_tvalid == 1'b1 && user_ireq_tdata[55:52] == 4'b1001 && ireq_tready == 1'b1 && (user_ireq_tdata[0]));
assign odd_i = (user_ireq_tvalid == 1'b1 && user_ireq_tdata[55:52] == 4'b1001 && ireq_tready == 1'b1 && (^user_ireq_tdata[1:0]));

assign actual_size = user_ireq_tdata[15:0];// + 1'b1;

//assign greater_than_256_i =  user_ireq_tdata[8] || user_ireq_tdata[9] || user_ireq_tdata[10] || user_ireq_tdata[11] || user_ireq_tdata[12] || user_ireq_tdata[13] || user_ireq_tdata[14] || user_ireq_tdata[15];
assign greater_than_256_i = (user_ireq_tdata[15:0] > 'h100)? 1 : 0;

assign count_data_greater_256_i =  (count_data[8] && (count_data[7] || count_data[6] || count_data[5] || count_data[4] || count_data[3] || count_data[2] || count_data[1] || count_data[0])) || count_data[9] || count_data[10] || count_data[11] || count_data[12] || count_data[13] || count_data[14] || count_data[15];
 

always @ (posedge clk)
 begin
  if (reset == 1'b1 || state == IDLE || (count_256 == 6'b100000 && user_ireq_tvalid == 1'b1 && ireq_tready == 1'b1))
   count_256 <= 6'b000000;
  else if(state == WAIT_FOR_TLAST && user_ireq_tvalid == 1'b1 && ireq_tready == 1'b1)
   count_256 <= count_256+1;
  else
   count_256 <= count_256;
 end

assign count_256_done_i = count_256[5];


always @ (posedge clk)
 begin
   if ( reset == 1'b1) 
    begin
          ireq_tvalid        <= 1'b0;
          user_ireq_tready_i <= 1'b0;
          ireq_tlast         <= 1'b0;
          ireq_tdata         <= 64'h0000000000000000;
          ireq_tkeep         <= 8'hFF;
          ireq_tuser         <= 32'hFFFFFFFF;
          state              <= IDLE;
    end
   else
    begin
      case (state)
        IDLE: begin
           if (user_ireq_tvalid == 1'b1 && user_ireq_tdata[55:52] == 4'b1001 && ireq_tready == 1'b1 && user_ireq_tlast == 1'b0 &&  greater_than_256_i == 1'b0) 
             begin
              ireq_tdata          <= {1'b1,1'b1,4'b0000,odd_i,pad_i,user_ireq_tdata[55:16],actual_size};
              ireq_tvalid         <= user_ireq_tvalid;
              ireq_tlast          <= 1'b0;
              user_ireq_tready_i  <= 1'b1;
              ireq_tkeep          <= user_ireq_tkeep;
              ireq_tuser          <= user_ireq_tuser;
              state               <= WAIT_FOR_TLAST;
              count_data          <= user_ireq_tdata[15:0];// + 1'b1;
              last                <= user_ireq_tdata[55:16];
              size                <= user_ireq_tdata[15:0];// + 1'b1;
              pad_reg_i           <=  (user_ireq_tdata[0]);//!user_ireq_tdata[0];
              odd_reg_i           <=  (^user_ireq_tdata[1:0]);//!user_ireq_tdata[1];
              type                <= 1'b1;

             end
           else if (user_ireq_tvalid == 1'b1 && user_ireq_tdata[55:52] == 4'b1001 && ireq_tready == 1'b1 && user_ireq_tlast == 1'b0 && greater_than_256_i == 1'b1) 
             begin
              ireq_tdata          <= {1'b1,1'b0,4'b0000,odd_i,pad_i,user_ireq_tdata[55:16],actual_size};
              count_data          <= user_ireq_tdata[15:0];// + 1'b1;
              last                <= user_ireq_tdata[55:16];
              size                <= user_ireq_tdata[15:0];// + 1'b1;
              ireq_tvalid         <= user_ireq_tvalid;
              user_ireq_tready_i  <= 1'b1;
              ireq_tlast          <= 1'b0;
              ireq_tkeep          <= user_ireq_tkeep;
              ireq_tuser          <= user_ireq_tuser;
              state               <= WAIT_FOR_TLAST;
              pad_reg_i           <=  (user_ireq_tdata[0]);//!user_ireq_tdata[0];
              odd_reg_i           <=  (^user_ireq_tdata[1:0]);//!user_ireq_tdata[1];
              type                <= 1'b1;
             end
           else if (user_ireq_tvalid == 1'b1 && user_ireq_tlast == 1'b1 && ireq_tready == 1'b1) 
            begin     
              ireq_tvalid         <= user_ireq_tvalid;
              user_ireq_tready_i  <= 1'b1;
              ireq_tlast          <= user_ireq_tlast;
              ireq_tdata          <= user_ireq_tdata;
              ireq_tkeep          <= user_ireq_tkeep;
              ireq_tuser          <= user_ireq_tuser;
              state               <= IDLE;
              type                <= 1'b0;
            end
          else if (user_ireq_tvalid == 1'b1 && user_ireq_tlast == 1'b0 && ireq_tready == 1'b1) 
            begin     
              ireq_tvalid         <= user_ireq_tvalid;
              user_ireq_tready_i  <= 1'b1;
              ireq_tlast          <= user_ireq_tlast;
              ireq_tdata          <= user_ireq_tdata;
              ireq_tkeep          <= user_ireq_tkeep;
              ireq_tuser          <= user_ireq_tuser;
              state               <= WAIT_FOR_TLAST;
              type                <= 1'b0;
            end
         else if (ireq_tready == 1'b0) 
            begin     
              ireq_tvalid         <= ireq_tvalid;
              user_ireq_tready_i  <= user_ireq_tready_i;
              ireq_tlast          <= ireq_tlast;
              ireq_tdata          <= ireq_tdata;
              ireq_tkeep          <= ireq_tkeep;
              ireq_tuser          <= ireq_tuser;
              state               <= state;
              type                <= type;
             end
         else  
            begin     
              ireq_tvalid         <= user_ireq_tvalid;
              user_ireq_tready_i  <= ireq_tready;
              ireq_tlast          <= user_ireq_tlast;
              ireq_tdata          <= user_ireq_tdata;
              ireq_tkeep          <= user_ireq_tkeep;
              ireq_tuser          <= user_ireq_tuser;
              state               <= IDLE;
              type                <= 1'b0;
             end
         end
        
       WAIT_FOR_TLAST: begin
        if(type ==  1'b1) begin
          if (user_ireq_tvalid == 1'b1 && ireq_tready == 1'b1 && count_256_done_i == 1'b1 && count_data_greater_256_i == 1'b0 ) 
            begin
              ireq_tdata           <= {1'b0,1'b1,4'b0000,odd_reg_i,pad_reg_i,last,size};
              ireq_tvalid          <= user_ireq_tvalid;
              user_ireq_tready_i   <= 1'b1;
              ireq_tlast           <= 1'b0;
              ireq_tkeep           <= user_ireq_tkeep;
              ireq_tuser           <= user_ireq_tuser;
              state                <= WAIT_FOR_TLAST;
            end
          else if (user_ireq_tvalid == 1'b1 && ireq_tready == 1'b1 && count_256_done_i == 1'b1 && count_data_greater_256_i == 1'b1 ) 
            begin
              ireq_tdata           <= {1'b0,1'b0,4'b0000,odd_reg_i,pad_reg_i,last,size};
              ireq_tvalid          <= user_ireq_tvalid;
              user_ireq_tready_i   <= 1'b1;
              ireq_tlast           <= 1'b0;
              ireq_tkeep           <= user_ireq_tkeep;
              ireq_tuser           <= user_ireq_tuser;
              state                <= WAIT_FOR_TLAST;
            end
          else if (user_ireq_tvalid == 1'b1 && ireq_tready == 1'b1 && (count_256_done_i == 1'b0 || count_data <= 8) ) 
            begin
              if(user_ireq_tlast == 1'b1) 
                 begin
                  state            <= IDLE;
                  ireq_tkeep       <= last_tkeep_i;
                 end
               else 
                 begin
                  state            <= WAIT_FOR_TLAST;
                  ireq_tkeep       <= user_ireq_tkeep;
                 end
              ireq_tvalid          <= user_ireq_tvalid;
              user_ireq_tready_i   <= 1'b1;
                if (count_256 == 6'b011111)  begin
                      ireq_tlast           <= 1'b1;
                      user_ireq_tready_i   <= 1'b0;
                 end    
                else begin
                     ireq_tlast           <= user_ireq_tlast;
                     user_ireq_tready_i   <= 1'b1;
                 end    
              ireq_tdata           <= user_ireq_tdata;
              ireq_tuser           <= user_ireq_tuser;
              if (count_data > 8 )count_data           <= count_data-8;
            end
          else if (ireq_tready == 1'b0) 
            begin
              ireq_tdata           <= ireq_tdata;
              ireq_tvalid          <= ireq_tvalid;
              user_ireq_tready_i   <= user_ireq_tready_i;
              ireq_tlast           <= ireq_tlast;
              ireq_tkeep           <= ireq_tkeep;
              ireq_tuser           <= ireq_tuser;
              state                <= WAIT_FOR_TLAST;
            end
          else
             begin
              ireq_tvalid          <= user_ireq_tvalid;
              user_ireq_tready_i   <= 1'b1;
              ireq_tlast           <= user_ireq_tlast;
              ireq_tdata           <= user_ireq_tdata;
              ireq_tkeep           <= user_ireq_tkeep;
              ireq_tuser           <= user_ireq_tuser;
              state                <= state;
             end
         end
       else
          begin
           if (ireq_tready == 1'b0) 
            begin
              ireq_tdata           <= ireq_tdata;
              ireq_tvalid          <= ireq_tvalid;
              user_ireq_tready_i   <= user_ireq_tready_i;
              ireq_tlast           <= ireq_tlast;
              ireq_tkeep           <= ireq_tkeep;
              ireq_tuser           <= ireq_tuser;
              state                <= WAIT_FOR_TLAST;
            end
           else 
             begin
              ireq_tvalid         <= user_ireq_tvalid;
              user_ireq_tready_i  <= ireq_tready;
              ireq_tlast          <= user_ireq_tlast;
              ireq_tdata          <= user_ireq_tdata;
              ireq_tkeep          <= user_ireq_tkeep;
              ireq_tuser          <= user_ireq_tuser;
              if(user_ireq_tlast == 1'b1) 
                 begin
                  state            <= IDLE;
                 end
               else 
                 begin
                  state            <= WAIT_FOR_TLAST;
                 end
          end 
        end   
       end
      default: begin
              ireq_tvalid          <= user_ireq_tvalid;
              user_ireq_tready_i   <= 1'b1;
              ireq_tlast           <= user_ireq_tlast;
              ireq_tdata           <= user_ireq_tdata;
              ireq_tkeep           <= user_ireq_tkeep;
              ireq_tuser           <= user_ireq_tuser;
              state                <= IDLE;
        end
     endcase
    end 
 end
   
endmodule


// {{{ DISCLAIMER OF LIABILITY
// -----------------------------------------------------------------
// (c) Copyright 2010-2011 Xilinx, Inc. All rights reserved.
//
// This file contains confidential and proprietary information
// of Xilinx, Inc. and is protected under U.S. and
// international copyright and other intellectual property
// laws.
//
// DISCLAIMER
// This disclaimer is not a license and does not grant any
// rights to the materials distributed herewith. Except as
// otherwise provided in a valid license issued to you by
// Xilinx, and to the maximum extent permitted by applicable
// law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
// WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
// AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
// BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
// INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
// (2) Xilinx shall not be liable (whether in contract or tort,
// including negligence, or under any other theory of
// liability) for any loss or damage of any kind or nature
// related to, arising under or in connection with these
// materials, including for any direct, or any indirect,
// special, incidental, or consequential loss or damage
// (including loss of data, profits, goodwill, or any type of
// loss or damage suffered as a result of any action brought
// by a third party) even if such damage or loss was
// reasonably foreseeable or Xilinx had been advised of the
// possibility of the same.
//
// CRITICAL APPLICATIONS
// Xilinx products are not designed or intended to be fail-
// safe, or for use in any application requiring fail-safe
// performance, such as life-support or safety devices or
// systems, Class III medical devices, nuclear facilities,
// applications related to the deployment of airbags, or any
// other applications that could lead to death, personal
// injury, or severe property or environmental damage
// (individually and collectively, "Critical
// Applications"). Customer assumes the sole risk and
// liability of any use of Xilinx products in Critical
// Applications, subject only to applicable laws and
// regulations governing limitations on product liability.
//
// THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
// PART OF THIS FILE AT ALL TIMES.
// }}}

