module Control_Unit(op_code,RegDst,jump,Branch,MemRead,MemtoReg,ALUop,MemWrite,ALUSrc,RegWrite);
	input [5:0] op_code;
	output reg RegDst,jump,Branch,MemRead,MemtoReg,MemWrite,ALUSrc,RegWrite;
	output reg [2:0] ALUop;
	always @ *
	begin
		case(op_code)
			//Tipo R
			6'b000000:
			begin 
				RegDst <= 1; 
				jump <= 0;
				Branch <= 0;
				MemRead <= 0;
				MemtoReg <= 0;
				ALUop <= 3'b010;
				MemWrite <= 0;
				ALUSrc <= 0;
				RegWrite <= 1;
			end
			//ADDI
			6'b001000:
			begin
				RegDst <= 0;
				jump <= 0;
				Branch <= 0;
				MemRead <= 0;
				MemtoReg <= 0;
				ALUop <= 3'b000;
				MemWrite <= 0;
				ALUSrc <= 1;
				RegWrite <= 1;
			end
			//SUBI
			6'b001001:
			begin
				RegDst <= 0;
				jump <= 0;
				Branch <= 0;
				MemRead <= 0;
				MemtoReg <= 0;
				ALUop <= 3'b001;
				MemWrite <= 0;
				ALUSrc <= 1;
				RegWrite <= 1;
			end
			//ANDI
			6'b001100:
			begin
				RegDst <= 0;
				jump <= 0;
				Branch <= 0;
				MemRead <= 0;
				MemtoReg <= 0;
				ALUop <= 3'b011;
				MemWrite <= 0;
				ALUSrc <= 1;
				RegWrite <= 1;
			end
			
			//BEQ
			6'b000100:
			begin
				RegDst <= 0;
				jump <= 0;
				Branch <= 1;
				MemRead <= 0;
				MemtoReg <= 0;
				ALUop <= 3'b001;
				MemWrite <= 0;
				ALUSrc <= 0;
				RegWrite <= 0;
			end
			//BNE
			6'b000101:
			begin
				RegDst <= 0;
				jump <= 0;
				Branch <= 1;
				MemRead <= 0;
				MemtoReg <= 0;
				ALUop <= 3'b100;
				MemWrite <= 0;
				ALUSrc <= 0;
				RegWrite <= 0;
			end
			//BGT
			6'b000110:
			begin
				RegDst <= 0;
				jump <= 0;
				Branch <= 1;
				MemRead <= 0;
				MemtoReg <= 0;
				ALUop <= 3'b101;
				MemWrite <= 0;
				ALUSrc <= 0;
				RegWrite <= 0;
			end
			//BGE
			6'b000111:
			begin
				RegDst <= 0;
				jump <= 0;
				Branch <= 1;
				MemRead <= 0;
				MemtoReg <= 0;
				ALUop <= 3'b110;
				MemWrite <= 0;
				ALUSrc <= 0;
				RegWrite <= 0;
			end
			//BLE
			6'b001011:
			begin
				RegDst <= 0;
				jump <= 0;
				Branch <= 1;
				MemRead <= 0;
				MemtoReg <= 0;
				ALUop <= 3'b111;
				MemWrite <= 0;
				ALUSrc <= 0;
				RegWrite <= 0;
			end
			
			//LW
			6'b100011:
			begin
				RegDst <= 0;
				jump <= 0;
				Branch <= 0;
				MemRead <= 1;
				MemtoReg <= 1;
				ALUop <= 3'b000;
				MemWrite <= 0;
				ALUSrc <= 1;
				RegWrite <= 1;
			end
			//SW
			6'b101011:
			begin
				RegDst <= 0;
				jump <= 0;
				Branch <= 0;
				MemRead <= 0;
				MemtoReg <= 0;
				ALUop <= 3'b000;
				MemWrite <= 1;
				ALUSrc <= 1;
				RegWrite <= 0;
			end
			//J
			6'b000010:
			begin
				RegDst <= 0;
				jump <= 1;
				Branch <= 0;
				MemRead <= 0;
				MemtoReg <= 0;
				ALUop <= 3'b000;
				MemWrite <= 0;
				ALUSrc <= 0;
				RegWrite <= 0;
			end
			default:
			begin
				RegDst <= 0;
				jump <= 0;
				Branch <= 0;
				MemRead <= 0;
				MemtoReg <= 0;
				ALUop <= 3'b000;
				MemWrite <= 0;
				ALUSrc <= 0;
				RegWrite <= 0;
			end
		endcase
	end
endmodule
