//`include "apb_smonitor.sv"

`ifndef APB_SAGENT
`define APB_SAGENT
`include "apb_responder.sv"
`include "apb_smonitor.sv"



class apb_sagent extends uvm_agent;
  `uvm_component_utils(apb_sagent)
  `APB_COM
  
  apb_smonitor apb_smon;
  apb_responder responder;
  
  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    apb_smon = apb_smonitor :: type_id :: create("apb_smon",this);
    responder = apb_responder :: type_id :: create("responder",this);
  endfunction
  
  
  
endclass

`endif
