module ALU_Add(addr1,addr2,out_addr);

	input [31:0] addr1,addr2;
	output [31:0] out_addr;
	assign out_addr = addr1+addr2;
 
endmodule