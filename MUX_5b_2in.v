module MUX_5b_2in(V1, V2, option, out);
	input [4:0] V1;
	input [4:0] V2;
	input option;
	output reg [4:0]out;
	
	always @(*) begin
		case (option)
			1'b0: out = V1;
			1'b1: out = V2;
			default: out = V1;
		endcase
	end

endmodule