module Basic_IP_Core (pclk,presetn,pwrite,psel,penable,paddr,pwdata,prdata,pready,pslverr);

//Inputs, Outputs
  input wire pclk,presetn,pwrite,psel,penable;
  input wire [7:0] paddr,pwdata;
  output wire pready,pslverr;
  output reg [7:0] prdata;

//Internal Signals
  reg [7:0] reg_A,reg_B,reg_C,reg_D,reg_E,reg_F,reg_G,reg_H;
  reg [7:0] psel_reg;
  wire apb_wr_en;
  wire apb_rd_en;
 // wire sel_apb_rd_en;

//pready & pslverr
  assign pready = 1'b1;
  assign pslverr = 1'b0;

//Control Logic Block
  assign apb_wr_en = pwrite & penable & pready;  //decoder
  assign apb_rd_en = (~pwrite) & penable & pready;  //encoder
 // assign sel_apb_rd_en = apb_rd_en & psel;

//Decode Block 
  always @(paddr or psel)
  begin
  if(psel==0)
    psel_reg = 8'b0000_0000;
  else
    case(paddr)
      8'h00: psel_reg = 8'b0000_0001;
      8'h01: psel_reg = 8'b0000_0010;
      8'h02: psel_reg = 8'b0000_0100;
      8'h03: psel_reg = 8'b0000_1000;
      8'h04: psel_reg = 8'b0001_0000;
      8'h05: psel_reg = 8'b0010_0000;
      8'h06: psel_reg = 8'b0100_0000;
      8'h07: psel_reg = 8'b1000_0000;
      default: psel_reg = 8'b0000_0000;
    endcase
  end

//Encode Block
  always @(paddr or psel or apb_rd_en)
  begin
  if(!(psel && apb_rd_en))
    prdata = 8'b0000_0000;
  else
    case(paddr)
      8'h00: prdata = reg_A;
      8'h01: prdata = reg_B;
      8'h02: prdata = reg_C;
      8'h03: prdata = reg_D;
      8'h04: prdata = reg_E;
      8'h05: prdata = reg_F;
      8'h06: prdata = reg_G;
      8'h07: prdata = reg_H;
      default: prdata = 8'b0000_0000;
    endcase
  end
//Register
  //reg_A
  always @(posedge pclk or negedge presetn)
  begin
    if(presetn==0)
      reg_A <= 8'h00;
    else if(psel_reg[0] & apb_wr_en)
      reg_A <= pwdata;
    else
      reg_A <= reg_A;
  end

  //reg_B
  always @(posedge pclk or negedge presetn)
  begin
    if(presetn==0)
      reg_B <= 8'h00;
    else if(psel_reg[1] & apb_wr_en)
      reg_B <= pwdata;
    else
      reg_B <= reg_B;
  end

  //reg_C
  always @(posedge pclk or negedge presetn)
  begin
    if(presetn==0)
      reg_C <= 8'h00;
    else if(psel_reg[2] & apb_wr_en)
      reg_C <= pwdata;
    else
      reg_C <= reg_C;
  end

  //reg_D
  always @(posedge pclk or negedge presetn)
  begin
    if(presetn==0)
      reg_D <= 8'h00;
    else if(psel_reg[3] & apb_wr_en)
      reg_D <= pwdata;
    else
      reg_D <= reg_D;
  end

  //reg_E
  always @(posedge pclk or negedge presetn)
  begin
    if(presetn==0)
      reg_E <= 8'h00;
    else if(psel_reg[4] & apb_wr_en)
      reg_E <= pwdata;
    else
      reg_E <= reg_E;
  end

  //reg_F
  always @(posedge pclk or negedge presetn)
  begin
    if(presetn==0)
      reg_F <= 8'h00;
    else if(psel_reg[5] & apb_wr_en)
      reg_F <= pwdata;
    else
      reg_F <= reg_F;
  end

  //reg_G
  always @(posedge pclk or negedge presetn)
  begin
    if(presetn==0)
      reg_G <= 8'h00;
    else if(psel_reg[6] & apb_wr_en)
      reg_G <= pwdata;
    else
      reg_G <= reg_G;
  end

  //reg_H
  always @(posedge pclk or negedge presetn)
  begin
    if(presetn==0)
      reg_H <= 8'h00;
    else if(psel_reg[7] & apb_wr_en)
      reg_H <= pwdata;
    else
      reg_H <= reg_H;
  end

endmodule  
