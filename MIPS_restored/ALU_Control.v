module ALU_Control(ALUop,Function,ALUctr);
	input [2:0] ALUop; //sinal da unidade de controle sobre o opcode da instrução
	input [5:0] Function; //codigo da função para instruções do tipo R
	output reg [3:0] ALUctr;
 
	always @(ALUop,Function) begin
		case(ALUop)
			3'b010:
				begin
					case(Function)
						6'b100000: ALUctr <= 4'b0000; //ADD
						6'b100010: ALUctr <= 4'b0001; //SUB
						6'b011000: ALUctr <= 4'b0010; //MULT
						6'b011010: ALUctr <= 4'b0011; //DIV
						6'b100100: ALUctr <= 4'b0100; //AND
						6'b100101: ALUctr <= 4'b0101; //OR
						6'b100111: ALUctr <= 4'b0110; //NOR
						6'b100110: ALUctr <= 4'b0111; //XOR
						default: ALUctr <= 4'b1111;
					endcase
				end
			3'b000: ALUctr <= 4'b0000; //+
			3'b001: ALUctr <= 4'b0001; //-
			3'b011: ALUctr <= 4'b0100; //and
			3'b100: ALUctr <= 4'b1000; //bne
			3'b101: ALUctr <= 4'b1001; //bgt
			3'b110: ALUctr <= 4'b1010; //bge
			3'b111: ALUctr <= 4'b1011; //ble
			default: ALUctr <= 4'b1111;
		endcase
	end
endmodule