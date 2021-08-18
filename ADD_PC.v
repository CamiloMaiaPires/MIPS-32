module ADD_PC(current_adress, next_adress);
	
	input [31:0] current_adress;
	output [31:0] next_adress;
	assign next_adress = current_adress + 3'b100;
	
endmodule