`ifndef APB_ENV
`define APB_ENV


`include "apb_macros.sv"
`include "apb_magent.sv"
`include "apb_sagent.sv"
`include "apb_coverage.sv"
`include "apb_scoreboard.sv"

class apb_environment extends uvm_env;
  `uvm_component_utils(apb_environment)
  `APB_COM
  
  apb_magent magent;
  apb_sagent sagent;
  apb_scoreboard apbs;
  apb_cov cov;
  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    cov = apb_cov :: type_id :: create("cov",this);
    magent = apb_magent :: type_id :: create("magent",this);
    sagent = apb_sagent :: type_id :: create("sagent",this); 
    apbs = apb_scoreboard :: type_id :: create("apbs", this);
  endfunction
  
  virtual function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    magent.apb_mmon.ap_mon.connect(apbs.aport_mmon);
    sagent.apb_smon.ap_mon.connect(apbs.aport_smon);
    magent.apb_mmon.ap_mon.connect(cov.analysis_export);
   
  endfunction
  
endclass

`endif
  
  
  
