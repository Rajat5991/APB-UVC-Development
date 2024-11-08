`ifndef APB_SMON
`define APB_SMON
`include "apb_packet.sv"

class apb_smonitor extends uvm_monitor;
  `uvm_component_utils(apb_smonitor)
  
  function new(input string name, input uvm_component parent);
    super.new(name,parent);
     ap_mon = new("ap_mon",this);
  endfunction
  
  virtual apb_interface.slave_mon ap_if;
  uvm_analysis_port #(apb_packet) ap_mon;
  apb_packet pkt;
  
  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
   
    if(!uvm_config_db #(virtual apb_interface.slave_mon) :: get(this,"","apb_pif",ap_if))
       `uvm_fatal("DRV_ERROR","CANNOT GET THE INTERFACE HANDLE");
  endfunction
       
 virtual task run_phase(uvm_phase phase);
   forever
     begin
       @(posedge ap_if.pclk);
       if(ap_if.mon_cb.pready && ap_if.mon_cb.penable)
         begin
          pkt = apb_packet :: type_id :: create("pkt");
          pkt.addr = ap_if.mon_cb.paddr;
          pkt.wr_rd = ap_if.mon_cb.pwrite;
          if(ap_if.mon_cb.pwrite)
            pkt.data = ap_if.mon_cb.pwdata; // read pwdata
          else
            pkt.data = ap_if.mon_cb.prdata; // read prdata
          ap_mon.write(pkt);
         end
        
     end      
         
 endtask
       
       
 endclass

`endif
