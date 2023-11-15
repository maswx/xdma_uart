//========================================================================
//        author   : masw
//        email    : masw@masw.tech     
//        creattime: 2023年11月15日 星期三 23时35分09秒
//========================================================================


module xdma_uart_top (
	input           pcie_ref_clk_p ,
	input           pcie_ref_clk_n ,
	input  [  15:0] pcie_lane_rxp  ,
	input  [  15:0] pcie_lane_rxn  ,
	output [  15:0] pcie_lane_txp  ,
	output [  15:0] pcie_lane_txn  ,
	input           pcie_perst_n   ,
	output          pcie_link_up   

);
wire         interrupt   ;
wire         axi_aclk    ;
wire         axi_aresetn ;

wire [31 : 0] axil_awaddr   ;
wire          axil_awvalid  ;
wire          axil_awready  ;
wire [31 : 0] axil_wdata    ;
wire [ 3 : 0] axil_wstrb    ;
wire          axil_wvalid   ;
wire          axil_wready   ;
wire          axil_bvalid   ;
wire [ 1 : 0] axil_bresp    ;
wire          axil_bready   ;
wire [31 : 0] axil_araddr   ;
wire          axil_arvalid  ;
wire          axil_arready  ;
wire [31 : 0] axil_rdata    ;
wire [ 1 : 0] axil_rresp    ;
wire          axil_rvalid   ;
wire          axil_rready   ;

