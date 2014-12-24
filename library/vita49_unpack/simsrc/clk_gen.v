
`timescale 1ns/100ps

module clk_gen(
	reset_n,
	axi_clk,
	axi_aresetn,
	axis_clk,
	axis_aresetn,
	pps_clk,
	samp_clk
);
parameter axi_pw  = 20;
parameter axis_pw = 10;
parameter pps_pw  = 1000;
parameter samp_pw = 10;

input reset_n;
output axi_clk;
output axi_aresetn;
output axis_clk;
output axis_aresetn;
output pps_clk;
output samp_clk;


reg axi_clk;
reg axi_aresetn;
reg axis_clk;
reg axis_aresetn;
reg pps_clk;
reg samp_clk;

initial
begin
	axi_aresetn  = 1'b0;
	axis_aresetn = 1'b0;
	#5000 axi_aresetn  = 1'b1;
	#5000 axis_aresetn = 1'b1;
end

initial
begin
	axi_clk  = 0;
	forever #(axi_pw)  axi_clk = ~axi_clk;
end

initial
begin
	axis_clk = 0;
	forever #(axis_pw) axis_clk = ~axis_clk;
end

initial
begin
	pps_clk  = 0;
	forever #(pps_pw)  pps_clk = ~pps_clk;
end

initial
begin
	samp_clk = 0;
	forever #(samp_pw) samp_clk = ~samp_clk;
end




endmodule