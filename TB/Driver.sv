
class Driver  extends uvm_driver #(UART_seq_item);



  `uvm_component_utils(Driver)
  
  
  virtual Interface intf;
  
  
  UART_seq_item item;
  
  
  
  
  
  
  
  function new(string name = "Driver" ,uvm_component parent);
  
  
    super.new(name,parent);
  
    `uvm_info(get_type_name(),"Inside constructor of Driver Class",UVM_LOW)
  
  
  endfunction :new
  
  
  
  
  
  
  
  function void build_phase(uvm_phase phase);
  
  
    super.build_phase(phase);
    
	 
	 `uvm_info(get_type_name(),"Inside build phase of Driver Class",UVM_LOW)
   
   
   if(!(uvm_config_db #(virtual Interface)::get(this,"*","intf",intf)))
	 
	     `uvm_error(get_type_name(),"failed to get virtual interface inside Driver class")
  


  
  endfunction :build_phase 
  
  
  
  
  
  
  
  
  function void connect_phase (uvm_phase phase);
  
  
    super.connect_phase(phase);
	 
	 
	 `uvm_info(get_type_name(),"Inside connect phase of Driver Class",UVM_LOW)
	 
  
  endfunction :connect_phase
  
  
  
  
  
  
  
  task run_phase(uvm_phase phase);
  
  
    super.run_phase(phase);
  
  
	 `uvm_info(get_type_name(),"Inside run phase of Driver Class",UVM_LOW)
    
	 
	 
	 
	 forever begin 
	 
	 
	 
	  item = UART_seq_item::type_id::create("item");

	 
	  seq_item_port.get_next_item(item);
	  
	  
	  drive(item);
	  
	  
	  
	  seq_item_port.item_done();
	  
	  
	 
	 end
	 
 
 
 
  endtask :run_phase
  
  
  
  
  
  
  
  
  task  drive (UART_seq_item item);
  
      	
	  intf.Reset = item.Reset;
          intf.rd_uart = item.rd_uart;
          intf.wr_uart = item.wr_uart;
          intf.w_data = item.w_data;
          intf.divsr = item.divsr;
	 


         if((!(item.rd_uart) && (item.wr_uart))||(!(item.rd_uart) && (!item.wr_uart))) begin 

              intf.rx=1;

         end




	 if((item.rd_uart && !(item.wr_uart))||((item.rd_uart) && (item.wr_uart))) begin 

                //idle state 
	 
	 intf.rx=1;
	 
	  repeat(1) @(posedge intf.clk);
	 
	 
	 //start bit
	 
	 intf.rx=0;
	 
	  repeat(5000) @(posedge intf.clk); //start bit duration is 8 ticks as defined in UART top module so the duration= 8*650*10 ns=52000ns
	 
	 
	 //data bits
	 
	 //firts bit
	 
	 intf.rx=item.w_data[0];
	 
	  repeat(10000) @(posedge intf.clk);

	 
	 //second bit
	 
	 intf.rx=item.w_data[1];
	 
	  repeat(10000) @(posedge intf.clk);
	 
	 
	 //third bit
	 
	 intf.rx=item.w_data[2];
	 
	  repeat(10000) @(posedge intf.clk);
	 
	 
	 //fourth bit
	 
	 intf.rx=item.w_data[3];
	 
	  repeat(10000) @(posedge intf.clk);
	 

	 //fifth bit
	 
	 intf.rx=item.w_data[4];
	 
	  repeat(10000) @(posedge intf.clk);
	 
	 

	 //sixth bit
	 
	 intf.rx=item.w_data[5];
	 
	  repeat(10000) @(posedge intf.clk);
	 
	 
	 
	 //seventh bit
	 
	 intf.rx=item.w_data[6];
	 
	  repeat(10000) @(posedge intf.clk);
	 
	 
	 
	 //eighth bit
	 
	 intf.rx=item.w_data[7];
	 
	  repeat(10000) @(posedge intf.clk);
	 
         if(item.w_data[7]^item.w_data[6]^item.w_data[5]^item.w_data[4]^item.w_data[3]^item.w_data[2]^item.w_data[1]^item.w_data[0]) begin 

             //parith bit
	 
	     intf.rx=1;

	 end

         else begin
               

             //parith bit
	 
	     intf.rx=0;               


         end
	repeat(10000) @(posedge intf.clk);
	 


	 //stop bit
	 
	 intf.rx=1;
	 


	  repeat(10000) @(posedge intf.clk);	 

          end 

         
         if(((!item.rd_uart) && (item.wr_uart))||((!item.rd_uart) && (!item.wr_uart))) begin 

           repeat(104000) @(posedge intf.clk);

         end 
          
		
      
		
		
		
  
  endtask: drive

  
  
  
  
  
  
  
  
  
endclass :Driver