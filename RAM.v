//Data Memory
module RAM 
#(parameter DATA_WIDTH=32, parameter ADDR_WIDTH=6)
(
	input [(DATA_WIDTH-1):0] data,
	input [(ADDR_WIDTH-1):0] addr,
	input MemWrite, MemRead, clk_25, clk_50,
	output reg [(DATA_WIDTH-1):0] readData
);

	// Declare the RAM variable
	reg [DATA_WIDTH-1:0] ram[2**ADDR_WIDTH-1:0];
	
	
	// Variable to hold the registered read address
	reg [ADDR_WIDTH-1:0] addr_reg;

	always @ (posedge clk_25)
	begin
		// Write
		if (MemWrite)
			ram[addr] <= data;
	end
	
	always @ (posedge clk_50)
	begin
		// Read
		readData <= ram[addr];
		
	end


endmodule
