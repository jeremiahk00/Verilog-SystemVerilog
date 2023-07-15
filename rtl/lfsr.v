module lfsr
  #(parameter N=3)(
    input clk,
    input reset_n,
    output [1:N] Q
  );

  reg [1:N] Q_reg, Q_next;
  wire taps;

  always @(posedge clk, negedge reset_n)
    begin
      if(~reset_n)
        Q_reg <= 'd1; //LFSR should not be default 0 or it will infintely result in 0
      else
        Q_reg <= Q_next;
    end

  always @(*)
    Q_next = {taps, Q_reg[1:N-1]};

  assign Q = Q_reg;
  //longest possible pseudo-random sequence for n=3
  //https://www.xilinx.com/support/documentation/application_notes/xapp052.pdf
  assign taps = Q_reg[2] ^ Q_reg[3];

endmodule
