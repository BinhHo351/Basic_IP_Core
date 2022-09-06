task run_test();

  begin
    //read_write_register
    read_write();
    #100;
    //reset
    force presetn = 1'b0;
    #200;
    release presetn; 
    //read_default value
    read_default();
  end

endtask


//read_write_register
task read_write();

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


//read_default_value
task read_default();

  reg [7:0] data_out;
  reg [7:0] address;
  
  begin
    //read default value of register
    #200;
    repeat(100) begin
      address= $random();
      cpu.APB_READ(address,data_out);
      #1;
      if(data_out == 8'h00)
        cnt_err = cnt_err;
      else
        cnt_err = cnt_err + 1;
    end
  end
endtask
