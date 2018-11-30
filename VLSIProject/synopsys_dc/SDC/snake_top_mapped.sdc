###################################################################

# Created by write_sdc on Thu Nov 29 19:16:23 2018

###################################################################
set sdc_version 2.0

set_units -time ns -resistance kOhm -capacitance pF -voltage V -current mA
set_max_area 0
create_clock [get_ports clk]  -period 20  -waveform {0 10}
