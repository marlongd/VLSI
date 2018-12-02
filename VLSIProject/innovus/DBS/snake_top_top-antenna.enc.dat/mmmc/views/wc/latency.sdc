set_clock_latency -source -early -max -rise  -1.0216 [get_ports {clk}] -clock clk 
set_clock_latency -source -early -max -fall  -0.903526 [get_ports {clk}] -clock clk 
set_clock_latency -source -late -max -rise  -1.0216 [get_ports {clk}] -clock clk 
set_clock_latency -source -late -max -fall  -0.903526 [get_ports {clk}] -clock clk 
