module ALU(in_A, in_B, ALU_Control, zero, ALU_Result);

	input [31:0] in_A;
	input [31:0] in_B;
	input [3:0] ALU_Control;
	output reg zero;
	output reg [31:0]ALU_Result;
	
	always @ (in_A or in_B or ALU_Control) begin
		case(ALU_Control)
			4'b0000: begin zero <= 0; ALU_Result <= in_A + in_B; end //ADD
			4'b0001: begin if(in_A==in_B) zero <= 1; else zero<=0; ALU_Result <= in_A - in_B; end //SUB
			4'b0010: begin zero <= 0; ALU_Result <= in_A * in_B; end //MULT
			4'b0011: begin zero <= 0; ALU_Result <= in_A / in_B; end //DIV
			4'b0100: begin zero <= 0; ALU_Result <= in_A & in_B; end //AND
			4'b0101: begin zero <= 0; ALU_Result <= in_A | in_B; end //OR
			4'b0110: begin zero <= 0; ALU_Result <= ~(in_A | in_B); end //NOR
			4'b0111: begin zero <= 0; ALU_Result <= in_A ^ in_B; end //XOR
			4'b1000: begin if(in_A != in_B) zero <= 1; else zero<=0; end //bne
			4'b1001: begin if(in_A > in_B) zero <= 1; else zero<=0; end //bgt
			4'b1010: begin if(in_A >= in_B) zero <= 1; else zero<=0; end //bge
			4'b1011: begin if(in_A <= in_B) zero <= 1; else zero<=0; end //ble
			
			default: begin zero <= 0; ALU_Result <= 0; end
		endcase
	end

endmodule