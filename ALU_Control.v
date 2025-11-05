module ALU_Control(ALUop,Function,ALUctr);
	input [2:0] ALUop; //sinal da unidade de controle sobre o opcode da instrução
	input [5:0] Function; //codigo da função para instruções do tipo R
	output reg [4:0] ALUctr;
 
	always @(ALUop,Function) begin
		case(ALUop)
			3'b010:
				begin
					case(Function)
						6'b100000: ALUctr <= 5'b00000; //ADD
						6'b100010: ALUctr <= 5'b00001; //SUB
						6'b011000: ALUctr <= 5'b00010; //MULT
						6'b011010: ALUctr <= 5'b00011; //DIV
						6'b100100: ALUctr <= 5'b00100; //AND
						6'b100101: ALUctr <= 5'b00101; //OR
						6'b100111: ALUctr <= 5'b00110; //NOR
						6'b100110: ALUctr <= 5'b00111; //XOR
						6'b010000: ALUctr <= 5'b01100; //GT
						6'b010001: ALUctr <= 5'b01101; //EQ
						6'b010010: ALUctr <= 5'b01110; //LET
						6'b010011: ALUctr <= 5'b01111; //NEQ
						default: ALUctr <= 5'b11111;
					endcase
				end
			3'b000: ALUctr <= 5'b00000; //+
			3'b001: ALUctr <= 5'b00001; //-
			3'b011: ALUctr <= 5'b00100; //and
			3'b100: ALUctr <= 5'b01000; //bne
			3'b101: ALUctr <= 5'b01001; //bgt
			3'b110: ALUctr <= 5'b01010; //bge
			3'b111: ALUctr <= 5'b01011; //ble
			default: ALUctr <= 5'b11111;
		endcase
	end
endmodule