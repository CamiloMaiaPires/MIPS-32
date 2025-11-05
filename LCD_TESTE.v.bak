module LCD (
    // Host Side
    input iCLK, iRST_N, 
	 input [31:0] Msg,  // Adicionando Msg como input
    // LCD Side
    output [7:0] LCD_DATA,
    output LCD_RW, LCD_EN, LCD_RS    
);

//    Internal Wires/Registers
reg    [5:0]    LUT_INDEX;
reg    [8:0]    LUT_DATA;
reg    [5:0]    mLCD_ST;
reg    [17:0]    mDLY;
reg        mLCD_Start;
reg    [7:0]    mLCD_DATA;
reg        mLCD_RS;
wire        mLCD_Done;
reg [31:0]  lastMsg; // Variável para armazenar o estado anterior de Msg

parameter    LCD_INTIAL    =    0;
parameter    LCD_LINE1    =    5;
parameter    LCD_CH_LINE    =    LCD_LINE1+16;
parameter    LCD_LINE2    =    LCD_LINE1+16+1;
parameter    LUT_SIZE    =    LCD_LINE1+32+1;

always@(posedge iCLK or negedge iRST_N)
begin
    if(!iRST_N)
    begin
        LUT_INDEX    <=    0;
        mLCD_ST        <=    0;
        mDLY        <=    0;
        mLCD_Start    <=    0;
        mLCD_DATA    <=    0;
        mLCD_RS        <=    0;
        lastMsg  <=    0;
    end
    else
    begin
        // Verificar mudança em Msg
        if (lastMsg != Msg) begin
            LUT_INDEX <= 0; // Reset LUT_INDEX se Msg mudar
        end
        lastMsg <= Msg; // Atualizar lastMsg

        if(LUT_INDEX<LUT_SIZE)
        begin
            case(mLCD_ST)
            0:    begin
                    mLCD_DATA    <=    LUT_DATA[7:0];
                    mLCD_RS        <=    LUT_DATA[8];
                    mLCD_Start    <=    1;
                    mLCD_ST        <=    1;
                end
            1:    begin
                    if(mLCD_Done)
                    begin
                        mLCD_Start    <=    0;
                        mLCD_ST        <=    2;                    
                    end
                end
            2:    begin
                    if(mDLY<18'h3FFFE)
                    mDLY    <=    mDLY + 1'b1;
                    else
                    begin
                        mDLY    <=    0;
                        mLCD_ST    <=    3;
                    end
                end
            3:    begin
                    LUT_INDEX    <=    LUT_INDEX + 1'b1;
                    mLCD_ST    <=    0;
                end
            endcase
        end
    end
end


always
begin
    if(Msg < 10) begin
			  case(LUT_INDEX)
					LCD_INTIAL+0:    LUT_DATA    <=    9'h038;
					LCD_INTIAL+1:    LUT_DATA    <=    9'h00C;
					LCD_INTIAL+2:    LUT_DATA    <=    9'h001;
					LCD_INTIAL+3:    LUT_DATA    <=    9'h006;
					LCD_INTIAL+4:    LUT_DATA    <=    9'h080;

					LCD_LINE1+0: LUT_DATA <= 9'h150;   // 'P'
					LCD_LINE1+1: LUT_DATA <= 9'h172;   // 'r'
					LCD_LINE1+2: LUT_DATA <= 9'h16F;   // 'o'
					LCD_LINE1+3: LUT_DATA <= 9'h163;   // 'c'
					LCD_LINE1+4: LUT_DATA <= 9'h165;   // 'e'
					LCD_LINE1+5: LUT_DATA <= 9'h173;   // 's'
					LCD_LINE1+6: LUT_DATA <= 9'h173;   // 's'
					LCD_LINE1+7: LUT_DATA <= 9'h16F;   // 'o'
					LCD_LINE1+8: LUT_DATA <= 9'h120;   // ' '
					LCD_LINE1+9: LUT_DATA <= 9'h173;   // 's'
					LCD_LINE1+10: LUT_DATA <= 9'h165;  // 'e'
					LCD_LINE1+11: LUT_DATA <= 9'h16E;  // 'n'
					LCD_LINE1+12: LUT_DATA <= 9'h164;  // 'd'
					LCD_LINE1+13: LUT_DATA <= 9'h16F;  // 'o'
					LCD_LINE1+14: LUT_DATA <= 9'h120;  // ' '
					LCD_LINE1+15: LUT_DATA <= 9'h120;  // ' '
 
					LCD_LINE2+0: LUT_DATA <= 9'h165;   // 'e'
					LCD_LINE2+1: LUT_DATA <= 9'h178;   // 'x'
					LCD_LINE2+2: LUT_DATA <= 9'h165;   // 'e'
					LCD_LINE2+3: LUT_DATA <= 9'h163;   // 'c'
					LCD_LINE2+4: LUT_DATA <= 9'h175;   // 'u'
					LCD_LINE2+5: LUT_DATA <= 9'h174;   // 't'
					LCD_LINE2+6: LUT_DATA <= 9'h161;   // 'a'
					LCD_LINE2+7: LUT_DATA <= 9'h164;   // 'd'
					LCD_LINE2+8: LUT_DATA <= 9'h16F;   // 'o'
					LCD_LINE2+9: LUT_DATA <= 9'h13A;   // ':'
					LCD_LINE2+10: LUT_DATA <= 9'h120;  // ' '
					LCD_LINE2+11: LUT_DATA <= 9'h130 + Msg;  // Numero
					LCD_LINE2+12: LUT_DATA <= 9'h120; // ' '
					LCD_LINE2+13: LUT_DATA <= 9'h120; // ' '
					LCD_LINE2+14: LUT_DATA <= 9'h120; // ' '
					LCD_LINE2+15: LUT_DATA <= 9'h120; // ' '
					// ... [Complete a linha com espaços ou caracteres conforme necessário]

					LCD_CH_LINE:    LUT_DATA    <=    9'h0C0;
					// Tratar a segunda linha conforme necessário
					// ...

					default:        LUT_DATA    <=    9'dx ;
			  endcase
	end else if(Msg == 10) begin
			  case(LUT_INDEX)
					LCD_INTIAL+0:    LUT_DATA    <=    9'h038;
					LCD_INTIAL+1:    LUT_DATA    <=    9'h00C;
					LCD_INTIAL+2:    LUT_DATA    <=    9'h001;
					LCD_INTIAL+3:    LUT_DATA    <=    9'h006;
					LCD_INTIAL+4:    LUT_DATA    <=    9'h080;
					
					LCD_LINE1+0: LUT_DATA <= 9'h145;  // 'E'
					LCD_LINE1+1: LUT_DATA <= 9'h173;  // 's'
					LCD_LINE1+2: LUT_DATA <= 9'h163;  // 'c'
					LCD_LINE1+3: LUT_DATA <= 9'h16F;  // 'o'
					LCD_LINE1+4: LUT_DATA <= 9'h16C;  // 'l'
					LCD_LINE1+5: LUT_DATA <= 9'h168;  // 'h'
					LCD_LINE1+6: LUT_DATA <= 9'h161;  // 'a'
					LCD_LINE1+7: LUT_DATA <= 9'h13A;  // ':'
					LCD_LINE1+8: LUT_DATA <= 9'h120;  // ' '
					LCD_LINE1+9: LUT_DATA <= 9'h120;  // ' '
					LCD_LINE1+10: LUT_DATA <= 9'h120; // ' '
					LCD_LINE1+11: LUT_DATA <= 9'h120; // ' '
					LCD_LINE1+12: LUT_DATA <= 9'h120; // ' '
					LCD_LINE1+13: LUT_DATA <= 9'h120; // ' '
					LCD_LINE1+14: LUT_DATA <= 9'h120; // ' '
					LCD_LINE1+15: LUT_DATA <= 9'h120; // ' '

					LCD_LINE2+0: LUT_DATA <= 9'h130;  // '0'
					LCD_LINE2+1: LUT_DATA <= 9'h145;  // 'E'
					LCD_LINE2+2: LUT_DATA <= 9'h178;  // 'x'
					LCD_LINE2+3: LUT_DATA <= 9'h169;  // 'i'
					LCD_LINE2+4: LUT_DATA <= 9'h174;  // 't'
					LCD_LINE2+5: LUT_DATA <= 9'h120;  // ' '
					LCD_LINE2+6: LUT_DATA <= 9'h131;  // '1'
					LCD_LINE2+7: LUT_DATA <= 9'h145;  // 'E'
					LCD_LINE2+8: LUT_DATA <= 9'h178;  // 'x'
					LCD_LINE2+9: LUT_DATA <= 9'h165;  // 'e'
					LCD_LINE2+10: LUT_DATA <= 9'h163; // 'c'
					LCD_LINE2+11: LUT_DATA <= 9'h120; // ' '
					LCD_LINE2+12: LUT_DATA <= 9'h132; // '2'
					LCD_LINE2+13: LUT_DATA <= 9'h141; // 'A'
					LCD_LINE2+14: LUT_DATA <= 9'h16C; // 'l'
					LCD_LINE2+15: LUT_DATA <= 9'h174; // 't'					
					// ... [Complete a linha com espaços ou caracteres conforme necessário]

					LCD_CH_LINE:    LUT_DATA    <=    9'h0C0;
					// Tratar a segunda linha conforme necessário
					// ...

					default:        LUT_DATA    <=    9'dx ;
			  endcase
	end else if(Msg == 11) begin
			  case(LUT_INDEX)
					LCD_INTIAL+0:    LUT_DATA    <=    9'h038;
					LCD_INTIAL+1:    LUT_DATA    <=    9'h00C;
					LCD_INTIAL+2:    LUT_DATA    <=    9'h001;
					LCD_INTIAL+3:    LUT_DATA    <=    9'h006;
					LCD_INTIAL+4:    LUT_DATA    <=    9'h080;
					
					LCD_LINE1+0: LUT_DATA <= 9'h151;  // 'Q'
					LCD_LINE1+1: LUT_DATA <= 9'h175;  // 'u'
					LCD_LINE1+2: LUT_DATA <= 9'h161;  // 'a'
					LCD_LINE1+3: LUT_DATA <= 9'h16E;  // 'n'
					LCD_LINE1+4: LUT_DATA <= 9'h174;  // 't'
					LCD_LINE1+5: LUT_DATA <= 9'h169;  // 'i'
					LCD_LINE1+6: LUT_DATA <= 9'h164;  // 'd'
					LCD_LINE1+7: LUT_DATA <= 9'h161;  // 'a'
					LCD_LINE1+8: LUT_DATA <= 9'h164;  // 'd'
					LCD_LINE1+9: LUT_DATA <= 9'h165;  // 'e'
					LCD_LINE1+10: LUT_DATA <= 9'h120; // ' '
					LCD_LINE1+11: LUT_DATA <= 9'h164; // 'd'
					LCD_LINE1+12: LUT_DATA <= 9'h165; // 'e'
					LCD_LINE1+13: LUT_DATA <= 9'h120; // ' '
					LCD_LINE1+14: LUT_DATA <= 9'h120; // ' '
					LCD_LINE1+15: LUT_DATA <= 9'h120; // ' '

					LCD_LINE2+0: LUT_DATA <= 9'h170;  // 'p'
					LCD_LINE2+1: LUT_DATA <= 9'h172;  // 'r'
					LCD_LINE2+2: LUT_DATA <= 9'h16F;  // 'o'
					LCD_LINE2+3: LUT_DATA <= 9'h163;  // 'c'
					LCD_LINE2+4: LUT_DATA <= 9'h165;  // 'e'
					LCD_LINE2+5: LUT_DATA <= 9'h173;  // 's'
					LCD_LINE2+6: LUT_DATA <= 9'h173;  // 's'
					LCD_LINE2+7: LUT_DATA <= 9'h16F;  // 'o'
					LCD_LINE2+8: LUT_DATA <= 9'h173;  // 's'
					LCD_LINE2+9: LUT_DATA <= 9'h13A;  // ':'
					LCD_LINE2+10: LUT_DATA <= 9'h120; // ' '
					LCD_LINE2+11: LUT_DATA <= 9'h120; // ' '
					LCD_LINE2+12: LUT_DATA <= 9'h120; // ' '
					LCD_LINE2+13: LUT_DATA <= 9'h120; // ' '
					LCD_LINE2+14: LUT_DATA <= 9'h120; // ' '
					LCD_LINE2+15: LUT_DATA <= 9'h120; // ' '
					
					// ... [Complete a linha com espaços ou caracteres conforme necessário]

					LCD_CH_LINE:    LUT_DATA    <=    9'h0C0;
					// Tratar a segunda linha conforme necessário
					// ...

					default:        LUT_DATA    <=    9'dx ;
			  endcase
	end else if(Msg == 12) begin
			  case(LUT_INDEX)
					LCD_INTIAL+0:    LUT_DATA    <=    9'h038;
					LCD_INTIAL+1:    LUT_DATA    <=    9'h00C;
					LCD_INTIAL+2:    LUT_DATA    <=    9'h001;
					LCD_INTIAL+3:    LUT_DATA    <=    9'h006;
					LCD_INTIAL+4:    LUT_DATA    <=    9'h080;
					
					LCD_LINE1+0: LUT_DATA <= 9'h151;  // 'Q'
					LCD_LINE1+1: LUT_DATA <= 9'h175;  // 'u'
					LCD_LINE1+2: LUT_DATA <= 9'h161;  // 'a'
					LCD_LINE1+3: LUT_DATA <= 9'h16C;  // 'l'
					LCD_LINE1+4: LUT_DATA <= 9'h120;  // ' '
					LCD_LINE1+5: LUT_DATA <= 9'h170;  // 'p'
					LCD_LINE1+6: LUT_DATA <= 9'h172;  // 'r'
					LCD_LINE1+7: LUT_DATA <= 9'h16F;  // 'o'
					LCD_LINE1+8: LUT_DATA <= 9'h163;  // 'c'
					LCD_LINE1+9: LUT_DATA <= 9'h120;  // ' '
					LCD_LINE1+10: LUT_DATA <= 9'h164; // 'd'
					LCD_LINE1+11: LUT_DATA <= 9'h165; // 'e'
					LCD_LINE1+12: LUT_DATA <= 9'h173; // 's'
					LCD_LINE1+13: LUT_DATA <= 9'h165; // 'e'
					LCD_LINE1+14: LUT_DATA <= 9'h16A; // 'j'
					LCD_LINE1+15: LUT_DATA <= 9'h161; // 'a'

					LCD_LINE2+0: LUT_DATA <= 9'h174;  // 't'
					LCD_LINE2+1: LUT_DATA <= 9'h172;  // 'r'
					LCD_LINE2+2: LUT_DATA <= 9'h16F;  // 'o'
					LCD_LINE2+3: LUT_DATA <= 9'h163;  // 'c'
					LCD_LINE2+4: LUT_DATA <= 9'h161;  // 'a'
					LCD_LINE2+5: LUT_DATA <= 9'h172;  // 'r'
					LCD_LINE2+6: LUT_DATA <= 9'h120;  // ' '
					LCD_LINE2+7: LUT_DATA <= 9'h16F;  // 'o'
					LCD_LINE2+8: LUT_DATA <= 9'h120;  // ' '
					LCD_LINE2+9: LUT_DATA <= 9'h169;  // 'i'
					LCD_LINE2+10: LUT_DATA <= 9'h16E; // 'n'
					LCD_LINE2+11: LUT_DATA <= 9'h164; // 'd'
					LCD_LINE2+12: LUT_DATA <= 9'h169; // 'i'
					LCD_LINE2+13: LUT_DATA <= 9'h163; // 'c'
					LCD_LINE2+14: LUT_DATA <= 9'h165; // 'e'
					LCD_LINE2+15: LUT_DATA <= 9'h13F; // '?'
					// ... [Complete a linha com espaços ou caracteres conforme necessário]

					LCD_CH_LINE:    LUT_DATA    <=    9'h0C0;
					// Tratar a segunda linha conforme necessário
					// ...

					default:        LUT_DATA    <=    9'dx ;
			  endcase
	end else if(Msg == 13) begin
			  case(LUT_INDEX)
					LCD_INTIAL+0:    LUT_DATA    <=    9'h038;
					LCD_INTIAL+1:    LUT_DATA    <=    9'h00C;
					LCD_INTIAL+2:    LUT_DATA    <=    9'h001;
					LCD_INTIAL+3:    LUT_DATA    <=    9'h006;
					LCD_INTIAL+4:    LUT_DATA    <=    9'h080;
					
					LCD_LINE1+0: LUT_DATA <= 9'h150;  // 'P'
					LCD_LINE1+1: LUT_DATA <= 9'h16F;  // 'o'
					LCD_LINE1+2: LUT_DATA <= 9'h172;  // 'r'
					LCD_LINE1+3: LUT_DATA <= 9'h120;  // ' '
					LCD_LINE1+4: LUT_DATA <= 9'h171;  // 'q'
					LCD_LINE1+5: LUT_DATA <= 9'h175;  // 'u'
					LCD_LINE1+6: LUT_DATA <= 9'h161;  // 'a'
					LCD_LINE1+7: LUT_DATA <= 9'h16C;  // 'l'
					LCD_LINE1+8: LUT_DATA <= 9'h120;  // ' '
					LCD_LINE1+9: LUT_DATA <= 9'h120;  // ' '
					LCD_LINE1+10: LUT_DATA <= 9'h120; // ' '
					LCD_LINE1+11: LUT_DATA <= 9'h120; // ' '
					LCD_LINE1+12: LUT_DATA <= 9'h120; // ' '
					LCD_LINE1+13: LUT_DATA <= 9'h120; // ' '
					LCD_LINE1+14: LUT_DATA <= 9'h120; // ' '
					LCD_LINE1+15: LUT_DATA <= 9'h120; // ' '

					LCD_LINE2+0: LUT_DATA <= 9'h170;  // 'p'
					LCD_LINE2+1: LUT_DATA <= 9'h172;  // 'r'
					LCD_LINE2+2: LUT_DATA <= 9'h16F;  // 'o'
					LCD_LINE2+3: LUT_DATA <= 9'h163;  // 'c'
					LCD_LINE2+4: LUT_DATA <= 9'h165;  // 'e'
					LCD_LINE2+5: LUT_DATA <= 9'h173;  // 's'
					LCD_LINE2+6: LUT_DATA <= 9'h173;  // 's'
					LCD_LINE2+7: LUT_DATA <= 9'h16F;  // 'o'
					LCD_LINE2+8: LUT_DATA <= 9'h13F;  // '?'
					LCD_LINE2+9: LUT_DATA <= 9'h120;  // ' '
					LCD_LINE2+10: LUT_DATA <= 9'h120; // ' '
					LCD_LINE2+11: LUT_DATA <= 9'h120; // ' '
					LCD_LINE2+12: LUT_DATA <= 9'h120; // ' '
					LCD_LINE2+13: LUT_DATA <= 9'h120; // ' '
					LCD_LINE2+14: LUT_DATA <= 9'h120; // ' '
					LCD_LINE2+15: LUT_DATA <= 9'h120; // ' '
					// ... [Complete a linha com espaços ou caracteres conforme necessário]

					LCD_CH_LINE:    LUT_DATA    <=    9'h0C0;
					// Tratar a segunda linha conforme necessário
					// ...

					default:        LUT_DATA    <=    9'dx ;
			  endcase
	end else if(Msg == 14) begin
			  case(LUT_INDEX)
					LCD_INTIAL+0:    LUT_DATA    <=    9'h038;
					LCD_INTIAL+1:    LUT_DATA    <=    9'h00C;
					LCD_INTIAL+2:    LUT_DATA    <=    9'h001;
					LCD_INTIAL+3:    LUT_DATA    <=    9'h006;
					LCD_INTIAL+4:    LUT_DATA    <=    9'h080;
					
					LCD_LINE1+0: LUT_DATA <= 9'h120;  // ' '
					LCD_LINE1+1: LUT_DATA <= 9'h120;  // ' '
					LCD_LINE1+2: LUT_DATA <= 9'h120;  // ' '
					LCD_LINE1+3: LUT_DATA <= 9'h120;  // ' '
					LCD_LINE1+4: LUT_DATA <= 9'h120;  // ' '
					LCD_LINE1+5: LUT_DATA <= 9'h120;  // ' '
					LCD_LINE1+6: LUT_DATA <= 9'h120;  // ' '
					LCD_LINE1+7: LUT_DATA <= 9'h120;  // ' '
					LCD_LINE1+8: LUT_DATA <= 9'h120;  // ' '
					LCD_LINE1+9: LUT_DATA <= 9'h120;  // ' '
					LCD_LINE1+10: LUT_DATA <= 9'h120; // ' '
					LCD_LINE1+11: LUT_DATA <= 9'h120; // ' '
					LCD_LINE1+12: LUT_DATA <= 9'h120; // ' '
					LCD_LINE1+13: LUT_DATA <= 9'h120; // ' '
					LCD_LINE1+14: LUT_DATA <= 9'h120; // ' '
					LCD_LINE1+15: LUT_DATA <= 9'h120; // ' '

					LCD_LINE2+0: LUT_DATA <= 9'h120;  // ' '
					LCD_LINE2+1: LUT_DATA <= 9'h120;  // ' '
					LCD_LINE2+2: LUT_DATA <= 9'h120;  // ' '
					LCD_LINE2+3: LUT_DATA <= 9'h120;  // ' '
					LCD_LINE2+4: LUT_DATA <= 9'h120;  // ' '
					LCD_LINE2+5: LUT_DATA <= 9'h120;  // ' '
					LCD_LINE2+6: LUT_DATA <= 9'h120;  // ' '
					LCD_LINE2+7: LUT_DATA <= 9'h120;  // ' '
					LCD_LINE2+8: LUT_DATA <= 9'h120;  // ' '
					LCD_LINE2+9: LUT_DATA <= 9'h120;  // ' '
					LCD_LINE2+10: LUT_DATA <= 9'h120; // ' '
					LCD_LINE2+11: LUT_DATA <= 9'h120; // ' '
					LCD_LINE2+12: LUT_DATA <= 9'h120; // ' '
					LCD_LINE2+13: LUT_DATA <= 9'h120; // ' '
					LCD_LINE2+14: LUT_DATA <= 9'h120; // ' '
					LCD_LINE2+15: LUT_DATA <= 9'h120; // ' '
					// ... [Complete a linha com espaços ou caracteres conforme necessário]

					LCD_CH_LINE:    LUT_DATA    <=    9'h0C0;
					// Tratar a segunda linha conforme necessário
					// ...

					default:        LUT_DATA    <=    9'dx ;
			  endcase
	end else if(Msg > 20 && Msg <= 30) begin
				case(LUT_INDEX)
					LCD_INTIAL+0:    LUT_DATA    <=    9'h038;
					LCD_INTIAL+1:    LUT_DATA    <=    9'h00C;
					LCD_INTIAL+2:    LUT_DATA    <=    9'h001;
					LCD_INTIAL+3:    LUT_DATA    <=    9'h006;
					LCD_INTIAL+4:    LUT_DATA    <=    9'h080;
	
					LCD_LINE1+0: LUT_DATA <= 9'h149;  // 'I'
					LCD_LINE1+1: LUT_DATA <= 9'h144;  // 'D'
					LCD_LINE1+2: LUT_DATA <= 9'h120;  // ' '
					LCD_LINE1+3: LUT_DATA <= 9'h164;  // 'd'
					LCD_LINE1+4: LUT_DATA <= 9'h16F;  // 'o'
					LCD_LINE1+5: LUT_DATA <= 9'h120;  // ' '
					LCD_LINE1+6: LUT_DATA <= 9'h170;  // 'p'
					LCD_LINE1+7: LUT_DATA <= 9'h172;  // 'r'
					LCD_LINE1+8: LUT_DATA <= 9'h16F;  // 'o'
					LCD_LINE1+9: LUT_DATA <= 9'h163;  // 'c'
					LCD_LINE1+10: LUT_DATA <= 9'h165; // 'e'
					LCD_LINE1+11: LUT_DATA <= 9'h173; // 's'
					LCD_LINE1+12: LUT_DATA <= 9'h173; // 's'
					LCD_LINE1+13: LUT_DATA <= 9'h16F; // 'o'
					LCD_LINE1+14: LUT_DATA <= 9'h120; // ' '
					LCD_LINE1+15: LUT_DATA <= 9'h130 + Msg - 20; // Numero
					
					LCD_LINE2+0: LUT_DATA <= 9'h171;  // 'q'
					LCD_LINE2+1: LUT_DATA <= 9'h175;  // 'u'
					LCD_LINE2+2: LUT_DATA <= 9'h165;  // 'e'
					LCD_LINE2+3: LUT_DATA <= 9'h120;  // ' '
					LCD_LINE2+4: LUT_DATA <= 9'h173;  // 's'
					LCD_LINE2+5: LUT_DATA <= 9'h165;  // 'e'
					LCD_LINE2+6: LUT_DATA <= 9'h172;  // 'r'
					LCD_LINE2+7: LUT_DATA <= 9'h161;  // 'a'
					LCD_LINE2+8: LUT_DATA <= 9'h120;  // ' '
					LCD_LINE2+9: LUT_DATA <= 9'h165;  // 'e'
					LCD_LINE2+10: LUT_DATA <= 9'h178; // 'x'
					LCD_LINE2+11: LUT_DATA <= 9'h165; // 'e'
					LCD_LINE2+12: LUT_DATA <= 9'h163; // 'c'
					LCD_LINE2+13: LUT_DATA <= 9'h13A; // ':'
					LCD_LINE2+14: LUT_DATA <= 9'h120; // ' '
					LCD_LINE2+15: LUT_DATA <= 9'h120; // ' '
					// ... [Complete a linha com espaços ou caracteres conforme necessário]

					LCD_CH_LINE:    LUT_DATA    <=    9'h0C0;
					// Tratar a segunda linha conforme necessário
					// ...

					default:        LUT_DATA    <=    9'dx ;
			  endcase
	end else if(Msg > 30) begin
				case(LUT_INDEX)
					LCD_INTIAL+0:    LUT_DATA    <=    9'h038;
					LCD_INTIAL+1:    LUT_DATA    <=    9'h00C;
					LCD_INTIAL+2:    LUT_DATA    <=    9'h001;
					LCD_INTIAL+3:    LUT_DATA    <=    9'h006;
					LCD_INTIAL+4:    LUT_DATA    <=    9'h080;
					
					LCD_LINE1+0: LUT_DATA <= 9'h130 + Msg - 30;  // ' '
					LCD_LINE1+1: LUT_DATA <= 9'h120;  // ' '
					LCD_LINE1+2: LUT_DATA <= 9'h163;  // 'C'
					LCD_LINE1+3: LUT_DATA <= 9'h16F;  // 'o'
					LCD_LINE1+4: LUT_DATA <= 9'h16D;  // 'm'
					LCD_LINE1+5: LUT_DATA <= 9'h120;  // ' '
					LCD_LINE1+6: LUT_DATA <= 9'h170;  // 'p'
					LCD_LINE1+7: LUT_DATA <= 9'h172;  // 'r'
					LCD_LINE1+8: LUT_DATA <= 9'h165;  // 'e'
					LCD_LINE1+9: LUT_DATA <= 9'h165;  // 'e'
					LCD_LINE1+10: LUT_DATA <= 9'h16D; // 'm'
					LCD_LINE1+11: LUT_DATA <= 9'h170; // 'p'
					LCD_LINE1+12: LUT_DATA <= 9'h163; // 'c'
					LCD_LINE1+13: LUT_DATA <= 9'h161; // 'a'
					LCD_LINE1+14: LUT_DATA <= 9'h16F; // 'o'
					LCD_LINE1+15: LUT_DATA <= 9'h13F; // '?'

					LCD_LINE2+0: LUT_DATA <= 9'h128;  // '('
					LCD_LINE2+1: LUT_DATA <= 9'h131;  // '1'
					LCD_LINE2+2: LUT_DATA <= 9'h120;  // ' '
					LCD_LINE2+3: LUT_DATA <= 9'h12D;  // '-'
					LCD_LINE2+4: LUT_DATA <= 9'h120;  // ' '
					LCD_LINE2+5: LUT_DATA <= 9'h153;  // 'S'
					LCD_LINE2+6: LUT_DATA <= 9'h12F;  // '/'
					LCD_LINE2+7: LUT_DATA <= 9'h120;  // ' '
					LCD_LINE2+8: LUT_DATA <= 9'h130;  // '0'
					LCD_LINE2+9: LUT_DATA <= 9'h120;  // ' '
					LCD_LINE2+10: LUT_DATA <= 9'h12D; // '-'
					LCD_LINE2+11: LUT_DATA <= 9'h120; // ' '
					LCD_LINE2+12: LUT_DATA <= 9'h14E; // 'N'
					LCD_LINE2+13: LUT_DATA <= 9'h129; // ')'
					LCD_LINE2+14: LUT_DATA <= 9'h120; // ' '
					LCD_LINE2+15: LUT_DATA <= 9'h120; // ' '

					LCD_CH_LINE:    LUT_DATA    <=    9'h0C0;
					// Tratar a segunda linha conforme necessário
					// ...

					default:        LUT_DATA    <=    9'dx ;
			endcase
	end
end

LCD_Controller LCD_Controller(
    //    Host Side
    .iDATA(mLCD_DATA),
    .iRS(mLCD_RS),
    .iStart(mLCD_Start),
    .oDone(mLCD_Done),
    .iCLK(iCLK),
    .iRST_N(iRST_N),
    //    LCD Interface
    .LCD_DATA(LCD_DATA),
    .LCD_RW(LCD_RW),
    .LCD_EN(LCD_EN),
    .LCD_RS(LCD_RS)    
);

endmodule