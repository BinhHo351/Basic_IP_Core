task run_test();

  reg [7:0] data_in;
  reg [7:0] data_out;
  reg [7:0] address;

  begin
    #200;
    repeat(100) begin
      data_in = $random();
      address = $random();
      cpu.APB_WRITE(address,data_in);
      cpu.APB_READ(address,data_out);
      if(data_out == data_in)
        cnt_err = cnt_err;
      else
        cnt_err = cnt_err + 1;
    end
  end
endtask
