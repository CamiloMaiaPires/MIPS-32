module sign_extend(s_in, s_out);
	input [15:0] s_in;
	output reg [31:0] s_out;
 
 always @(s_in)
	begin
		if(s_in[15]==1) begin
			s_out[31:16]=16'b1111111111111111;
		end else begin
			s_out[31:16]=16'b0000000000000000;
		end
		s_out[15:0]=s_in[15:0];
   end
endmodule