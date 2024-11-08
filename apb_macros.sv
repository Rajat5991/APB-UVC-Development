`define APB_COM\
function new(input string name, input uvm_component parent);\
  super.new(name,parent);\
endfunction

`define APB_OBJ(obj_name)\
function new(input string name = "obj_name");\
  super.new(name);\
endfunction
