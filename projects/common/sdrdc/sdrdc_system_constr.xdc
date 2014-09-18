
# constraints

# clocks

create_clock -name cpu_clk      -period 10.00 [get_pins i_system_wrapper/system_i/sys_ps7/FCLK_CLK0]
create_clock -name m200_clk     -period  5.00 [get_pins i_system_wrapper/system_i/sys_ps7/FCLK_CLK1]

set_clock_groups -asynchronous -group {cpu_clk}
set_clock_groups -asynchronous -group {m200_clk}


