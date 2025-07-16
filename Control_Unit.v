module Control_Unit(
op_code,
saida_ff,
enter,
RegDst,
jump,
Branch,
MemRead,
MemtoReg,
ALUop,
MemWrite,
ALUSrc,
RegWrite, 
halt,
out_flag,
entrada_ff,
LED_Input_Ativa,
LED_Input_Ativa2,
Ativa_PC
);

	input saida_ff;
	input enter;
	input [5:0] op_code;
	output reg jump,Branch,MemRead,MemWrite,ALUSrc,RegWrite, halt, out_flag, LED_Input_Ativa,LED_Input_Ativa2, entrada_ff, Ativa_PC;
	output reg [1:0] RegDst,MemtoReg;
	output reg [2:0] ALUop;
	
	initial begin
		entrada_ff <= 1;
	end

	
	always @ (op_code)
	begin
		case(op_code)
			//Tipo R
			6'b000000:
			begin 
				RegDst <= 2'b01; 
				jump <= 0;
				Branch <= 0;
				MemRead <= 0;
				MemtoReg <= 2'b00;
				ALUop <= 3'b010;
				MemWrite <= 0;
				ALUSrc <= 0;
				RegWrite <= 1;
				halt <= 0;
				Ativa_PC <= 1;
				out_flag <= 0;
				entrada_ff <= saida_ff;
				LED_Input_Ativa <= 0;
				LED_Input_Ativa2 <= 0;
			end
			//ADDI
			6'b010000:
			begin
				RegDst <= 2'b00;
				jump <= 0;
				Branch <= 0;
				MemRead <= 0;
				MemtoReg <= 2'b00;
				ALUop <= 3'b000;
				MemWrite <= 0;
				ALUSrc <= 1;
				RegWrite <= 1;
				halt <= 0;
				Ativa_PC <= 1;
				out_flag <= 0;
				entrada_ff <= saida_ff;
				LED_Input_Ativa <= 0;
				LED_Input_Ativa2 <= 0;
			end
			//SUBI
			6'b010001:
			begin
				RegDst <= 2'b00;
				jump <= 0;
				Branch <= 0;
				MemRead <= 0;
				MemtoReg <= 2'b00;
				ALUop <= 3'b001;
				MemWrite <= 0;
				ALUSrc <= 1;
				RegWrite <= 1;
				halt <= 0;
				Ativa_PC <= 1;
				out_flag <= 0;
				entrada_ff <= saida_ff;
				LED_Input_Ativa <= 0;
				LED_Input_Ativa2 <= 0;
			end
			//ANDI
			6'b010010:
			begin
				RegDst <= 2'b00;
				jump <= 0;
				Branch <= 0;
				MemRead <= 0;
				MemtoReg <= 2'b00;
				ALUop <= 3'b011;
				MemWrite <= 0;
				ALUSrc <= 1;
				RegWrite <= 1;
				halt <= 0;
				Ativa_PC <= 1;
				out_flag <= 0;
				entrada_ff <= saida_ff;
				LED_Input_Ativa <= 0;
				LED_Input_Ativa2 <= 0;
			end
			
			//BEQ
			6'b001000:
			begin
				RegDst <= 2'b00;
				jump <= 0;
				Branch <= 1;
				MemRead <= 0;
				MemtoReg <= 2'b00;
				ALUop <= 3'b001;
				MemWrite <= 0;
				ALUSrc <= 0;
				RegWrite <= 0;
				halt <= 0;
				Ativa_PC <= 1;
				out_flag <= 0;
				entrada_ff <= saida_ff;
				LED_Input_Ativa <= 0;
				LED_Input_Ativa2 <= 0;
			end
			//BNE
			6'b001001:
			begin
				RegDst <= 2'b00;
				jump <= 0;
				Branch <= 1;
				MemRead <= 0;
				MemtoReg <= 2'b00;
				ALUop <= 3'b100;
				MemWrite <= 0;
				ALUSrc <= 0;
				RegWrite <= 0;
				halt <= 0;
				Ativa_PC <= 1;
				out_flag <= 0;
				entrada_ff <= saida_ff;
				LED_Input_Ativa <= 0;
				LED_Input_Ativa2 <= 0;
			end
			//BGT
			6'b001010:
			begin
				RegDst <= 2'b00;
				jump <= 0;
				Branch <= 1;
				MemRead <= 0;
				MemtoReg <= 2'b00;
				ALUop <= 3'b101;
				MemWrite <= 0;
				ALUSrc <= 0;
				RegWrite <= 0;
				halt <= 0;
				Ativa_PC <= 1;
				out_flag <= 0;
				entrada_ff <= saida_ff;
				LED_Input_Ativa <= 0;
				LED_Input_Ativa2 <= 0;
			end
			//BGE
			6'b001011:
			begin
				RegDst <= 2'b00;
				jump <= 0;
				Branch <= 1;
				MemRead <= 0;
				MemtoReg <= 2'b00;
				ALUop <= 3'b110;
				MemWrite <= 0;
				ALUSrc <= 0;
				RegWrite <= 0;
				halt <= 0;
				Ativa_PC <= 1;
				out_flag <= 0;
				entrada_ff <= saida_ff;
				LED_Input_Ativa <= 0;
				LED_Input_Ativa2 <= 0;
			end
			//BLE
			6'b001100:
			begin
				RegDst <= 2'b00;
				jump <= 0;
				Branch <= 1;
				MemRead <= 0;
				MemtoReg <= 2'b00;
				ALUop <= 3'b111;
				MemWrite <= 0;
				ALUSrc <= 0;
				RegWrite <= 0;
				halt <= 0;
				Ativa_PC <= 1;
				out_flag <= 0;
				entrada_ff <= saida_ff;
				LED_Input_Ativa <= 0;
				LED_Input_Ativa2 <= 0;
			end
			
			//LW
			6'b100011:
			begin
				RegDst <= 2'b00;
				jump <= 0;
				Branch <= 0;
				MemRead <= 1;
				MemtoReg <= 2'b01;
				ALUop <= 3'b000;
				MemWrite <= 0;
				ALUSrc <= 1;
				RegWrite <= 1;
				halt <= 0;
				Ativa_PC <= 1;
				out_flag <= 0;
				entrada_ff <= saida_ff;
				LED_Input_Ativa <= 0;
				LED_Input_Ativa2 <= 0;
			end
			//SW
			6'b101011:
			begin
				RegDst <= 2'b00;
				jump <= 0;
				Branch <= 0;
				MemRead <= 0;
				MemtoReg <= 2'b00;
				ALUop <= 3'b000;
				MemWrite <= 1;
				ALUSrc <= 1;
				RegWrite <= 0;
				halt <= 0;
				Ativa_PC <= 1;
				out_flag <= 0;
				entrada_ff <= saida_ff;
				LED_Input_Ativa <= 0;
				LED_Input_Ativa2 <= 0;
			end
			//J
			6'b000001:
			begin
				RegDst <= 2'b00;
				jump <= 1;
				Branch <= 0;
				MemRead <= 0;
				MemtoReg <= 2'b00;
				ALUop <= 3'b000;
				MemWrite <= 0;
				ALUSrc <= 0;
				RegWrite <= 0;
				halt <= 0;
				Ativa_PC <= 1;
				out_flag <= 0;
				entrada_ff <= saida_ff;
				LED_Input_Ativa <= 0;
				LED_Input_Ativa2 <= 0;
			end
			//JAL
			6'b000001:
			begin
				RegDst <= 2'b10;
				jump <= 1;
				Branch <= 0;
				MemRead <= 0;
				MemtoReg <= 2'b10;
				ALUop <= 3'b000;
				MemWrite <= 0;
				ALUSrc <= 0;
				RegWrite <= 0;
				halt <= 0;
				Ativa_PC <= 1;
				out_flag <= 0;
				entrada_ff <= saida_ff;
				LED_Input_Ativa <= 0;
				LED_Input_Ativa2 <= 0;
			end
			//JR
			6'b000001:
			begin
				RegDst <= 2'b10;
				jump <= 1;
				Branch <= 0;
				MemRead <= 0;
				MemtoReg <= 2'b00;
				ALUop <= 3'b000;
				MemWrite <= 0;
				ALUSrc <= 0;
				RegWrite <= 0;
				halt <= 0;
				Ativa_PC <= 1;
				out_flag <= 0;
				entrada_ff <= saida_ff;
				//LED_Input_Ativa <= 0;
				//LED_Input_Ativa2 <= 0;
			end
			//IN
			6'b100000:
			begin
				if (enter == saida_ff)
				begin
					Ativa_PC <= 1;
					entrada_ff <= ~saida_ff;
					LED_Input_Ativa <= 0;
					LED_Input_Ativa2 <= 0;
				end
				else
				begin
					Ativa_PC <= 0;
					entrada_ff <= saida_ff;
					//☺LED_Input_Ativa <= enter;
					//LED_Input_Ativa2 <= ~enter;
				end
				RegDst <= 2'b00;
				jump <= 0;
				Branch <= 0;
				MemRead <= 0;
				MemtoReg <= 2'b11;
				ALUop <= 3'b000;
				MemWrite <= 0;
				ALUSrc <= 0;
				RegWrite <= 1;
				halt <= 0;
				out_flag <= 0;
				
			end
			//OUT
			6'b100001:
			begin
				RegDst <= 2'b00;
				jump <= 0;
				Branch <= 0;
				MemRead <= 0;
				MemtoReg <= 2'b00;
				ALUop <= 3'b000;
				MemWrite <= 0;
				ALUSrc <= 0;
				RegWrite <= 0;
				halt <= 0;
				Ativa_PC <= 1;
				out_flag <= 1;
				entrada_ff <= saida_ff;
				LED_Input_Ativa <= 0;
				LED_Input_Ativa2 <= 0;
			end
			//HALT
			6'b111111: 	
			begin
				RegDst <= 2'b00;
				jump <= 0;
				Branch <= 0;
				MemRead <= 0;
				MemtoReg <= 2'b00;
				ALUop <= 3'b000;
				MemWrite <= 0;
				ALUSrc <= 0;
				RegWrite <= 0;
				halt <= 1;
				Ativa_PC <= 1;
				out_flag <= 0;
				entrada_ff <= saida_ff;
				LED_Input_Ativa <= 0;
				LED_Input_Ativa2 <= 0;
			end
			default:
			begin
				RegDst <= 2'b00;
				jump <= 0;
				Branch <= 0;
				MemRead <= 0;
				MemtoReg <= 2'b00;
				ALUop <= 3'b000;
				MemWrite <= 0;
				ALUSrc <= 0;
				RegWrite <= 0;
				halt <= 0;
				Ativa_PC <= 1;
				out_flag <= 0;
				entrada_ff <= saida_ff;
				LED_Input_Ativa <= 0;
				LED_Input_Ativa2 <= 0;
			end
		endcase
	end
endmodule
