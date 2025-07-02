module registers(rr1, rr2, wr, wd, rd1, rd2, CLK, regwrite);
	input [4:0] rr1, rr2, wr;
	input [31:0] wd;
	
	input CLK, regwrite;
	
	output [31:0] rd1, rd2;
	
	reg [31:0] register[31:0];

	assign rd1 = register[rr1];
	assign rd2 = register[rr2];
	
	always @(posedge CLK) begin
		if(regwrite) register[wr] <= wd;
	end

endmodule

