`ifndef SBD
`define SBD

`uvm_analysis_imp_decl(_mmon)
`uvm_analysis_imp_decl(_smon)
class apb_scoreboard extends uvm_scoreboard;
  `uvm_component_utils(apb_scoreboard)
  
  function new(input string name, input uvm_component parent);
    super.new(name,parent);
    aport_mmon = new("aport_mmon",this);
    aport_smon = new("aport_smon",this);
  endfunction
  
  uvm_analysis_imp_mmon #(apb_packet,apb_scoreboard) aport_mmon;
  uvm_analysis_imp_smon #(apb_packet,apb_scoreboard) aport_smon;
  
  apb_packet m_pkt[$];
  apb_packet s_pkt[$];
  
  apb_packet mas_pkt;
  apb_packet slv_pkt;
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
   
  endfunction
  
  function void write_mmon(apb_packet pkt);
    m_pkt.push_back(pkt);
  endfunction
  
  function void write_smon(apb_packet pkt);
    s_pkt.push_back(pkt);
  endfunction
  
  task run_phase(uvm_phase phase);
    forever
       begin
         wait((m_pkt.size() && s_pkt.size()) != 0)
         mas_pkt = apb_packet :: type_id :: create("mas_pkt");
         slv_pkt = apb_packet :: type_id :: create("slv_pkt");
         mas_pkt = m_pkt.pop_front();
         slv_pkt = s_pkt.pop_front();
         if(mas_pkt.compare(slv_pkt))
            begin
               apb_common :: num_matches ++;
            end
         else
           begin
               apb_common :: num_mismatches ++;
           end
       end
           
  endtask
         
endclass

`endif

  
  
    
