module ALU(in_A, in_B, ALU_Control, zero, ALU_Result);

	input [31:0] in_A;
	input [31:0] in_B;
	input [4:0] ALU_Control;
	output reg zero;
	output reg [31:0]ALU_Result;
	
	always @ (in_A or in_B or ALU_Control) begin
		case(ALU_Control)
			5'b00000: begin zero <= 0; ALU_Result <= in_A + in_B; end //ADD
			5'b00001: begin if(in_A==in_B) zero <= 1; else zero<=0; ALU_Result <= in_A - in_B; end //SUB
			5'b00010: begin zero <= 0; ALU_Result <= in_A * in_B; end //MULT
			5'b00011: begin zero <= 0; ALU_Result <= in_A / in_B; end //DIV
			5'b00100: begin zero <= 0; ALU_Result <= in_A & in_B; end //AND
			5'b00101: begin zero <= 0; ALU_Result <= in_A | in_B; end //OR
			5'b00110: begin zero <= 0; ALU_Result <= ~(in_A | in_B); end //NOR
			5'b00111: begin zero <= 0; ALU_Result <= in_A ^ in_B; end //XOR
			5'b01000: begin if(in_A != in_B) zero <= 1; else zero<=0; end //bne
			5'b01001: begin if(in_A > in_B) zero <= 1; else zero<=0; end //bgt
			5'b01010: begin if(in_A >= in_B) zero <= 1; else zero<=0; end //bge
			5'b01011: begin if(in_A <= in_B) zero <= 1; else zero<=0; end //ble
			5'b01100: begin zero <= 0; ALU_Result <= in_A > in_B; end //gt
			5'b01101: begin zero <= 0; ALU_Result <= in_A == in_B; end //eq
			5'b01110: begin zero <= 0; ALU_Result <= in_A <= in_B; end //let
			5'b01111: begin zero <= 0; ALU_Result <= in_A != in_B; end //neq
			5'b10000: begin zero <= 0; ALU_Result <= in_A < in_B; end //lt
			
			default: begin zero <= 0; ALU_Result <= 0; end
		endcase
	end

endmodule