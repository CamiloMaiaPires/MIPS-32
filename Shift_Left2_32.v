module Shift_Left2_32(i_in, i_out);

	input [31:0] i_in;
	output [31:0] i_out;
	assign i_out[31:0] = {i_in[29:0], 2'b00};
	
endmodule