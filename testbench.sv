// Code your testbench here
// or browse Examples
`ifndef TB_TOP
`define TB_TOP
`include "apb_testcase.sv"
`include "apb_interface.sv"


module tb_top();
  
  import uvm_pkg::*;
  
  bit pclk,prst;
  
  always
    begin
      #5 pclk = ~pclk;
    end
  
  initial 
     begin
       run_test("apb_wr_rd_test");
     end
  
  apb_interface aif(pclk, prst);
  
  initial
    begin
      prst = 1;
      repeat(2) @(posedge pclk)
      prst = 0;
    end
  
  initial
     begin
       uvm_config_db #(virtual apb_interface.master_driver) :: set(null,"*","apb_mif",aif.master_driver);
       uvm_config_db #(virtual apb_interface.slave_driver) :: set(null,"*","apb_sif",aif.slave_driver);
       uvm_config_db #(virtual apb_interface.slave_mon) :: set(null,"*","apb_pif",aif.slave_mon);
       uvm_config_db #(virtual apb_interface.master_mon) :: set(null,"*","apb_mmif",aif.master_mon);
        
     end
  
     initial begin
      $dumpfile("dump.vcd");
      $dumpvars;
      #1000;
      $finish;
     end 
endmodule
`endif
  
  
