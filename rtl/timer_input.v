module timer_parameter
  #(parameter BITS = 4)(
    input clk,
    input reset_n,
    input enable,
    input [BITS - 1:0] FINAL_VALUE;
    output done
    );
    reg [BITS - 1: 0] Q_reg, Q_next;

    always @(posedge clk, negedge reset_n)
        begin
          if (~reset_n)
            Q_reg <= 1'b0;
          else if(enable)
            Q_reg <= Q_next;
          else
            Q_reg <= Q_reg;
        end
    //output logic
    assign done = Q_reg == FINAL_VALUE;
    //next state logic
    always @(*)
        Q_next <= done?1'b0:Q_reg + 1;
endmodule
