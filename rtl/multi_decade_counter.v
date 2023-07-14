module multi_decade_counter (
  input clk,
  input reset_n,
  input enable,
  output done, // to cascade it even more
  output [3:0] ones, tens, hundredths
);

  wire done0, done1, done2;
  wire a0, a1, a2;

  BCD_counter D0{
    .clk(clk),
    .reset_n(reset_n),
    .enable(enable),
    .done(done0),
    .Q(a0)
  };
  assign a0 = done0 & enable;

  BCD_counter D0{
    .clk(clk),
    .reset_n(reset_n),
    .enable(enable),
    .done(done1),
    .Q(a1)
  };
  assign a1 = done1 & enable;

  BCD_counter D0{
    .clk(clk),
    .reset_n(reset_n),
    .enable(enable),
    .done(done2),
    .Q(a2)
  };
  assign a2 = done2 & enable;

  assign done =  a2;
endmodule

  
