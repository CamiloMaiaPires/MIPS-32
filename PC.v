module PC(CLK, next_adress, current_adress, Ativa_PC, halt, reset);

	input CLK, halt, reset, Ativa_PC;
	input [31:0] next_adress;
	output reg [31:0] current_adress;
	
	always@(posedge CLK)
	begin
		if (reset == 1) begin
			current_adress = 32'b0;
		end
		else begin
			if (Ativa_PC == 0)
			begin
				current_adress = current_adress;
			end
			else
			begin
				current_adress = next_adress;
			end
		end

	end
endmodule