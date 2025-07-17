
	module MIPS(
		Clock, enter, in, reset,
		display, LED_Input, LED_Input2,
//		instruction, ALU_Result, halt, imprime_saida, Ativa_PC, saida_ff, entrada_ff,
		ledtest
	);

		// === INPUTS ===
		input Clock, enter, reset;
		input [15:0] in;

		// === OUTPUTS ===

		output [55:0] display;
		output LED_Input2;
		output LED_Input;
		
		output ledtest;

		
//		output [31:0] instruction; // instrução atual
//		output [31:0] ALU_Result;
//		output Ativa_PC, saida_ff, entrada_ff;
//		output imprime_saida;
//		output halt;
//		output Read_Data1

		// === WIRES ===
		wire [31:0] instruction; // instrução atual
		wire [31:0] ALU_Result;
		wire Ativa_PC, saida_ff, entrada_ff;
		wire [31:0] imprime_saida;
		wire halt;
		
		wire [31:0] next_adress_PC, Adress_PC_Out;
		wire out_flag;
		wire enter_debounce;
		wire LED_Input_Ativa;
		wire LED_Input_Ativa2;
		wire RegDst;
		wire [5:0] Write_register;
		wire [31:0] Write_Data;
		wire [31:0] Read_Data1;
		wire [31:0] Read_Data2;
		wire RegWrite;
		wire [31:0] extended;
		wire ALUSrc;
		wire [31:0] ALU_B;
		wire [2:0] ALUOp;
		wire [3:0] ALU_ctr;
		wire zero;
		wire MemWrite;
		wire [31:0] Read_Data;
		wire [1:0] MemtoReg;
		wire [31:0] in_extended;
		wire [31:0] next_adress_addpc;
		wire [31:0] Shift_26_Out;
		wire [31:0] Shift_32_Out;
		wire [31:0] Add_Out;
		wire Branch;
		wire out_and;
		wire [31:0] out_next_mux;
		wire Jump;


	// === ASSIGNS ===
	assign CLK = ~Clock;

	assign LED_Input = LED_Input_Ativa;
	assign LED_Input2 = LED_Input_Ativa2;
	
	//variavel para pulso inicial do reset
	reg [1:0] reset_counter = 0;
	
	wire reset_pulse;
	assign reset_pulse = (reset_counter < 2);
	
	
	always @(posedge Clock) begin
    if (reset_counter < 2)
        reset_counter <= reset_counter + 1;
	end
	
	// nos primeiros pulsos do clock ou quando reset for ativado, reset_combined sera 1
	wire reset_combined;
	assign reset_combined = reset | reset_pulse;

	// === MÓDULOS ===
	PC(CLK, next_adress_PC, Adress_PC_Out, Ativa_PC, halt, reset_combined);

	//IN(CLK, entrada_ff, in_flag);

	ROM(Adress_PC_Out[6:2], CLK, instruction);

	Debounce_Switch(CLK, enter, enter_debounce);
	Flip_Flop_Input(CLK, reset_combined, enter_debounce, entrada_ff, saida_ff);

	Control_Unit(instruction[31:26], saida_ff, enter_debounce, RegDst, Jump, Branch, MemRead, MemtoReg, ALUOp, MemWrite, ALUSrc, RegWrite, halt, out_flag, entrada_ff, LED_Input_Ativa, LED_Input_Ativa2, Ativa_PC, ledtest);

	MUX_5b_3in(instruction[20:16], instruction[15:11], 5'b11111, RegDst, Write_register);

	registers(instruction[25:21], instruction[20:16], Write_register, Write_Data, Read_Data1, Read_Data2, CLK, RegWrite);

	Salva_saida(CLK, Read_Data1, out_flag, imprime_saida);

	Gerenciador_De_Saidas(imprime_saida, CLK, display);

	sign_extend(instruction[15:0], extended);

	MUX_32(Read_Data2, extended, ALUSrc, ALU_B);

	ALU_Control(ALUOp, instruction[5:0], ALU_ctr);
	ALU(Read_Data1, ALU_B, ALU_ctr, zero, ALU_Result);

	RAM(Read_Data2, ALU_Result[6:2], MemWrite, MemRead, CLK, Read_Data);

	sign_extend(in, in_extended);
	MUX_32b_4in(ALU_Result, Read_Data, next_adress_addpc, in_extended, MemtoReg, Write_Data);

	// segmento que calcula proxima instrução
	ADD_PC(Adress_PC_Out, next_adress_addpc);

	Shift_Left2_26(instruction[25:0], Shift_26_Out, next_adress_addpc[31:28]);

	Shift_Left2_32(extended, Shift_32_Out);

	Add(next_adress_addpc, Shift_32_Out, Add_Out);

	and(out_and, zero, Branch);

	MUX_32(next_adress_addpc, Add_Out, out_and, out_next_mux);

	MUX_32(out_next_mux, Shift_26_Out, Jump, next_adress_PC);

endmodule
