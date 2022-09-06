task run_test();

  reg [7:0] data_in;
  reg [7:0] data_out;
  reg [7:0] address;

  begin
    #200;
      address=8'h09;
    repeat(100) begin
      data_in = $random();
      cpu.APB_WRITE(address,data_in);
      cpu.APB_READ(address,data_out);
      address=address+1;
/*
      data_in = $random();
      address = 8'h0A;
      cpu.APB_WRITE(address,data_in);
      cpu.APB_READ(address,data_out);

      data_in = $random();
      address = 8'h0B;
      cpu.APB_WRITE(address,data_in);
      cpu.APB_READ(address,data_out);
*/
      if(data_out == 8'h00)
        cnt_err = cnt_err;
      else
        cnt_err = cnt_err + 1;
    end
  end
endtask
