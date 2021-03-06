module PC(CLK, next_adress, current_adress);

	input CLK;
	input [31:0] next_adress;
	output reg [31:0] current_adress;
	
	always@(posedge CLK)
	begin
		current_adress<=next_adress;
	end
endmodule