wire pcie_sys_clk   ;
wire pcie_sys_clk_gt;
IBUFDS_GTE4 #(
    .REFCLK_HROW_CK_SEL(2'b00)
) ibufds_gte4_pcie_mgt_refclk_inst (
    .I             (pcie_ref_clk_p ),
    .IB            (pcie_ref_clk_n ),
    .CEB           (1'b0           ),
    .O             (pcie_sys_clk_gt),
    .ODIV2         (pcie_sys_clk   )
);

xdma_0 xdma_0_inst(
	.sys_clk              (pcie_sys_clk         ),// input  wire sys_clk
	.sys_clk_gt           (pcie_sys_clk_gt      ),// input  wire sys_clk_gt
	.sys_rst_n            (pcie_perst_n         ),// input  wire sys_rst_n
	.user_lnk_up          (pcie_link_up         ),// output wire user_lnk_up
	.pci_exp_txp          (pcie_lane_txp        ),// output wire [15 : 0] pci_exp_txp
	.pci_exp_txn          (pcie_lane_txn        ),// output wire [15 : 0] pci_exp_txn
	.pci_exp_rxp          (pcie_lane_rxp        ),// input  wire [15 : 0] pci_exp_rxp
	.pci_exp_rxn          (pcie_lane_rxn        ),// input  wire [15 : 0] pci_exp_rxn
    .axi_aclk             (axi_aclk             ),// output wire axi_aclk
    .axi_aresetn          (axi_aresetn          ),// output wire axi_aresetn
    .usr_irq_req          (interrupt            ),// input  wire [1 : 0] usr_irq_req
    .usr_irq_ack          (                     ),// output wire [1 : 0] usr_irq_ack
    .msi_enable           (                     ),// output wire msi_enable
    .msi_vector_width     (                     ),// output wire [2 : 0] msi_vector_width
    .m_axi_awready        (  1'd1               ),// input  wire m_axi_awready
    .m_axi_wready         (  1'd1               ),// input  wire m_axi_wready
    .m_axi_bid            (  4'd0               ),// input  wire [3 : 0] m_axi_bid
    .m_axi_bresp          (  2'd0               ),// input  wire [1 : 0] m_axi_bresp
    .m_axi_bvalid         (  1'd0               ),// input  wire m_axi_bvalid
    .m_axi_arready        (  1'd1               ),// input  wire m_axi_arready
    .m_axi_rid            (  4'd0               ),// input  wire [3 : 0] m_axi_rid
    .m_axi_rdata          (512'd0               ),// input  wire [511 : 0] m_axi_rdata
    .m_axi_rresp          (  2'd0               ),// input  wire [1 : 0] m_axi_rresp
    .m_axi_rlast          (  1'd0               ),// input  wire m_axi_rlast
    .m_axi_rvalid         (  1'd0               ),// input  wire m_axi_rvalid
    .m_axi_awid           (                     ),// output wire [3 : 0] m_axi_awid
    .m_axi_awaddr         (                     ),// output wire [63 : 0] m_axi_awaddr
    .m_axi_awlen          (                     ),// output wire [7 : 0] m_axi_awlen
    .m_axi_awsize         (                     ),// output wire [2 : 0] m_axi_awsize
    .m_axi_awburst        (                     ),// output wire [1 : 0] m_axi_awburst
    .m_axi_awprot         (                     ),// output wire [2 : 0] m_axi_awprot
    .m_axi_awvalid        (                     ),// output wire m_axi_awvalid
    .m_axi_awlock         (                     ),// output wire m_axi_awlock
    .m_axi_awcache        (                     ),// output wire [3 : 0] m_axi_awcache
    .m_axi_wdata          (                     ),// output wire [511 : 0] m_axi_wdata
    .m_axi_wstrb          (                     ),// output wire [63 : 0] m_axi_wstrb
    .m_axi_wlast          (                     ),// output wire m_axi_wlast
    .m_axi_wvalid         (                     ),// output wire m_axi_wvalid
    .m_axi_bready         (                     ),// output wire m_axi_bready
    .m_axi_arid           (                     ),// output wire [3 : 0] m_axi_arid
    .m_axi_araddr         (                     ),// output wire [63 : 0] m_axi_araddr
    .m_axi_arlen          (                     ),// output wire [7 : 0] m_axi_arlen
    .m_axi_arsize         (                     ),// output wire [2 : 0] m_axi_arsize
    .m_axi_arburst        (                     ),// output wire [1 : 0] m_axi_arburst
    .m_axi_arprot         (                     ),// output wire [2 : 0] m_axi_arprot
    .m_axi_arvalid        (                     ),// output wire m_axi_arvalid
    .m_axi_arlock         (                     ),// output wire m_axi_arlock
    .m_axi_arcache        (                     ),// output wire [3 : 0] m_axi_arcache
    .m_axi_rready         (                     ),// output wire m_axi_rready
    .m_axil_awaddr        (  axil_awaddr        ),// output wire [31 : 0] m_axil_awaddr
    .m_axil_awprot        (                     ),// output wire [2 : 0] m_axil_awprot
    .m_axil_awvalid       (  axil_awvalid       ),// output wire m_axil_awvalid
    .m_axil_awready       (  axil_awready       ),// input  wire m_axil_awready
    .m_axil_wdata         (  axil_wdata         ),// output wire [31 : 0] m_axil_wdata
    .m_axil_wstrb         (  axil_wstrb         ),// output wire [3 : 0] m_axil_wstrb
    .m_axil_wvalid        (  axil_wvalid        ),// output wire m_axil_wvalid
    .m_axil_wready        (  axil_wready        ),// input  wire m_axil_wready
    .m_axil_bvalid        (  axil_bvalid        ),// input  wire m_axil_bvalid
    .m_axil_bresp         (  axil_bresp         ),// input  wire [1 : 0] m_axil_bresp
    .m_axil_bready        (  axil_bready        ),// output wire m_axil_bready
    .m_axil_araddr        (  axil_araddr        ),// output wire [31 : 0] m_axil_araddr
    .m_axil_arprot        (                     ),// output wire [2 : 0] m_axil_arprot
    .m_axil_arvalid       (  axil_arvalid       ),// output wire m_axil_arvalid
    .m_axil_arready       (  axil_arready       ),// input  wire m_axil_arready
    .m_axil_rdata         (  axil_rdata         ),// input  wire [31 : 0] m_axil_rdata
    .m_axil_rresp         (  axil_rresp         ),// input  wire [1 : 0] m_axil_rresp
    .m_axil_rvalid        (  axil_rvalid        ),// input  wire m_axil_rvalid
    .m_axil_rready        (  axil_rready        ) // output wire m_axil_rready
);

wire xx;
axi_uartlite_0 axi_uartlite_0_inst          (
  .s_axi_aclk          (  axi_aclk          ),// input  wire s_axi_aclk
  .s_axi_aresetn       (  axi_aresetn       ),// input  wire s_axi_aresetn
  .interrupt           (interrupt           ),// output wire interrupt
  .s_axi_awaddr        (  axil_awaddr        ),// input  wire [3 : 0] s_axi_awaddr
  .s_axi_awvalid       (  axil_awvalid       ),// input  wire s_axi_awvalid
  .s_axi_awready       (  axil_awready       ),// output wire s_axi_awready
  .s_axi_wdata         (  axil_wdata         ),// input  wire [31 : 0] s_axi_wdata
  .s_axi_wstrb         (  axil_wstrb         ),// input  wire [3 : 0] s_axi_wstrb
  .s_axi_wvalid        (  axil_wvalid        ),// input  wire s_axi_wvalid
  .s_axi_wready        (  axil_wready        ),// output wire s_axi_wready
  .s_axi_bresp         (  axil_bresp         ),// output wire [1 : 0] s_axi_bresp
  .s_axi_bvalid        (  axil_bvalid        ),// output wire s_axi_bvalid
  .s_axi_bready        (  axil_bready        ),// input  wire s_axi_bready
  .s_axi_araddr        (  axil_araddr        ),// input  wire [3 : 0] s_axi_araddr
  .s_axi_arvalid       (  axil_arvalid       ),// input  wire s_axi_arvalid
  .s_axi_arready       (  axil_arready       ),// output wire s_axi_arready
  .s_axi_rdata         (  axil_rdata         ),// output wire [31 : 0] s_axi_rdata
  .s_axi_rresp         (  axil_rresp         ),// output wire [1 : 0] s_axi_rresp
  .s_axi_rvalid        (  axil_rvalid        ),// output wire s_axi_rvalid
  .s_axi_rready        (  axil_rready        ),// input  wire s_axi_rready
  .rx                  (xx                  ),// input  wire rx
  .tx                  (xx                  ) // output wire tx
);


endmodule
