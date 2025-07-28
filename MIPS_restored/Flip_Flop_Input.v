module Flip_Flop_Input(
    input clk,
    input reset,
    input enter,
    input entrada_ff,
    output reg toggle
);

always @(posedge clk) begin
    if (reset) begin
        toggle <= 1'b1;
    end else if (entrada_ff == 1'b1) begin
        toggle <= ~toggle;
    end else begin
			toggle <= toggle;
	 end
end

endmodule
