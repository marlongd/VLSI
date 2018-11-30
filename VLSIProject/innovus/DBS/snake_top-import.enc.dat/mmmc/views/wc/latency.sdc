set_clock_latency -source -early -max -rise  -1.51012 [get_ports {clk}] -clock clk 
set_clock_latency -source -early -max -fall  -1.32174 [get_ports {clk}] -clock clk 
set_clock_latency -source -late -max -rise  -1.51012 [get_ports {clk}] -clock clk 
set_clock_latency -source -late -max -fall  -1.32174 [get_ports {clk}] -clock clk 
