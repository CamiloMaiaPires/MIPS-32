module MUX_32b_5in(V1, V2, V3, V4, V5, option, out);
	input [31:0] V1;
	input [31:0] V2;
	input [31:0] V3;
	input [31:0] V4;
	input [31:0] V5;
	input [2:0] option;
	output reg [31:0]out;
	
	always @(*) begin
        case (option)
            3'b000: out = V1;
            3'b001: out = V2;
            3'b010: out = V3;
            3'b011: out = V4;
            3'b100: out = V5;
        endcase
    end
	
endmodule