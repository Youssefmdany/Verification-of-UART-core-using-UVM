interface Interface (input logic clk);


	         
   logic Reset;
	 logic rd_uart;
	 logic wr_uart;
	 logic[7:0] w_data;
	 logic[9:0] divsr;
	 logic rx_empty;
	 logic tx_full;
         logic rx;
	 logic tx;
	 logic[7:0] r_data;
	 logic   correct_send;



endinterface 