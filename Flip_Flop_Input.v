module Flip_Flop_Input(
input clk,
input enter,
input entrada_ff,
output reg saida_ff
);

reg toggle;

always @(posedge clk) begin

    if (enter == entrada_ff) begin
        saida_ff <= toggle ? 1 : 0;  
        toggle <= ~toggle;   
    end
end

endmodule