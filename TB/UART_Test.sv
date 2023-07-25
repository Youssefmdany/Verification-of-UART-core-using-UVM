class UART_Test  extends uvm_test;



  `uvm_component_utils(UART_Test)
  
  
  
  Environment UART_environment;
  
  
  
  Reset_seq reset_seq;
  
  UART_seq seq;


  
  
  
  function new(string name = "UART_Test" ,uvm_component parent);
  
  
    super.new(name,parent);
  
    `uvm_info(get_type_name(),"Inside constructor of UART Test Class",UVM_LOW)
  
  
  endfunction :new
  
  
  
  
  
  
  
  
  
  function void build_phase(uvm_phase phase);
  
  
    super.build_phase(phase);
    
	 
	 `uvm_info(get_type_name(),"Inside build phase of UART Test Class",UVM_LOW)

	 
	 UART_environment = Environment::type_id::create("UART_environment",this);
	 
	 
  
  endfunction :build_phase 
  
  
  
  
  
  
  
  
  function void connect_phase (uvm_phase phase);
  
  
    super.connect_phase(phase);
	 
	 
	 `uvm_info(get_type_name(),"Inside connect phase of UART Test Class",UVM_LOW)
	 
  
  endfunction :connect_phase
  
  
  
  
  
  
  
  
  
  task  run_phase(uvm_phase phase);
  
  
    super.run_phase(phase);
  
  
	 `uvm_info(get_type_name(),"Inside run phase of UART Test Class",UVM_LOW)
  
   
	
	 phase.raise_objection(this);
  
    
	    //apply reset sequence
	    
      #100000
      
      reset_seq = Reset_seq::type_id::create("reset_seq");
	 
	    reset_seq.start(UART_environment.UART_Agent.UART_sequencer);
		 
		 
		 
		 
		 repeat(1000) begin 
		 
      
		  #970000;
		  		 
		  seq = UART_seq::type_id::create("seq");
	 
	    seq.start(UART_environment.UART_Agent.UART_sequencer);
		 

		 
		 
		 end
	 
	 
	 
	 phase.drop_objection(this);
  
  
  
  
 
  endtask :run_phase
  
  
  
  
  
  
  
  
endclass :UART_Test
