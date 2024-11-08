`ifndef APB_RES
`define APB_RES

class apb_responder extends uvm_component;
  `uvm_component_utils(apb_responder)
  `APB_COM
  
   virtual apb_interface.slave_driver ap_sif;
  bit [31:0] apb_data[int];
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db #(virtual apb_interface.slave_driver) :: get(this,"","apb_sif",ap_sif))
       `uvm_fatal("DRV_ERROR","CANNOT GET THE INTERFACE HANDLE");
  endfunction
       
   virtual task run_phase(uvm_phase phase);
     forever
       begin
         //`uvm_info("DEBUG",$sformatf("NOT Entered slave"),UVM_LOW);
         @(posedge ap_sif.pclk);
         //`uvm_info("DEBUG",$sformatf("Entered slave"),UVM_LOW);
         if(ap_sif.slave_cb.psel && ap_sif.slave_cb.penable)
           begin
            // `uvm_info("DEBUG",$sformatf("pready is set to enable from slave"),UVM_LOW);
             ap_sif.slave_cb.pready <= 1;
             ap_sif.slave_cb.presp <= 0;
             if(ap_sif.slave_cb.pwrite == 1)
               apb_data[ap_sif.slave_cb.paddr] <= ap_sif.slave_cb.pwdata;
             else
               ap_sif.slave_cb.prdata <= apb_data[ap_sif.slave_cb.paddr];
               ap_sif.slave_cb.presp <= 1;
           end
          else
            begin
             ap_sif.slave_cb.pready <= 0;
             ap_sif.slave_cb.prdata <= 0;
              ap_sif.slave_cb.presp <= 0;
            end
       end
   endtask
       
endclass

`endif
       
