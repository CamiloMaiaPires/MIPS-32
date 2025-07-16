/*module MIPS(Clock, instruction, ALU_Result, enter, in, reset, in_flag, halt, seg1,seg2,seg3,seg4,seg5,seg6,seg7,seg8, imprime_saida);

	input Clock, enter, reset;
	input [15:0] in;
	wire in_flag;
	output in_flag, halt;
	output [6:0] seg1,seg2,seg3,seg4,seg5,seg6,seg7,seg8;
	
	//segmento instrução atual
	wire [31:0] next_adress_PC, Adress_PC_Out;
	assign CLK = ~Clock;
	PC(CLK, next_adress_PC, Adress_PC_Out, halt, reset);
	
	//modulo de entrada
	IN(CLK, enter, in_flag)	;
	
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
	
	wire [31:0] imprime_saida;
	Salva_saida(Clock, Read_Data1, out_flag, imprime_saida);
	
	output imprime_saida;
	Gerenciador_De_Saidas(imprime_saida, Clock, seg1,seg2,seg3,seg4,seg5,seg6,seg7,seg8);
	
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
	wire [31:0] in_extended;
	sign_extend(in, in_extended);
	MUX_32b_4in(ALU_Result, Read_Data, next_adress_addpc, in_extended, MemtoReg, Write_Data);
	
	
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
	
	
endmodule*/


module MIPS(Clock, instruction, ALU_Result, enter, in, reset, halt, display, imprime_saida,LED_Input, LED_Input2, Ativa_PC, saida_ff, entrada_ff);
	output LED_Input2;
	output LED_Input;
	output wire Ativa_PC, saida_ff, entrada_ff;
	input Clock, enter, reset;
	input [15:0] in;
	output halt;
	output [55:0] display;
	
	//segmento instrução atual
	wire [31:0] next_adress_PC, Adress_PC_Out;
	assign CLK = ~Clock;
	PC(CLK, next_adress_PC, Adress_PC_Out, Ativa_PC, halt, reset);
	
	//modulo de entrada
	//IN(CLK, entrada_ff, in_flag)	;
	
	output wire [31:0] instruction; //instrução atual
	ROM(Adress_PC_Out[6:2], CLK, instruction);
	
	wire out_flag;
	//wire entrada_ff;
	Debounce_Switch(CLK, enter, enter_debounce);
	wire enter_debounce;
	Flip_Flop_Input(CLK, enter_debounce, entrada_ff, saida_ff);
	
	wire LED_Input_Ativa;
	wire LED_Input_Ativa2;
	//wire Ativa_PC;
	Control_Unit(instruction[31:26], saida_ff, enter_debounce, RegDst, Jump, Branch, MemRead, MemtoReg, ALUOp, MemWrite, ALUSrc, RegWrite, halt, out_flag, entrada_ff, LED_Input_Ativa, LED_Input_Ativa2, Ativa_PC);
	
	wire RegDst; //Sinal de controle para o multiplexador com endereço do write register
	wire [5:0] Write_register; //saída do mux
	MUX_5b_3in(instruction[20:16], instruction[15:11], 5'b11111, RegDst, Write_register);
	
	wire [31:0] Write_Data; //dado para escrever no Write Register
	wire [31:0] Read_Data1, Read_Data2; //conteúdo dos registradores lidos no Registers
	wire RegWrite; //Sinal de controle para indicar de qual entrada será armazenada a informação no Write Register
	registers(instruction[25:21], instruction[20:16], Write_register, Write_Data, Read_Data1, Read_Data2, CLK, RegWrite);
	
	wire [31:0] imprime_saida;
	Salva_saida(CLK, Read_Data1, out_flag, imprime_saida);
	
	output imprime_saida;
	Gerenciador_De_Saidas(imprime_saida, CLK, display);
	
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
	wire [31:0] in_extended;
	sign_extend(in, in_extended);
	MUX_32b_4in(ALU_Result, Read_Data, next_adress_addpc, in_extended, MemtoReg, Write_Data);
	
	
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
	
	assign LED_Input = LED_Input_Ativa;
	assign LED_Input2 = LED_Input_Ativa2;
	
endmodule
