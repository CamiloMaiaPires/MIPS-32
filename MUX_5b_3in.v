module MUX_5b_3in(V1, V2, V3, option, out);
	input [4:0] V1;
	input [4:0] V2;
	input [4:0] V3;
	input [1:0] option;
	output reg [4:0]out;
	
	always @(*) begin
        case (option)
            2'b00: out = V1;
            2'b01: out = V2;
            2'b10: out = V3;
        endcase
    end
	
endmodule