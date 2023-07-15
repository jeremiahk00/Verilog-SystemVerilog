module pwm_improved
  #(parameter R = 8, TIMER_BITS = 15)(
    input clk,
    input reset_n,
    input [R : 0] duty, //we want to have enough bits to include all the increments in case duty = 1
    input [TIMER_BITS - 1: 0] FINAL_VALUE, 
    output pwm_out
  );
  wire tick;
  reg [R - 1: 0] Q_reg, Q_next;
  /*
  we keep these registers since comparators may be faster than how fast the bits change in q_reg so 
  we feed the value from the comparator into another register and let it output the value 
  synchronous to the timer ticks
  */
  reg d_reg, d_next; 
  always @(posedge clk, negedge reset_n)
    begin
      if(~reset_n)
        begin
          Q_reg <= 'b0;
          d_reg <= 1'b0;
        end
      else if (tick)
        begin
          Q_reg <= Q_next;
          d_reg <= d_next;
        end
      else 
        begin
          Q_reg <= Q_reg;
          d_reg <= d_reg;
        end
    end

  always @(*)
    begin
      Q_next = Q_reg +1;
      d_next = (Q_reg < duty);
    end

  assign pwm_out = d_reg;

  //Prescalar Timer
  timer_input #(.BITS(TIMER_BITS)) timer0 (
    .clk(clk),
    .reset_n(reset_n),
    .enable(1'b1),
    .FINAL_VALUE(FINAL_VALUE),
    .done(tick)
  );
endmodule
