//Copyright (C)2014-2024 GOWIN Semiconductor Corporation.
//All rights reserved.
//File Title: Timing Constraints file
//Tool Version: V1.9.9 (64-bit) 
//Created Time: 2024-01-25 12:29:57
create_clock -name clk -period 20 -waveform {0 10} [get_ports {clk}]
create_clock -name tck -period 100 -waveform {0 50} [get_ports {jtag_tck}]
set_false_path -from [get_clocks {clk}] -to [get_clocks {tck}] 
set_false_path -from [get_clocks {tck}] -to [get_clocks {clk}] 
