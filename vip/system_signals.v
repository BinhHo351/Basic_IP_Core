module system_signals(pclk,presetn);
  output reg pclk,presetn;

  //creat clock
  initial begin
    pclk = 0;
    forever #50 pclk=~pclk;
  end

  //creat reset
  initial begin
    presetn = 1'b1;
    #50;
    presetn = 1'b0;
    #50;
    presetn = 1'b1;
  end

endmodule
    
