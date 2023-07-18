module fsm_counter(
  input clk,
  input reset_n,
  input en,
  output [2:0] num
);

  //internal regs
  reg [2:0] state_reg, next_state;
  //parameterize states
  localparam s0 = 0, s1 = 1, s2 = 2, s3 = 3,
             s4 = 4, s5 = 5, s6 = 6, s7 = 7;

  //state reg
  always@(posedge clk, negedge reset_n) begin
    if(~reset_n)
      state_reg <= 'b0;
    else
      state_reg <= next_state;
  end

  //next state logic
  always@(*) begin
      if(en)
        case(state_reg)
          s0: next_state = s1;
          s1: next_state = s2;
          s2: next_state = s3;
          s3: next_state = s4;
          s4: next_state = s5;
          s5: next_state = s6;
          s6: next_state = s7;
          s7: next_state = s0;
          default: next_state <= state_reg;
        endcase
      else
        next_state <= state_reg;
  end
  
  //output logic
  assign num = state_reg;
endmodule

/*
module fsm_counter_tb(

);
  reg clk, reset_n, en;
  wire [2:0] num;

  //instantiate dut

  fsm_counter_uut0(
    .clk(clk),
    .reset_n(reset_n),
    .en(en),
    .num(num)
  );

  //generating a clock signal
  localparam T = 10;
  always
    begin
      clk = 1'b0;
      #(T/2);
      clk = 1'b1;
      #(T/2);
    end

  initial begin
    reset_n = 1'b0;
    en = 1'b0;
    @(negedge clk);
    reset_n = 1'b1;
    en = 1'b1;

    repeat(20) @(negedge clk);
    $finish;
  end
endmodule
*/
