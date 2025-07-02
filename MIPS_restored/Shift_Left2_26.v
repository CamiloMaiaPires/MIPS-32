module Shift_Left2_26(t_in, t_out, pc_plus4);

	input [25:0] t_in;
	input [3:0] pc_plus4;
	output [31:0] t_out;
	
	assign t_out[27:0] = {t_in[25:0], 2'b00};
	assign t_out[31:28] = pc_plus4[3:0];
endmodule