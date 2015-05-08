#hdl

SBT projects are built based on the Analog Devices HDL libraries and projects and their directory structure.
Only Vivado 2014.2 is currently supported.

To build the PL images, the libraries must first be built before the project is built.  Detailed steps can be found in the ADI HDL user guide:

<http://wiki.analog.com/resources/fpga/docs/hdl>

For support please visit our FPGA Reference Designs Support Community on EngineerZone:

<http://ez.analog.com/community/fpga>

# SBT Projects

## sdrdc_2chan
Project for the SDRDC board - actively developed

### Library cores
- axi_ad9361
- util_adc\_pack
- util_dac\_unpack
- axis2adi
- adi2axis
- axis_64to32
- axis_32to64
- vita49_clk
- vita49_trig
- axis_vita49\_pack
- axis_vita49\_unpack


## tdsdr_2chan
Project for the TDSDR board - port of SDRDC v1.0 design

### Library cores
- axi_ad9361
- axi_dmac 
- util_dac\_unpack 
- util_adc\_pack
- sys_reg 
- axis_64to32\_strb\_tuser 
- axis_32to64\_strb\_tuser 


## tdsdr_2chan_srio6
Project for the TDSDR board - development project to add features such as VITA49 and SRIO

### Library cores
- axi_ad9361
- util_dac\_unpack 
- util_adc\_pack
- adi2axis
- axis2adi
- axis_32to64
- axis_32to64\_strb\_tuser
- axis_64to32
- axis_64to32\_strb\_tuser
- axis_vita49\_pack
- axis_vita49\_unpack
- hello_router
- srio_swrite\_pack
- srio_swrite\_unpack
- sys_reg
- vita49_assem
- vita49_clk
- vita49_trig


