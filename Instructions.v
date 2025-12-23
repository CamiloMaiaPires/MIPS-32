//Instructions Memory
module Instructions
#(parameter DATA_WIDTH=32, parameter ADDR_WIDTH=11)
(
	input [(ADDR_WIDTH-1):0] addr,
	input [(DATA_WIDTH-1):0] write_data,
	input [(ADDR_WIDTH-1):0] write_addr,
	input InstructionWrite, clk_25,
	output reg [(DATA_WIDTH-1):0] instruction
);

	// Instruction memory variable
	// [0:1023] -> Reservado para instruções do SO
	// [1024:2047] -> Reservado para instruções do processo atual
	reg [DATA_WIDTH-1:0] instMem[2**ADDR_WIDTH-1:0];
	
	
	initial begin
		$readmemb("instructions.txt", instMem);
	end

	always @ (addr)
	begin
		// Read
		instruction <= instMem[addr];
		
	end
	
	always @ (posedge clk_25)
	begin
		// Write
		if (InstructionWrite)
			instMem[write_addr] <= write_data;
	end


endmodule
