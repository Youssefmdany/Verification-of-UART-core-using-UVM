class Monitor  extends uvm_monitor;



  `uvm_component_utils(Monitor)
  
  
  virtual Interface intf;
  
  
  
  uvm_analysis_port #(UART_seq_item) monitor_port;
  
  
  UART_seq_item item;
  
  

  
  
  
  
  
  
  
  function new(string name = "Monitor" ,uvm_component parent);
  
  
    super.new(name,parent);
  
    `uvm_info(get_type_name(),"Inside constructor of Monitor Class",UVM_LOW)
    
    
    
  endfunction :new
  
  
  
  
  
  
  
  function void build_phase(uvm_phase phase);
  
  
  
    super.build_phase(phase);
    
	 
	 `uvm_info(get_type_name(),"Inside build phase of Monitor Class",UVM_LOW)
	 
    
	 if(!(uvm_config_db #(virtual Interface)::get(this,"*","intf",intf)))
	 
	     `uvm_error(get_type_name(),"failed to get virtual interface inside Monitor class")
  
  
    
	 monitor_port = new("monitor_port",this);
	 
	 
	 
  endfunction :build_phase 
  
  
  
  
  
  
  
  
  function void connect_phase (uvm_phase phase);
  
  
    super.connect_phase(phase);
	 
	 
	 `uvm_info(get_type_name(),"Inside connect phase of Monitor Class",UVM_LOW)
	
  
  
  endfunction :connect_phase
  
  
  
  
  
  
  
  task  run_phase(uvm_phase phase);
  
  
    super.run_phase(phase);
  
  
	 `uvm_info(get_type_name(),"Inside run phase of Monitor Class",UVM_LOW)
  
    
	 item = UART_seq_item::type_id::create("item");
  
    
	 
	 forever begin 
	 
	 
	   item = UART_seq_item::type_id::create("item");
		
	   
           wait(!intf.Reset);
  
          repeat(120000)  @(posedge intf.clk);

   
          item.Reset = intf.Reset;
          item.rd_uart = intf.rd_uart;
          item.wr_uart = intf.wr_uart;
          item.w_data = intf.w_data;
          item.divsr = intf.divsr;
          item.rx_empty = intf.rx_empty;
          item.tx_full = intf.tx_full;
          item.tx = intf.tx;
          item.r_data = intf.r_data;		   
          item.correct_send = intf.correct_send;



	  monitor_port.write(item);
		



	 end
	 
	 
 
 
  endtask :run_phase
  
  
  
  
  
endclass :Monitor