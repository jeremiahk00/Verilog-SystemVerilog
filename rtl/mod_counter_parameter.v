module mod_counter_parameter
    #(parameter FINAL_VALUE = 9){
    input clk,
    input reset_n,
    input enable,
    output [BITS - 1:0] Q
    };

    localparam BITS  = $clog2(FINAL_VALUE);
  
    reg [BITS - 1: 0] Q_reg, Q_next;
    wire done;

    always @(posedge clk, negedge reset_n)
        begin
          if (~reset_n)
            Q_reg <= 1'b0;
          else if(enable)
            Q_reg <= Q_next;
          else
            Q_reg <= Q_reg;
        end
  
    assign done = Q_reg == FINAL_VALUE;
    //next state logic
    always @(*)
        Q_next <= done?1'b0:Q_reg + 1;
    //output logic
    assign Q = Q_reg;
endmodule
