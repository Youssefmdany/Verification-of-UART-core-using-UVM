class Agent  extends uvm_agent;



  `uvm_component_utils(Agent)
  
  
  
  Monitor UART_monitor;
  
  Driver UART_driver;
  
  Sequencer UART_sequencer;
  
  Coverage_collector  UART_coverage_collector; 
  
  
  function new(string name = "Agent" ,uvm_component parent);
  
  
    super.new(name,parent);
  
    `uvm_info(get_type_name(),"Inside constructor of Agent Class",UVM_LOW)
  
  
  endfunction :new
  
  
  
  
  
  
  
  function void build_phase(uvm_phase phase);
  
  
    super.build_phase(phase);
    
	 
	 `uvm_info(get_type_name(),"Inside build phase of Agent Class",UVM_LOW)

         UART_monitor = Monitor::type_id::create("UART_monitor",this);
	 
	 UART_driver = Driver::type_id::create("UART_driver",this);
	 
	 UART_sequencer = Sequencer::type_id::create("UART_sequencer",this);
	 
         UART_coverage_collector = Coverage_collector::type_id::create("UART_coverage_collector",this); 
        
  
  
  endfunction :build_phase 
  
  
  
  
  
  
  
  
  function void connect_phase (uvm_phase phase);
  
  
    super.connect_phase(phase);
	 
	 
	 `uvm_info(get_type_name(),"Inside connect phase of Agent Class",UVM_LOW)
	 
	 
	 UART_driver.seq_item_port.connect(UART_sequencer.seq_item_export);
	 UART_monitor.monitor_port.connect(UART_coverage_collector.analysis_export); 
  
  
  endfunction :connect_phase
  
  
  
  
  
  
  
  task  run_phase(uvm_phase phase);
  
  
    super.run_phase(phase);
  
  
	 `uvm_info(get_type_name(),"Inside run phase of Agent Class",UVM_LOW)
  
 
  endtask :run_phase
  
  
endclass :Agent