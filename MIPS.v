
	module MIPS(
		Clock, enter, in, reset,
		display, LED_Input, LED_Input2,
		instruction, ALU_Result, halt, imprime_saida, Ativa_PC, saida_ff, entrada_ff,
		Read_Data2, Read_Data, Write_Data, Read_Data1, Write_register, RegDst,MemWrite, MemRead,
		CLK, CLK_read,next_adress_PC,
		ledtest, 
//		bt0, led_btn
		
	);

		// === INPUTS ===
		input Clock, enter, reset;
		input [15:0] in;
//		input bt0;

		// === OUTPUTS ===

		output [55:0] display;
		output LED_Input2;
		output LED_Input;
		
		output ledtest;
//		output reg led_btn;

		
		output [31:0] instruction; // instrução atual
		output [31:0] ALU_Result;
		output Ativa_PC, saida_ff, entrada_ff;
		output imprime_saida;
		output halt;
		output Read_Data2;
		output Read_Data;
		output Write_Data;
		output Read_Data1;
		output Write_register;
		output RegDst;
		output MemWrite, MemRead;
		output CLK, CLK_read;
		output next_adress_PC;

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
		wire [1:0] RegDst;
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
		wire [1:0] Jump;


	//========= DEBUG - Clock por botão ========
	
//	wire dbbt0;
//	wire btn_pulse;
//   reg ativa_pc_debug;
	wire ativa_pc_debug;
	assign ativa_pc_debug = 1;
//	reg dbbt0_d;
//
//	Debounce_Switch(Clock, ~bt0, dbbt0);
//	assign btn_pulse = dbbt0 & ~dbbt0_d;
//
//	always @(posedge Clock) begin
//		dbbt0_d <= dbbt0;
//		
//		if (btn_pulse) begin
//			led_btn <= 1;
//			ativa_pc_debug <= 1;
//		end else begin
//			led_btn <= 0;
//			ativa_pc_debug <= 0;
//		end
//	end
	
	// ======== Reduzir freq CLOCK =======
	
	wire clock_25Mhz;
	Divisor_Freq(Clock, clock_25Mhz);
	
	
	// === ASSIGNS ===
	

	assign CLK = ~clock_25Mhz;
	assign CLK_read = ~Clock;
//	assign CLK = ~Clock;
	

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
	PC(CLK, next_adress_PC, Adress_PC_Out, (Ativa_PC && ativa_pc_debug), halt, reset_combined);

	//IN(CLK, entrada_ff, in_flag);

	ROM(Adress_PC_Out[9:2], CLK, instruction);

	Debounce_Switch(CLK, enter, enter_debounce);
	Flip_Flop_Input(CLK, reset_combined, enter_debounce, entrada_ff, saida_ff);

	Control_Unit(instruction[31:26], saida_ff, enter_debounce, RegDst, Jump, Branch, MemRead, MemtoReg, ALUOp, MemWrite, ALUSrc, RegWrite, halt, out_flag, entrada_ff, LED_Input_Ativa, LED_Input_Ativa2, Ativa_PC, ledtest);

	MUX_5b_3in mux_5b3i(.V1(instruction[20:16]), .V2(instruction[15:11]), .V3(5'b11111), .option(RegDst), .out(Write_register));

	registers(instruction[25:21], instruction[20:16], Write_register, Write_Data, Read_Data1, Read_Data2, CLK, RegWrite);

	Salva_saida(CLK, Read_Data1, out_flag, imprime_saida);
//	Salva_saida(CLK, next_adress_PC >> 2, out_flag, imprime_saida);

	Gerenciador_De_Saidas(imprime_saida, CLK, display);

	sign_extend(instruction[15:0], extended);

	MUX_32(Read_Data2, extended, ALUSrc, ALU_B);

	ALU_Control(ALUOp, instruction[5:0], ALU_ctr);
	ALU(Read_Data1, ALU_B, ALU_ctr, zero, ALU_Result);

	RAM(Read_Data2, ALU_Result[5:0], MemWrite, MemRead, CLK, CLK_read, Read_Data);

	sign_extend(in, in_extended);
	MUX_32b_4in(ALU_Result, Read_Data, next_adress_addpc, in_extended, MemtoReg, Write_Data);

	// segmento que calcula proxima instrução
	ADD_PC(Adress_PC_Out, next_adress_addpc);

	Shift_Left2_26(instruction[25:0], Shift_26_Out, next_adress_addpc[31:28]);

	Shift_Left2_32(extended, Shift_32_Out);

	Add(next_adress_addpc, Shift_32_Out, Add_Out);

	and(out_and, zero, Branch);

	MUX_32(next_adress_addpc, Add_Out, out_and, out_next_mux);

	MUX_32b_3in(out_next_mux, Shift_26_Out, Read_Data1, Jump, next_adress_PC);

endmodule
