
	module MIPS(
		Clock, enter, in, reset,
		display, LED_Input, LED_Input2, LEDqt1, LEDqt2,
		ALU_Result, imprime_saida, Ativa_PC, saida_ff, entrada_ff,instruction,
		Read_Data2, Read_Data, Write_Data, Read_Data1, Write_register, RegDst,MemWrite, MemRead, hd_instruction,
		CLK, CLK_read,
		next_adress_PC, Adress_PC_Out,
		ledtest, 
//		bt0, led_btn
		LCD_DATA, LCD_ON,	LCD_BLON, LCD_RW,	LCD_EN, LCD_RS,
		QuantumEnd, ExecutingQuantum, QuantumFlag, halt, Reg_Addr1,
	);
	
		// === INOUT ===
		inout [7:0] LCD_DATA;

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
		output Read_Data2;
		output Read_Data;
		output Write_Data;
		output Read_Data1;
		output Write_register;
		output RegDst;
		output MemWrite, MemRead;
		output hd_instruction;

		output CLK, CLK_read;
		output next_adress_PC;
		output Adress_PC_Out;
		output QuantumEnd;
		output LEDqt1, LEDqt2;
		output ExecutingQuantum;
		output QuantumFlag;
		output halt;
		output [4:0] Reg_Addr1;
		
		//LCD
		output LCD_ON,	LCD_BLON, LCD_RW,	LCD_EN, LCD_RS;

		// === WIRES ===
		wire [31:0] instruction; // instrução atual
		wire [31:0] ALU_Result;
		wire Ativa_PC, saida_ff, entrada_ff;
		wire [31:0] imprime_saida;
		
		wire [31:0] next_adress_PC, Adress_PC_Out;
		wire out_flag;
		wire enter_debounce;
		wire LED_Input_Ativa;
		wire LED_Input_Ativa2;
		wire LEDqt1;
		wire LEDqt2;
		wire [2:0] RegDst;
		wire [5:0] Write_register;
		wire [31:0] Write_Data;
		wire [31:0] Read_Data1;
		wire [31:0] Read_Data2;
		wire RegWrite;
		wire [31:0] extended;
		wire ALUSrc;
		wire [31:0] ALU_B;
		wire [2:0] ALUOp;
		wire [4:0] ALU_ctr;
		wire zero;
		wire MemWrite;
		wire [31:0] Read_Data;
		wire [2:0] MemtoReg;
		wire [31:0] in_extended;
		wire [31:0] next_adress_addpc;
		wire [31:0] Shift_26_Out;
		wire [31:0] Shift_32_Out;
		wire [31:0] Add_Out;
		wire Branch;
		wire out_and;
		wire [31:0] out_next_mux;
		wire [1:0] Jump;
		wire [31:0] hd_instruction;
		wire InstructionWrite;
		
		//LCD
		wire setLCD;


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
	
	
	always @(posedge CLK) begin
    if (reset_counter < 2)
        reset_counter <= reset_counter + 1;
	end
	
	// nos primeiros pulsos do clock ou quando reset for ativado, reset_combined sera 1
	wire reset_combined;
	assign reset_combined = reset | reset_pulse;


	// === MÓDULOS ===
	PC(CLK, next_adress_PC, Adress_PC_Out, (Ativa_PC && ativa_pc_debug), reset_combined);

