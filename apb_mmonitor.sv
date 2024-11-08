`ifndef APB_MMON
`define APB_MMON
`include "apb_packet.sv"

class apb_mmonitor extends uvm_monitor;
  `uvm_component_utils(apb_mmonitor)
  
  
  virtual apb_interface.master_mon ap_if;
  uvm_analysis_port #(apb_packet) ap_mon;
  apb_packet pkt;
  
  function new(input string name, input uvm_component parent);
    super.new(name,parent);
     ap_mon = new("ap_mon",this);
  endfunction
  
  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
   
    if(!uvm_config_db #(virtual apb_interface.master_mon) :: get(this,"","apb_mmif",ap_if))
       `uvm_fatal("DRV_ERROR","CANNOT GET THE INTERFACE HANDLE");
  endfunction
       
 virtual task run_phase(uvm_phase phase);
   forever
     begin
       @(posedge ap_if.pclk);
       if(ap_if.m_cb.pready && ap_if.m_cb.penable)
         begin
          pkt = apb_packet :: type_id :: create("pkt");
          pkt.addr = ap_if.m_cb.paddr;
          pkt.wr_rd = ap_if.m_cb.pwrite;
          if(ap_if.m_cb.pwrite)
            pkt.data = ap_if.m_cb.pwdata; // read pwdata
          else
            pkt.data = ap_if.m_cb.prdata; // read prdata
          ap_mon.write(pkt);
         end
        
     end      
         
 endtask
       
       
 endclass

`endif
