## This file is a general .xdc for the Basys3 rev B board
## To use it in a project:
## - uncomment the lines corresponding to used pins
## - rename the used ports (in each line, after get_ports) according to the top level signal names in the project

# Clock signal
#Bank = 34, Pin name = ,					Sch name = CLK100MHZ
		set_property PACKAGE_PIN W5 [get_ports clk]
		set_property IOSTANDARD LVCMOS33 [get_ports clk]
		create_clock -period 10.000 -name sys_clk_pin -waveform {0.000 5.000} -add [get_ports clk]

# Switches
set_property PACKAGE_PIN R2 [get_ports reset]
set_property IOSTANDARD LVCMOS33 [get_ports reset]

set_property PACKAGE_PIN T1 [get_ports tx_en]
set_property IOSTANDARD LVCMOS33 [get_ports tx_en]

set_property PACKAGE_PIN U1 [get_ports rx_en]
set_property IOSTANDARD LVCMOS33 [get_ports rx_en]

##16 segment
set_property PACKAGE_PIN U16 [get_ports LED[1]]					
set_property IOSTANDARD LVCMOS33 [get_ports LED[1]]

set_property PACKAGE_PIN E19 [get_ports LED[2]]					
	set_property IOSTANDARD LVCMOS33 [get_ports LED[2]]

set_property PACKAGE_PIN U19 [get_ports LED[3]]					
	set_property IOSTANDARD LVCMOS33 [get_ports LED[3]]

set_property PACKAGE_PIN V19 [get_ports LED[4]]					
	set_property IOSTANDARD LVCMOS33 [get_ports LED[4]]

set_property PACKAGE_PIN W18 [get_ports LED[5]]					
	set_property IOSTANDARD LVCMOS33 [get_ports LED[5]]

set_property PACKAGE_PIN U15 [get_ports LED[6]]					
	set_property IOSTANDARD LVCMOS33 [get_ports LED[6]]

set_property PACKAGE_PIN U14 [get_ports LED[7]]					
	set_property IOSTANDARD LVCMOS33 [get_ports LED[7]]

set_property PACKAGE_PIN V14 [get_ports LED[8]]					
	set_property IOSTANDARD LVCMOS33 [get_ports LED[8]]

##USB-RS232 Interface
    ##Bank = 16, Pin name = , Sch name = UART_TXD_IN
    set_property PACKAGE_PIN B18 [get_ports rx_in]
    set_property IOSTANDARD LVCMOS33 [get_ports rx_in]
    #Bank = 16, Pin name = , Sch name = UART_RXD_OUT
    set_property PACKAGE_PIN A18 [get_ports tx_out]
    set_property IOSTANDARD LVCMOS33 [get_ports tx_out]
                                        
# Others (BITSTREAM, CONFIG)
set_property BITSTREAM.GENERAL.COMPRESS TRUE [current_design]
set_property BITSTREAM.CONFIG.SPI_BUSWIDTH 4 [current_design]
set_property CONFIG_MODE SPIx4 [current_design]

set_property BITSTREAM.CONFIG.CONFIGRATE 33 [current_design]

set_property CONFIG_VOLTAGE 3.3 [current_design]
set_property CFGBVS VCCO [current_design]