//	ROM(Adress_PC_Out[9:2], CLK, instruction);
	Instructions(Adress_PC_Out[12:2],hd_instruction, Read_Data2, InstructionWrite, CLK, instruction);
	
	HD(CLK, Read_Data1, hd_instruction);

	Debounce_Switch(CLK, enter, enter_debounce);
	Flip_Flop_Input(CLK, reset_combined, enter_debounce, entrada_ff, saida_ff);


	wire QuantumEnd;
	wire ExecutingQuantum;
	wire QuantumFlag;
	wire halt;
	assign halt = (instruction[31:26] == 6'b111111);
	timer(CLK, Adress_PC_Out, reset_combined, QuantumFlag, halt, QuantumEnd, ExecutingQuantum);

	Control_Unit(instruction[31:26], saida_ff, enter_debounce, RegDst, Jump, Branch, MemRead, MemtoReg, ALUOp, MemWrite, ALUSrc, RegWrite, out_flag, entrada_ff, LED_Input_Ativa, LED_Input_Ativa2, Ativa_PC, setLCD, InstructionWrite, ledtest, ExecutingQuantum, QuantumFlag, QuantumEnd, CLK, LEDqt1, LEDqt2, reset_combined);
//	Control_Unit(instruction[31:26], saida_ff, enter_debounce, RegDst, Jump, Branch, MemRead, MemtoReg, ALUOp, MemWrite, ALUSrc, RegWrite, out_flag, entrada_ff, LED_Input_Ativa, LED_Input_Ativa2, Ativa_PC, setLCD, InstructionWrite, ledtest);
	
	MUX_5b_5in mux_5b5i(.V1(instruction[20:16]), .V2(instruction[15:11]), .V3(5'b11111), .V4(5'b11010), .V5(5'b11001), .option(RegDst), .out(Write_register));
//	MUX_5b_4in mux_5b5i(.V1(instruction[20:16]), .V2(instruction[15:11]), .V3(5'b11111), .V4(5'b11010), .option(RegDst), .out(Write_register));

	
	wire [4:0] Reg_Addr1;
	MUX_5b_2in mux_5b2i(.V1(instruction[25:21]), .V2(5'b11010), .option(QuantumEnd), .out(Reg_Addr1));
	registers(Reg_Addr1, instruction[20:16], Write_register, Write_Data, Read_Data1, Read_Data2, CLK, RegWrite);
	
//	registers(instruction[25:21], instruction[20:16], Write_register, Write_Data, Read_Data1, Read_Data2, CLK, RegWrite);

	Salva_saida(CLK, Read_Data1, out_flag, imprime_saida);
//	Salva_saida(CLK, next_adress_PC >> 2, 1, imprime_saida);
//	wire [31:0] Reg_Data1_32 = Reg_Data1;
//	Salva_saida(CLK, Reg_Data1_32, 1, imprime_saida);

	Gerenciador_De_Saidas(imprime_saida, CLK, display);

	sign_extend(instruction[15:0], extended);

	MUX_32(Read_Data2, extended, ALUSrc, ALU_B);

	ALU_Control(ALUOp, instruction[5:0], ALU_ctr);
	ALU(Read_Data1, ALU_B, ALU_ctr, zero, ALU_Result);

	RAM(Read_Data2, ALU_Result[11:0], MemWrite, MemRead, CLK, CLK_read, Read_Data);

	sign_extend(in, in_extended);
//	MUX_32b_4in(ALU_Result, Read_Data, next_adress_addpc, in_extended, MemtoReg, Write_Data);
	MUX_32b_5in(ALU_Result, Read_Data, next_adress_addpc, in_extended, Adress_PC_Out, MemtoReg, Write_Data);

	// segmento que calcula proxima instrução
	ADD_PC(Adress_PC_Out, next_adress_addpc);

	Shift_Left2_26(instruction[25:0], Shift_26_Out, next_adress_addpc[31:28]);

	Shift_Left2_32(extended, Shift_32_Out);

	Add(next_adress_addpc, Shift_32_Out, Add_Out);

	and(out_and, zero, Branch);

	MUX_32(next_adress_addpc, Add_Out, out_and, out_next_mux);

	MUX_32b_3in(out_next_mux, Shift_26_Out, Read_Data1, Jump, next_adress_PC);
	
	Display_LCD(Clock,
		  CLK,
		  setLCD,
		  Read_Data1,
		  LCD_DATA,
		  LCD_ON,
		  LCD_BLON,
		  LCD_RW,
		  LCD_EN,
		  LCD_RS,
		  reset_combined);


endmodule
