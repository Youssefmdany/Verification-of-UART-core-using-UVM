
`timescale 1ns/1ns

`include "Interface.sv"



module Top();


import UART_pkg::*;
import uvm_pkg::*;


logic clk;




Interface intf(.clk(clk));




UART DUT   (    .clk(intf.clk),
                .Reset(intf.Reset),
				        .rd_uart(intf.rd_uart),
				        .wr_uart(intf.wr_uart),
				        .w_data(intf.w_data),
				        .divsr(intf.divsr),
				        .rx_empty(intf.rx_empty),
				        .tx_full(intf.tx_full),
				        .tx(intf.tx),
                                        .rx(intf.rx),
				        .r_data(intf.r_data),
				        .correct_send(intf.correct_send)   );



initial begin 


  clk = 0;
  
  forever  #5 clk = ~clk;


end







initial begin 


  uvm_config_db #(virtual Interface)::set(null,"*","intf",intf);
  
  
  run_test("UART_Test");
  

end







initial begin 


  #200000000

  $finish();


end









endmodule 