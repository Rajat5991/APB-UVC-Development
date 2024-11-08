interface apb_interface(input bit pclk, prst);
  logic [31:0] paddr;
  logic [31:0] pwdata;
  logic [31:0] prdata;
  logic [3:0] psel;
  logic pwrite;
  logic penable;
  logic pready;
  logic [1:0] presp;
  
  
  clocking master_cb@(posedge pclk);
    default input #0 output #1;
    
    input prst;
    output paddr;
    output pwdata;
    input prdata;
    output penable;
    output pwrite;
    output psel;
    input pready;
    input presp;
  endclocking
  
  
  clocking slave_cb@(posedge pclk);
    default input #0 output #1;
    
    input prst;
    input psel;
    input paddr;
    input pwdata;
    input penable;
    input pwrite;
    output pready;
    output presp;
    output prdata;
  endclocking
  
   clocking mon_cb@(posedge pclk);
    default input #0;
    
    input prst;
    input paddr;
    input pwdata;
    input penable;
    input pwrite;
    input pready;
    input presp;
    input prdata;
  endclocking
  
  clocking m_cb@(posedge pclk);
    default input #0;
    
    input prst;
    input paddr;
    input pwdata;
    input penable;
    input pwrite;
    input pready;
    input presp;
    input prdata;
  endclocking
  
  modport master_driver(input pclk, clocking master_cb);
  modport slave_driver(input pclk, clocking slave_cb);
  modport slave_mon(input pclk, clocking mon_cb);
  modport master_mon(input pclk, clocking m_cb);
      

endinterface
