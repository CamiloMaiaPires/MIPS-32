module MIPS(Clock, instruction, ALU_Result, enter, in);

	input Clock, enter;
	input [15:0] in;
	wire in_flag;

	
	//segmento instrução atual
	wire [31:0] next_adress_PC, Adress_PC_Out;
	assign CLK = ~Clock;
	PC(CLK, next_adress_PC, Adress_PC_Out, halt);
	
	//modulo de entrada
	IN(CLK, enter, in_flag);
	
	output wire [31:0] instruction; //instrução atual
	ROM(Adress_PC_Out[6:2], CLK, instruction);
	
	wire out_flag;
	Control_Unit(instruction[31:26],in_flag, RegDst, Jump, Branch, MemRead, MemtoReg, ALUOp, MemWrite, ALUSrc, RegWrite, halt, out_flag);
	
	wire RegDst; //Sinal de controle para o multiplexador com endereço do write register
	wire [5:0] Write_register; //saída do mux
	MUX_5b_3in(instruction[20:16], instruction[15:11], 5'b11111, RegDst, Write_register);
	
	wire [31:0] Write_Data; //dado para escrever no Write Register
	wire [31:0] Read_Data1, Read_Data2; //conteúdo dos registradores lidos no Registers
	wire RegWrite; //Sinal de controle para indicar de qual entrada será armazenada a informação no Write Register
	registers(instruction[25:21], instruction[20:16], Write_register, Write_Data, Read_Data1, Read_Data2, CLK, RegWrite);
	
	OUT(Read_Data1, out_flag);
	
	wire [31:0] extended;
	sign_extend(instruction[15:0], extended);
	
	wire ALUSrc; //Sinal de controle que indica qual informação ira entrar na ula
	wire[31:0] ALU_B; //saida do mux, entrada B da ula
	MUX_32(Read_Data2, extended, ALUSrc, ALU_B);
	
	
	wire[2:0] ALUOp; //sinal de controle para a ALU Control
	wire [3:0] ALU_ctr;//saida do alu control
	ALU_Control(ALUOp, instruction[5:0], ALU_ctr);
	
	wire zero;
	output wire [31:0] ALU_Result;
	ALU(Read_Data1, ALU_B, ALU_ctr, zero, ALU_Result);
	
	wire MemWrite; //Sinal de controle que indica se precisará
	wire [31:0] Read_Data; //Saida do data memory
	RAM(Read_Data2, ALU_Result[6:2], MemWrite, MemRead, CLK, Read_Data);
	
	wire MemtoReg;
	MUX_32b_4in(ALU_Result, Read_Data, next_adress_addpc, in, MemtoReg, Write_Data);
	
	
	//segmento que calcula proxima instrução
	wire [31:0] next_adress_addpc;
	ADD_PC(Adress_PC_Out, next_adress_addpc);
	
	wire [31:0] Shift_26_Out;
	Shift_Left2_26(instruction[25:0], Shift_26_Out, next_adress_addpc[31:28]);
	
	wire [31:0] Shift_32_Out;
	Shift_Left2_32(extended, Shift_32_Out);
	
	wire [31:0] Add_Out;
	Add(next_adress_addpc, Shift_32_Out, Add_Out);
	
	wire Branch; //Sinal de controle que indica se a instrução é branch
	wire out_and;
	and(out_and, zero, Branch);
	wire [31:0] out_next_mux;
	MUX_32(next_adress_addpc, Add_Out, out_and, out_next_mux);
	
	wire Jump;
	MUX_32(out_next_mux, Shift_26_Out, Jump, next_adress_PC);
	
	
endmodule

