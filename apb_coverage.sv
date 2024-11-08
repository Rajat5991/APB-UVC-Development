`ifndef APB_COV
`define APB_COV

class apb_cov extends uvm_subscriber#(apb_packet);
  `uvm_component_utils(apb_cov)
  
  
  apb_packet pkt;
  event apb_ev;
  
  covergroup apb_cg;
    CP_ADDR : coverpoint pkt.addr{
               option.auto_bin_max = 8;
    }
    CP_WR_RD : coverpoint pkt.wr_rd {
      bins WR_RD [] = {1,0};
    }
    CP_ADDR_X_WR_RD : cross CP_ADDR, CP_WR_RD;
  endgroup
  
  function new(input string name, input uvm_component parent);
    super.new(name,parent);
    apb_cg = new();
  endfunction
  
  function void write(apb_packet trans);
    $cast(pkt,trans);
    apb_cg.sample();
  endfunction
  
endclass
`endif
    
  
  
