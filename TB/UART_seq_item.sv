class UART_seq_item extends uvm_sequence_item;




  `uvm_object_utils(UART_seq_item)
  
  
  
  
	 rand logic Reset;
	 rand logic rd_uart;
	 rand logic wr_uart;
	 rand logic[7:0] w_data;
	 rand logic[9:0] divsr;
	 logic rx_empty;
	 logic tx_full;
	 logic tx;
         logic rx;
	 logic[7:0] r_data;
	 logic   correct_send;

  
  
  

  constraint c1 { divsr==650; }

 
  
  
  function new(string name = "UART_seq_item");
  
  
    super.new(name);
  
    `uvm_info(get_type_name(),"Inside constructor of UART seq item Class",UVM_HIGH)
  
  
  endfunction :new
  
  
  
  
  
  
  
  
  
endclass :UART_seq_item
