
class Coverage_collector  extends uvm_subscriber #(UART_seq_item);





  `uvm_component_utils(Coverage_collector)
  
  
  
  
  
  UART_seq_item item;
  
  
  
  covergroup UART_cover_signals ; 
  
                               
     
       

        rd_uart_cov: coverpoint item.rd_uart ;

        wr_uart_cov: coverpoint item.wr_uart ;

        w_data_cov: coverpoint item.w_data[7:0]{
             
            
             bins wdata_with_odd_parity =  {[127:0]} iff ($countones(item.w_data)%2==1); 
             bins wdata_with_even_parity = {[127:0]} iff ($countones(item.w_data)%2==0);

                         }


        tx_full_cov: coverpoint item.rx_empty ;

        tx_cov: coverpoint item.tx ;

        r_data_cov: coverpoint item.r_data[7:0] {

            bins rdata_with_odd_parity =  {[127:0]} iff ($countones(item.r_data)%2==1)  ;
            bins rdata_with_even_parity =  {[127:0]} iff ($countones(item.r_data)%2==0) ;

                            }
  

	 cross_rd_wr: cross rd_uart_cov , wr_uart_cov ;
  
  endgroup: UART_cover_signals
  
  
  
  
  
  
  
  function new(string name = "Coverage_collector" ,uvm_component parent);
  
  
    super.new(name,parent);
  
    `uvm_info(get_type_name(),"Inside constructor of coverage collector Class",UVM_LOW)
  
    UART_cover_signals = new();
    
    
    
  endfunction :new
    
  
  
  
  
  
  function void build_phase(uvm_phase phase);
  
  
    super.build_phase(phase);
    
	 
	 `uvm_info(get_type_name(),"Inside build phase of coverage collector Class",UVM_LOW)
	 
  
  endfunction :build_phase 
  
  
  
  
  
  
  
  
  function void connect_phase (uvm_phase phase);
  
  
    super.connect_phase(phase);
	 
	 
	 `uvm_info(get_type_name(),"Inside connect phase of coverage collector Class",UVM_LOW)
	 
  
  endfunction :connect_phase
  
  
  
  
  
  
  
  task  run_phase(uvm_phase phase);
  
  
    super.run_phase(phase);
  
  
	 `uvm_info(get_type_name(),"Inside run phase of coverage collector Class",UVM_LOW)
    
  
 
  endtask :run_phase
  
  
  
  
  
  
  
  
  
  function void write (UART_seq_item  t);


      item = UART_seq_item::type_id::create("item");
      
      $cast(item,t);
      
      UART_cover_signals.sample();
	 
	    
  
     
     
  endfunction: write
  
  
  
  
  
  
  
  
  
  
  
  
  
  
endclass :Coverage_collector
