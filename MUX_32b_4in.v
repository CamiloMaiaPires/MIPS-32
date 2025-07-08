module MUX_32b_4in(V1, V2, V3, V4, option, out);
	input [31:0] V1;
	input [31:0] V2;
	input [31:0] V3;
	input [31:0] V4;
	input [1:0] option;
	output reg [31:0]out;
	
	always @(*) begin
        case (option)
            2'b00: out = V1;
            2'b01: out = V2;
            2'b10: out = V3;
            2'b11: out = V4;
        endcase
    end
	
endmodule