module MUX_32(V1, V2, option, out);
	input [31:0] V1;
	input [31:0] V2;
	input option;
	output reg [31:0]out;
	
	always @ (V1 or V2) begin
		if(option == 0) begin
			out = V1;
		end else begin
			out = V2;
		end
	end
	
endmodule