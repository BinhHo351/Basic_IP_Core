module test_bench;

  wire pclk,presetn;
  wire pwrite,psel,penable,pready,pslverr;
  wire [7:0] paddr,prdata,pwdata;
  
  integer cnt_err = 0;   
  
  Basic_IP_Core dut(.pclk(pclk),
  		    .presetn(presetn),
		    .pwrite(pwrite),
 		    .psel(psel),
 		    .penable(penable),
 		    .pready(pready),
 		    .paddr(paddr),
 		    .prdata(prdata),
		    .pwdata(pwdata),
                    .pslverr(pslverr));
  
  cpu_model cpu(.pclk(pclk),
  		.presetn(presetn),
 		.pwrite(pwrite),
 		.psel(psel),
 		.pready(pready),
 		.penable(penable),
 		.prdata(prdata),
 		.paddr(paddr),
		.pwdata(pwdata),
                .pslverr(pslverr));
  
  system_signals generator(.pclk(pclk),
  			   .presetn(presetn));

  `include "run_test.v"

  //Report status
  task report;  
    input integer status_report;
    
    begin
      if(status_report==0) 
      begin
        $display("RESULT: TEST PASSED");
        $display("\n");
      end
      else
      begin
        $display("RESULT: TEST FAILED");
        $display("\n");
      end
        $finish;
    end
  endtask
  
   initial
    begin
      run_test();
      $display("Total: cnt_err = %d",cnt_err);
      report(cnt_err);  
    end
 endmodule   
