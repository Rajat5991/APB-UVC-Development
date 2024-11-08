`ifndef MON_DRV
`define MON_DRV

class apb_mdriver extends uvm_driver#(apb_packet);
  `uvm_component_utils(apb_mdriver)
  `APB_COM
  
  virtual apb_interface.master_driver ap_mif;
  
  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db #(virtual apb_interface.master_driver) :: get(this,"","apb_mif",ap_mif))
      `uvm_fatal("DRV_ERROR","CANNOT GET THE MASTER DRIVER INTERFACE HANDLE");
  endfunction
  
   
  virtual task run_phase(uvm_phase phase);
    forever
       begin
         seq_item_port.get_next_item(req);
         req.print();
         `uvm_info("DEBUG",$sformatf("slect value is %b",req.sel),UVM_LOW);
         drive_pkt(req);
         seq_item_port.item_done();
       end
  endtask
   
  virtual task drive_pkt(apb_packet pkt);
    //`uvm_info("DEBUG",$sformatf("wait to Enter to drive pkt pclk = $d",ap_mif.pclk),UVM_LOW);
    @(posedge ap_mif.pclk);
    //`uvm_info("DEBUG",$sformatf("Entered to drive pkt"),UVM_LOW);
    ap_mif.master_cb.paddr <= pkt.addr;
    if( pkt.wr_rd == 1'b1)  ap_mif.master_cb.pwdata <= pkt.data;
    ap_mif.master_cb.pwrite <= pkt.wr_rd;
    ap_mif.master_cb.psel <= pkt.sel;
    ap_mif.master_cb.penable <= 1;
    //`uvm_info("DEBUG",$sformatf("wait for pready to be enabled"),UVM_LOW);
    wait(ap_mif.master_cb.pready == 1);
    `uvm_info("DEBUG",$sformatf("pready is enabled"),UVM_LOW);
    @(posedge ap_mif.pclk);
    ap_mif.master_cb.paddr <= 0;
    ap_mif.master_cb.pwdata <= 0;
    ap_mif.master_cb.pwrite <= 0;
    ap_mif.master_cb.psel <= 0;
    ap_mif.master_cb.penable <= 0;
      
  endtask
      
  
 endclass
`endif
  
