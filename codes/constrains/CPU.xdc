# System Clock
create_clock -period 10.000 -name CLK -waveform {0.000 5.000} [get_ports clk]
set_property -dict {PACKAGE_PIN P17 IOSTANDARD LVCMOS33} [get_ports {clk}]

# reset
set_property -dict {PACKAGE_PIN U4 IOSTANDARD LVCMOS33} [get_ports {reset}]

# BCD7 output
set_property -dict {PACKAGE_PIN G2 IOSTANDARD LVCMOS33} [get_ports {BCD7[11]}]
set_property -dict {PACKAGE_PIN C2 IOSTANDARD LVCMOS33} [get_ports {BCD7[10]}]
set_property -dict {PACKAGE_PIN C1 IOSTANDARD LVCMOS33} [get_ports {BCD7[9]}]
set_property -dict {PACKAGE_PIN H1 IOSTANDARD LVCMOS33} [get_ports {BCD7[8]}]
set_property -dict {PACKAGE_PIN D5 IOSTANDARD LVCMOS33} [get_ports {BCD7[7]}]
set_property -dict {PACKAGE_PIN B2 IOSTANDARD LVCMOS33} [get_ports {BCD7[6]}]
set_property -dict {PACKAGE_PIN B3 IOSTANDARD LVCMOS33} [get_ports {BCD7[5]}]
set_property -dict {PACKAGE_PIN A1 IOSTANDARD LVCMOS33} [get_ports {BCD7[4]}]
set_property -dict {PACKAGE_PIN B1 IOSTANDARD LVCMOS33} [get_ports {BCD7[3]}]
set_property -dict {PACKAGE_PIN A3 IOSTANDARD LVCMOS33} [get_ports {BCD7[2]}]
set_property -dict {PACKAGE_PIN A4 IOSTANDARD LVCMOS33} [get_ports {BCD7[1]}]
set_property -dict {PACKAGE_PIN B4 IOSTANDARD LVCMOS33} [get_ports {BCD7[0]}]