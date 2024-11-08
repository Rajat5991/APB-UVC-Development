`ifndef APB_MAGENT
`define APB_MAGENT

`include "apb_packet.sv"
`include "apb_mdriver.sv"
`include "apb_mmonitor.sv"

typedef uvm_sequencer#(apb_packet) apb_sequencer;

class apb_magent extends uvm_agent;
  `uvm_component_utils(apb_magent)
  `APB_COM
  
  apb_mmonitor apb_mmon;
  apb_mdriver apb_mdrv;
  apb_sequencer apb_seqr;
  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    apb_mmon = apb_mmonitor :: type_id :: create("apb_mmon",this);
    apb_mdrv = apb_mdriver :: type_id :: create("apb_mdrv",this);
    apb_seqr = apb_sequencer :: type_id :: create("apb_seqr",this);
  endfunction
  
  virtual function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    apb_mdrv.seq_item_port.connect(apb_seqr.seq_item_export);
  endfunction
  
endclass

`endif

