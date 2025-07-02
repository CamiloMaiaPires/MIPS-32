// Instruction memory

module ROM
#(parameter DATA_WIDTH=32, parameter ADDR_WIDTH=5)
(
	input [(ADDR_WIDTH-1):0] addr,
	input clk, 
	output reg [(DATA_WIDTH-1):0] q
);

	reg [DATA_WIDTH-1:0] rom[2**ADDR_WIDTH-1:0];
	
	initial
	begin
		$readmemb("instructions.txt", rom);
	end

	always @ (addr)
	begin
		q <= rom[addr];
	end

endmodule
