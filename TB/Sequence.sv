
///////////////////////////////
//Base_sequence/////////////////////////////
///////////////////////////////

class Base_sequence extends uvm_sequence #(UART_seq_item);

  
  
  `uvm_object_utils(Base_sequence)
   
  
  
  
  
  function  new(string name = "Base_sequence");
  
  
     super.new(name);
	  
  
  endfunction: new
  

  

endclass: Base_sequence







///////////////////////////////
//Reset_sequence/////////////////////////////
///////////////////////////////

class Reset_seq extends Base_sequence;



  `uvm_object_utils(Reset_seq)
  
  
   UART_seq_item reset_item;
	

   function  new(string name = "Reset_seq");
  
  
     super.new(name);
	  
  
   endfunction: new
  
  
  
  
  
  task body();
  
  
    reset_item = UART_seq_item::type_id::create("reset_item");
  
  
    start_item(reset_item);
	 
	 
	 if(!(reset_item.randomize() with { Reset==1;  w_data==8'b0; wr_uart==0; rd_uart==0;  } ))
	   
		   `uvm_error(get_type_name(),"randomization failed in Reset_seq")
		
	 
	 finish_item(reset_item);
	 
  
  endtask: body
  
  


  
endclass: Reset_seq











class UART_seq extends Base_sequence;



  `uvm_object_utils(UART_seq)
  
  
   UART_seq_item item;
	

   function  new(string name = "UART_seq");
  
  
     super.new(name);
	  
  
   endfunction: new
  
  
  
  
  
  task body();
  
  
    item = UART_seq_item::type_id::create("item");
  
  
    start_item(item);
	 
	 
	 if(!(item.randomize() with { Reset==0;  } ))
	 
	    	`uvm_error(get_type_name(),"randomization failed in UART_seq")
 
	 
	 finish_item(item);
	 
  
  endtask: body
  
  


  
endclass: UART_seq










