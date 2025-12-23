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
out_flag,
entrada_ff,
LED_Input_Ativa,
LED_Input_Ativa2,
Ativa_PC,
setLCD,
InstructionWrite,
ledtest,
ExecutingQuantum,
QuantumFlag,
QuantumEnd
);
	output reg ledtest;
	input saida_ff;
	input enter;
	input [5:0] op_code;
	output reg Branch,MemRead,MemWrite,ALUSrc,RegWrite, out_flag, LED_Input_Ativa,LED_Input_Ativa2, entrada_ff, Ativa_PC, InstructionWrite;
	output reg [2:0] MemtoReg, jump;
	output reg [2:0] RegDst;
	output reg [2:0] ALUop;
	output reg setLCD;
	input ExecutingQuantum;
	input QuantumEnd;
	output reg QuantumFlag;
//	reg quantum_wait;

	
	initial begin
		entrada_ff <= 1;
		QuantumFlag <= 0;
	end

	
	always @ (*) begin
	
//		if (QuantumEnd && !quantum_wait) begin
//			// salva o registrador
//			RegDst     <= 3'b100;
//			MemtoReg <= 3'b100;
//			RegWrite   <= 1;
//			Ativa_PC   <= 0;
//			quantum_wait <= 1;
//		end else if (quantum_wait) begin
//			RegDst <= 3'b000;
//			jump <= 2'b10;
//			Branch <= 0;
//			MemRead <= 0;
//			MemtoReg <= 3'b100;
//			ALUop <= 3'b000;
//			MemWrite <= 0;
//			ALUSrc <= 0;
//			RegWrite <= 0;
//			Ativa_PC <= 1;
//			out_flag <= 0;
//			LED_Input_Ativa <= 0;
//			LED_Input_Ativa2 <= 0;
//			entrada_ff <= 1'b0;
//			setLCD <= 0;
//			InstructionWrite <= 0;
//			QuantumFlag <= 0;
//		end else begin
	
		if (QuantumEnd == 1) begin
			RegDst <= 3'b100;
			jump <= 2'b10;
			Branch <= 0;
			MemRead <= 0;
			MemtoReg <= 3'b100;
			ALUop <= 3'b000;
			MemWrite <= 0;
			ALUSrc <= 0;
			RegWrite <= 1;
			Ativa_PC <= 1;
			out_flag <= 0;
			LED_Input_Ativa <= 0;
			LED_Input_Ativa2 <= 0;
			entrada_ff <= 1'b0;
			setLCD <= 0;
			InstructionWrite <= 0;
			QuantumFlag <= 0;
		end else begin
	
		
			case(op_code)
				//Tipo R
				6'b000000:
				begin 
					RegDst <= 3'b001; 
					jump <= 2'b00;
					Branch <= 0;
					MemRead <= 0;
					MemtoReg <= 3'b000;
					ALUop <= 3'b010;
					MemWrite <= 0;
					ALUSrc <= 0;
					RegWrite <= 1;
					Ativa_PC <= 1;
					out_flag <= 0;
					LED_Input_Ativa <= 0;
					LED_Input_Ativa2 <= 0;
					entrada_ff <= 1'b0;
					setLCD <= 0;
					InstructionWrite <= 0;
					QuantumFlag <= ExecutingQuantum;
				end
				//ADDI
				6'b010000:
				begin
					RegDst <= 3'b000;
					jump <= 2'b00;
					Branch <= 0;
					MemRead <= 0;
					MemtoReg <= 3'b000;
					ALUop <= 3'b000;
					MemWrite <= 0;
					ALUSrc <= 1;
					RegWrite <= 1;
					Ativa_PC <= 1;
					out_flag <= 0;
					LED_Input_Ativa <= 0;
					LED_Input_Ativa2 <= 0;
					entrada_ff <= 1'b0;
					setLCD <= 0;
					InstructionWrite <= 0;
					QuantumFlag <= ExecutingQuantum;
				end
				//SUBI
				6'b010001:
				begin
					RegDst <= 3'b000;
					jump <= 2'b00;
					Branch <= 0;
					MemRead <= 0;
					MemtoReg <= 3'b000;
					ALUop <= 3'b001;
					MemWrite <= 0;
					ALUSrc <= 1;
					RegWrite <= 1;
					Ativa_PC <= 1;
					out_flag <= 0;
					LED_Input_Ativa <= 0;
					LED_Input_Ativa2 <= 0;
					entrada_ff <= 1'b0;
					setLCD <= 0;
					InstructionWrite <= 0;
					QuantumFlag <= ExecutingQuantum;
				end
				//ANDI
				6'b010010:
				begin
					RegDst <= 3'b000;
					jump <= 2'b00;
					Branch <= 0;
					MemRead <= 0;
					MemtoReg <= 3'b000;
					ALUop <= 3'b011;
					MemWrite <= 0;
					ALUSrc <= 1;
					RegWrite <= 1;
					Ativa_PC <= 1;
					out_flag <= 0;
					LED_Input_Ativa <= 0;
					LED_Input_Ativa2 <= 0;
					entrada_ff <= 1'b0;
					setLCD <= 0;
					InstructionWrite <= 0;
					QuantumFlag <= ExecutingQuantum;
				end
				
				//BEQ
				6'b001000:
				begin
					RegDst <= 3'b000;
					jump <= 2'b00;
					Branch <= 1;
					MemRead <= 0;
					MemtoReg <= 3'b000;
					ALUop <= 3'b001;
					MemWrite <= 0;
					ALUSrc <= 0;
					RegWrite <= 0;
					Ativa_PC <= 1;
					out_flag <= 0;
					LED_Input_Ativa <= 0;
					LED_Input_Ativa2 <= 0;
					entrada_ff <= 1'b0;
					setLCD <= 0;
					InstructionWrite <= 0;
					QuantumFlag <= ExecutingQuantum;
				end
				//BNE
				6'b001001:
				begin
					RegDst <= 3'b000;
					jump <= 2'b00;
					Branch <= 1;
					MemRead <= 0;
					MemtoReg <= 3'b000;
					ALUop <= 3'b100;
					MemWrite <= 0;
					ALUSrc <= 0;
					RegWrite <= 0;
					Ativa_PC <= 1;
					out_flag <= 0;
					LED_Input_Ativa <= 0;
					LED_Input_Ativa2 <= 0;
					entrada_ff <= 1'b0;
					setLCD <= 0;
					InstructionWrite <= 0;
					QuantumFlag <= ExecutingQuantum;
				end
				//BGT
				6'b001010:
				begin
					RegDst <= 3'b000;
					jump <= 2'b00;
					Branch <= 1;
					MemRead <= 0;
					MemtoReg <= 3'b000;
					ALUop <= 3'b101;
					MemWrite <= 0;
					ALUSrc <= 0;
					RegWrite <= 0;
					Ativa_PC <= 1;
					out_flag <= 0;
					LED_Input_Ativa <= 0;
					LED_Input_Ativa2 <= 0;
					entrada_ff <= 1'b0;
					setLCD <= 0;
					InstructionWrite <= 0;
					QuantumFlag <= ExecutingQuantum;
				end
				//BGE
				6'b001011:
				begin
					RegDst <= 3'b000;
					jump <= 2'b00;
					Branch <= 1;
					MemRead <= 0;
					MemtoReg <= 3'b000;
					ALUop <= 3'b110;
					MemWrite <= 0;
					ALUSrc <= 0;
					RegWrite <= 0;
					Ativa_PC <= 1;
					out_flag <= 0;
					LED_Input_Ativa <= 0;
					LED_Input_Ativa2 <= 0;
					entrada_ff <= 1'b0;
					setLCD <= 0;
					InstructionWrite <= 0;
					QuantumFlag <= ExecutingQuantum;
				end
				//BLE
				6'b001100:
				begin
					RegDst <= 3'b000;
					jump <= 2'b00;
					Branch <= 1;
					MemRead <= 0;
					MemtoReg <= 3'b000;
					ALUop <= 3'b111;
					MemWrite <= 0;
					ALUSrc <= 0;
					RegWrite <= 0;
					Ativa_PC <= 1;
					out_flag <= 0;
					LED_Input_Ativa <= 0;
					LED_Input_Ativa2 <= 0;
					entrada_ff <= 1'b0;
					setLCD <= 0;
					InstructionWrite <= 0;
					QuantumFlag <= ExecutingQuantum;
				end
				
				//LW
				6'b100011:
				begin
					RegDst <= 3'b000;
					jump <= 2'b00;
					Branch <= 0;
					MemRead <= 1;
					MemtoReg <= 3'b001;
					ALUop <= 3'b000;
					MemWrite <= 0;
					ALUSrc <= 1;
					RegWrite <= 1;
					Ativa_PC <= 1;
					out_flag <= 0;
					LED_Input_Ativa <= 0;
					LED_Input_Ativa2 <= 0;
					entrada_ff <= 1'b0;
					setLCD <= 0;
					InstructionWrite <= 0;
					QuantumFlag <= ExecutingQuantum;
				end
				//SW
				6'b101011:
				begin
					RegDst <= 3'b000;
					jump <= 2'b00;
					Branch <= 0;
					MemRead <= 0;
					MemtoReg <= 3'b000;
					ALUop <= 3'b000;
					MemWrite <= 1;
					ALUSrc <= 1;
					RegWrite <= 0;
					Ativa_PC <= 1;
					out_flag <= 0;
					LED_Input_Ativa <= 0;
					LED_Input_Ativa2 <= 0;
					entrada_ff <= 1'b0;
					setLCD <= 0;
					InstructionWrite <= 0;
					QuantumFlag <= ExecutingQuantum;
				end
				//J
				6'b000001:
				begin
					RegDst <= 3'b000;
					jump <= 2'b01;
					Branch <= 0;
					MemRead <= 0;
					MemtoReg <= 3'b000;
					ALUop <= 3'b000;
					MemWrite <= 0;
					ALUSrc <= 0;
					RegWrite <= 0;
					Ativa_PC <= 1;
					out_flag <= 0;
					LED_Input_Ativa <= 0;
					LED_Input_Ativa2 <= 0;
					entrada_ff <= 1'b0;
					setLCD <= 0;
					InstructionWrite <= 0;
					QuantumFlag <= ExecutingQuantum;
				end
				//JAL
				6'b000010:
				begin
					RegDst <= 3'b010;
					jump <= 2'b01;
					Branch <= 0;
					MemRead <= 0;
					MemtoReg <= 3'b010;
					ALUop <= 3'b000;
					MemWrite <= 0;
					ALUSrc <= 0;
					RegWrite <= 1;
					Ativa_PC <= 1;
					out_flag <= 0;
					LED_Input_Ativa <= 0;
					LED_Input_Ativa2 <= 0;
					entrada_ff <= 1'b0;
					setLCD <= 0;
					InstructionWrite <= 0;
					QuantumFlag <= ExecutingQuantum;
				end
				//JR
				6'b000011:
				begin
					RegDst <= 3'b000;
					jump <= 2'b10;
					Branch <= 0;
					MemRead <= 0;
					MemtoReg <= 3'b000;
					ALUop <= 3'b000;
					MemWrite <= 0;
					ALUSrc <= 0;
					RegWrite <= 0;
					Ativa_PC <= 1;
					out_flag <= 0;
					LED_Input_Ativa <= 0;
					LED_Input_Ativa2 <= 0;
					entrada_ff <= 1'b0;
					setLCD <= 0;
					InstructionWrite <= 0;
					QuantumFlag <= ExecutingQuantum;
				end
				//IN
				6'b100000:
				begin
					if (enter == saida_ff)
					begin
						ledtest <= 1'b1;
						Ativa_PC <= 1;
						entrada_ff <= 1'b1;
						LED_Input_Ativa <= 0;
						LED_Input_Ativa2 <= 0;
					end
					else
					begin
						Ativa_PC <= 0;
						entrada_ff <= 1'b0;
						LED_Input_Ativa <= enter;
						LED_Input_Ativa2 <= ~enter;
						ledtest <= 1'b0;
					end
					RegDst <= 3'b000;
					jump <= 2'b00;
					Branch <= 0;
					MemRead <= 0;
					MemtoReg <= 3'b011;
					ALUop <= 3'b000;
					MemWrite <= 0;
					ALUSrc <= 0;
					RegWrite <= 1;
					out_flag <= 0;
					setLCD <= 0;
					InstructionWrite <= 0;
					QuantumFlag <= ExecutingQuantum;
				end
				//OUT
				6'b100001:
				begin
					RegDst <= 3'b000;
					jump <= 2'b00;
					Branch <= 0;
					MemRead <= 0;
					MemtoReg <= 3'b000;
					ALUop <= 3'b000;
					MemWrite <= 0;
					ALUSrc <= 0;
					RegWrite <= 0;
					Ativa_PC <= 1;
					out_flag <= 1;
					LED_Input_Ativa <= 0;
					LED_Input_Ativa2 <= 0;
					entrada_ff <= 1'b0;
					setLCD <= 0;
					InstructionWrite <= 0;
					QuantumFlag <= ExecutingQuantum;
				end
				//HALT
				6'b111111: 	
				begin
					RegDst <= 3'b000;
					jump <= 2'b10;
					Branch <= 0;
					MemRead <= 0;
					MemtoReg <= 3'b000;
					ALUop <= 3'b000;
					MemWrite <= 0;
					ALUSrc <= 0;
					RegWrite <= 0;
					Ativa_PC <= 1;
					out_flag <= 0;
					LED_Input_Ativa <= 0;
					LED_Input_Ativa2 <= 0;
					entrada_ff <= 1'b0;
					setLCD <= 0;
					InstructionWrite <= 0;
					QuantumFlag <= ExecutingQuantum;
				end
				//SETLCD
				6'b110000: 	
				begin
					RegDst <= 3'b000;
					jump <= 2'b00;
					Branch <= 0;
					MemRead <= 0;
					MemtoReg <= 3'b000;
					ALUop <= 3'b000;
					MemWrite <= 0;
					ALUSrc <= 0;
					RegWrite <= 0;
					Ativa_PC <= 1;
					out_flag <= 0;
					LED_Input_Ativa <= 0;
					LED_Input_Ativa2 <= 0;
					entrada_ff <= 1'b0;
					setLCD <= 1;
					InstructionWrite <= 0;
					QuantumFlag <= ExecutingQuantum;
				end
				//LOADINSTRUCTION
				6'b110001: 	
				begin
					RegDst <= 3'b000;
					jump <= 2'b00;
					Branch <= 0;
					MemRead <= 0;
					MemtoReg <= 3'b000;
					ALUop <= 3'b000;
					MemWrite <= 0;
					ALUSrc <= 0;
					RegWrite <= 0;
					Ativa_PC <= 1;
					out_flag <= 0;
					LED_Input_Ativa <= 0;
					LED_Input_Ativa2 <= 0;
					entrada_ff <= 1'b0;
					setLCD <= 0;
					InstructionWrite <= 1;
					QuantumFlag <= ExecutingQuantum;
				end
				//JALR
				6'b000100:
				begin
					RegDst <= 3'b011;
					jump <= 2'b10;
					Branch <= 0;
					MemRead <= 0;
					MemtoReg <= 3'b010;
					ALUop <= 3'b000;
					MemWrite <= 0;
					ALUSrc <= 0;
					RegWrite <= 1;
					Ativa_PC <= 1;
					out_flag <= 0;
					LED_Input_Ativa <= 0;
					LED_Input_Ativa2 <= 0;
					entrada_ff <= 1'b0;
					setLCD <= 0;
					InstructionWrite <= 0;
					QuantumFlag <= ExecutingQuantum;
				end
				//SETQUANTUM
				6'b110010:
				begin
					RegDst <= 3'b000;
					jump <= 2'b00;
					Branch <= 0;
					MemRead <= 0;
					MemtoReg <= 3'b000;
					ALUop <= 3'b000;
					MemWrite <= 0;
					ALUSrc <= 0;
					RegWrite <= 0;
					Ativa_PC <= 1;
					out_flag <= 0;
					LED_Input_Ativa <= 0;
					LED_Input_Ativa2 <= 0;
					entrada_ff <= 1'b0;
					setLCD <= 0;
					InstructionWrite <= 0;
					QuantumFlag <= 1;
				end
				default:
				begin
					RegDst <= 3'b000;
					jump <= 2'b00;
					Branch <= 0;
					MemRead <= 0;
					MemtoReg <= 3'b000;
					ALUop <= 3'b000;
					MemWrite <= 0;
					ALUSrc <= 0;
					RegWrite <= 0;
					Ativa_PC <= 1;
					out_flag <= 0;
					LED_Input_Ativa <= 0;
					LED_Input_Ativa2 <= 0;
					entrada_ff <= 1'b0;
					setLCD <= 0;
					InstructionWrite <= 0;
					QuantumFlag <= ExecutingQuantum;
				end
			endcase
		end
	end
endmodule
