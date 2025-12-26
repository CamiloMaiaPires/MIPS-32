module timer (
	input clk,
	input [31:0] PC,            
	input Reset,    
	input Quantum_flag, 
	input Halt,
	output reg quantum_end,
	output reg executing
);

	parameter [7:0] LIMITE_QUANTUM = 8'd7; 

	reg [7:0] contador;  
	reg [31:0] pc_prev;

    
	initial begin
		contador <= 0;
		quantum_end <= 0;
		executing <= 0;
		pc_prev <= PC;
	end

	always @(posedge clk) begin
		if (Reset || Halt) begin

			contador <= 0;
			quantum_end <= 0;
			executing <= 0;
			pc_prev <= PC;
		end else begin
			if (PC != pc_prev) begin
				pc_prev <= PC;
				if (Quantum_flag == 1) begin
					if (contador < LIMITE_QUANTUM - 1) begin
						contador <= contador + 1;
						quantum_end <= 0; 
						executing <= 1;
					end else begin
						contador <= 0;     
						quantum_end <= 0;     
						executing <= 0;
					end
				end else begin
					contador <= 0;
					quantum_end <= 0;
					executing <= 0;
				end
			end
		end
	end

endmodule