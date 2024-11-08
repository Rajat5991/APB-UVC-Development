`ifndef APB_SEQ
`define APB_SEQ

`include "apb_packet.sv"

class apb_base_sequence extends uvm_sequence#(apb_packet);
  `uvm_object_utils(apb_base_sequence)
  
  function new(input string name = "apb_base_sequence");
    super.new(name);
  endfunction
  
  virtual task pre_body();
     uvm_phase starting_phase;
    starting_phase = get_starting_phase();
    if(starting_phase != null)
       begin
         starting_phase.raise_objection(this);
         starting_phase.phase_done.set_drain_time(this,100);
       end
  endtask
  
  virtual task post_body();
     uvm_phase starting_phase;
    starting_phase = get_starting_phase();
    if(starting_phase != null)
       begin
         starting_phase.drop_objection(this);   
       end
  endtask
       
    
  
endclass


class apb_sequence extends apb_base_sequence;
  `uvm_object_utils(apb_sequence)
  
  function new(input string name = "apb_sequence");
    super.new(name);
  endfunction
  
  virtual task body();
    bit [31:0] addr;
    //repeat(3)
    `uvm_do_with(req,{req.wr_rd == 1'b1;})
     addr = req.addr;
    `uvm_do_with(req,{req.wr_rd == 1'b0;
                      req.addr == local::addr;
                           })
  endtask
  
endclass

class apb_five_read_write_sequence extends apb_base_sequence;
  `uvm_object_utils(apb_sequence)
  
  function new(input string name = "apb_sequence");
    super.new(name);
  endfunction
  
  virtual task body();
    bit [31:0] addr_p[$];
    bit [31:0] addr_t;
    repeat(5)
     begin
      `uvm_do_with(req,{req.wr_rd == 1'b1;})
       addr_p.push_back(req.addr);
     end
    repeat(5)
     begin
       addr_t = addr_p.pop_front();
    `uvm_do_with(req,{req.wr_rd == 1'b0;
                      req.addr == addr_t;
                           })
     end
  endtask
  
endclass

`endif
                       
