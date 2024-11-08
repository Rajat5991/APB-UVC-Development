`ifndef APB_TEST
`define APB_TEST
`include "apb_common.sv"
`include "apb_environment.sv"
`include "apb_sequence.sv"


class apb_base_test extends uvm_test;
  `uvm_component_utils(apb_base_test)
  `APB_COM
 
  
  
  apb_environment env;
  
  virtual function void build_phase(input uvm_phase phase);
    super.build_phase(phase);
    env = apb_environment :: type_id :: create("env",this);
  endfunction
  
  
  virtual function void end_of_elaboration_phase(input uvm_phase phase);
    super.end_of_elaboration_phase(phase);
    uvm_top.print_topology();
  endfunction
endclass

class apb_wr_rd_test extends apb_base_test;
  `uvm_component_utils(apb_wr_rd_test)
  `APB_COM
  
 // apb_sequence wr_rd_seq;
  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    apb_common :: total_pkt_count = 5;
    uvm_config_db #(uvm_object_wrapper) :: set(this,"env.magent.apb_seqr.run_phase","default_sequence", apb_five_read_write_sequence::get_type());
  endfunction
  
 /* virtual task run_phase(uvm_phase phase);
    wr_rd_seq = apb_sequence :: type_id :: create("wr_rd_seq");
    phase.raise_objection(this);
    wr_rd_seq.start(env.magent.apb_seqr);
    phase.drop_objection(this);
  endtask
  */
  virtual function void report_phase(uvm_phase phase);
    if(apb_common :: num_mismatches > 0 && apb_common :: num_matches != apb_common :: total_pkt_count)
      `uvm_error("FAILED",$sformatf("total_pkt_count = %d & total_matches = %d & total_mismatches = %d",apb_common :: total_pkt_count, apb_common :: num_matches, apb_common :: num_mismatches))
     else
       `uvm_info("STATUS","TEST PASSED", UVM_LOW);
  endfunction
  
endclass
`endif
  

  
  
  
