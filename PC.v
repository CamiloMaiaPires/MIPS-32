module PC(CLK, next_adress, current_adress, halt);

	input CLK, halt;
	input [31:0] next_adress;
	output reg [31:0] current_adress;
	
	always@(posedge CLK)
	begin
		if (halt == 1)
		begin
			current_adress<=current_adress;
		end
		else
		begin
			current_adress<=next_adress;
		end

	end
endmodule