create_ip -name axi_uartlite -vendor xilinx.com -library ip -version 2.0 -module_name axi_uartlite_0 
set_property -dict [list \
  CONFIG.C_BAUDRATE {115200} \
  CONFIG.C_S_AXI_ACLK_FREQ_HZ_d {250} \
] [get_ips axi_uartlite_0]
