module pwm_improved
  #(parameter R = 8, TICKET_BITS = 15)(
    input clk,
    input reset_n,
    input [R : 0] duty, //we want to have enough bits to include all the increments in case duty = 1
    input [TIMER_BITS - 1: 0] FINAL_VALUE, 
    output pwm_out
  );
  wire tick;
  reg [R - 1: 0] Q_reg, Q_next;

  always @(posedge clk, negedge reset_n)
    begin
      if(~reset_n)
        Q_reg <= 1'b0;
      else if (tick)
        Q_reg <= Q_next;
      else 
        Q_reg <= Q_reg;
    end

  always @(*)
    Q_next <= Q_reg +1;

  assign pwm_out = (Q_reg < duty);
endmodule
