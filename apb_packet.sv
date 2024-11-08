`ifndef APB_PKT
`define APB_PKT

class apb_packet extends uvm_sequence_item;
  rand bit [31:0] addr;
  rand bit [31:0] data;
  rand bit wr_rd;
  rand bit [3:0] sel;
  
  `uvm_object_utils_begin(apb_packet)
     `uvm_field_int(addr,UVM_ALL_ON)
     `uvm_field_int(data,UVM_ALL_ON) 
     `uvm_field_int(wr_rd,UVM_ALL_ON) 
  `uvm_object_utils_end
  
  function new(input string name = "apb_packet");
    super.new(name);
  endfunction
  
 /* $onehot(2'b01) and $onehot(2'b10) would return true.
   $onehot0(2'b00), $onehot0(2'b01), and $onehot0(2'b10) would return true, but $onehot0(2'b11) would return false. */
  
  constraint sel_c{
    $onehot0(sel) == 1; }
  
endclass

`endif
