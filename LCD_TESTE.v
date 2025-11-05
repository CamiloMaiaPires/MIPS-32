module LCD_AAAA (
    // Host Side
    input iCLK, iRST_N, 
    input [31:0] Msg,  // Mantido conforme o original
    // LCD Side
    output [7:0] LCD_DATA,
    output LCD_RW, LCD_EN, LCD_RS    
);

    // -----------------------------
    //   SINAIS INTERNOS
    // -----------------------------
    reg [5:0]  LUT_INDEX;
    reg [8:0]  LUT_DATA;
    reg [5:0]  mLCD_ST;
    reg [17:0] mDLY;
    reg        mLCD_Start;
    reg [7:0]  mLCD_DATA;
    reg        mLCD_RS;
    wire       mLCD_Done;
    reg [31:0] lastMsg; // mantém o último valor de Msg

    // -----------------------------
    //   PARÂMETROS DE CONTROLE
    // -----------------------------
    parameter LCD_INITIAL = 0;
    parameter LCD_LINE1   = 5;
    parameter LCD_CH_LINE = LCD_LINE1 + 16;
    parameter LCD_LINE2   = LCD_LINE1 + 16 + 1;
    parameter LUT_SIZE    = LCD_LINE1 + 32 + 1;

    // -----------------------------
    //   FSM PRINCIPAL
    // -----------------------------
    always @(posedge iCLK or negedge iRST_N) begin
        if (!iRST_N) begin
            LUT_INDEX   <= 0;
            mLCD_ST     <= 0;
            mDLY        <= 0;
            mLCD_Start  <= 0;
            mLCD_DATA   <= 0;
            mLCD_RS     <= 0;
            lastMsg     <= 0;
        end else begin
            // 🔁 Se Msg mudou, reinicia a sequência
            if (lastMsg != Msg) begin
                LUT_INDEX <= 0;
            end
            lastMsg <= Msg;

            // Máquina de estados principal
            if (LUT_INDEX < LUT_SIZE) begin
                case (mLCD_ST)
                    0: begin
                        mLCD_DATA  <= LUT_DATA[7:0];
                        mLCD_RS    <= LUT_DATA[8];
                        mLCD_Start <= 1;
                        mLCD_ST    <= 1;
                    end
                    1: begin
                        if (mLCD_Done) begin
                            mLCD_Start <= 0;
                            mLCD_ST    <= 2;
                        end
                    end
                    2: begin
                        if (mDLY < 18'h3FFFE)
                            mDLY <= mDLY + 1'b1;
                        else begin
                            mDLY <= 0;
                            mLCD_ST <= 3;
                        end
                    end
                    3: begin
                        LUT_INDEX <= LUT_INDEX + 1'b1;
                        mLCD_ST <= 0;
                    end
                endcase
            end
        end
    end

    // -----------------------------
    //   LUT COM DUAS MENSAGENS
    // -----------------------------
    always @(*) begin
        case (Msg[0]) // usa só o bit 0 para alternar mensagens
            // =====================================================
            // Msg = 0 → "HELLO WORLD" / "TEST MESSAGE"
            // =====================================================
            1'b0: begin
                case (LUT_INDEX)
                    // Inicialização
                    LCD_INITIAL+0: LUT_DATA <= 9'h038;
                    LCD_INITIAL+1: LUT_DATA <= 9'h00C;
                    LCD_INITIAL+2: LUT_DATA <= 9'h001;
                    LCD_INITIAL+3: LUT_DATA <= 9'h006;
                    LCD_INITIAL+4: LUT_DATA <= 9'h080;

                    // Linha 1: "HELLO WORLD"
                    LCD_LINE1+0:  LUT_DATA <= 9'h148; // H
                    LCD_LINE1+1:  LUT_DATA <= 9'h145; // E
                    LCD_LINE1+2:  LUT_DATA <= 9'h14C; // L
                    LCD_LINE1+3:  LUT_DATA <= 9'h14C; // L
                    LCD_LINE1+4:  LUT_DATA <= 9'h14F; // O
                    LCD_LINE1+5:  LUT_DATA <= 9'h120; // (space)
                    LCD_LINE1+6:  LUT_DATA <= 9'h157; // W
                    LCD_LINE1+7:  LUT_DATA <= 9'h14F; // O
                    LCD_LINE1+8:  LUT_DATA <= 9'h152; // R
                    LCD_LINE1+9:  LUT_DATA <= 9'h14C; // L
                    LCD_LINE1+10: LUT_DATA <= 9'h144; // D
                    LCD_LINE1+11: LUT_DATA <= 9'h120;
                    LCD_LINE1+12: LUT_DATA <= 9'h120;
                    LCD_LINE1+13: LUT_DATA <= 9'h120;
                    LCD_LINE1+14: LUT_DATA <= 9'h120;
                    LCD_LINE1+15: LUT_DATA <= 9'h120;

                    // Muda para linha 2
                    LCD_CH_LINE:  LUT_DATA <= 9'h0C0;

                    // Linha 2: "TEST MESSAGE"
                    LCD_LINE2+0:  LUT_DATA <= 9'h154; // T
                    LCD_LINE2+1:  LUT_DATA <= 9'h145; // E
                    LCD_LINE2+2:  LUT_DATA <= 9'h153; // S
                    LCD_LINE2+3:  LUT_DATA <= 9'h154; // T
                    LCD_LINE2+4:  LUT_DATA <= 9'h120;
                    LCD_LINE2+5:  LUT_DATA <= 9'h14D; // M
                    LCD_LINE2+6:  LUT_DATA <= 9'h145; // E
                    LCD_LINE2+7:  LUT_DATA <= 9'h153; // S
                    LCD_LINE2+8:  LUT_DATA <= 9'h153; // S
                    LCD_LINE2+9:  LUT_DATA <= 9'h141; // A
                    LCD_LINE2+10: LUT_DATA <= 9'h147; // G
                    LCD_LINE2+11: LUT_DATA <= 9'h145; // E
                    LCD_LINE2+12: LUT_DATA <= 9'h120;
                    LCD_LINE2+13: LUT_DATA <= 9'h120;
                    LCD_LINE2+14: LUT_DATA <= 9'h120;
                    LCD_LINE2+15: LUT_DATA <= 9'h120;

                    default: LUT_DATA <= 9'h000;
                endcase
            end

            // =====================================================
            // Msg = 1 → "PROCESSANDO" / "AGUARDE..."
            // =====================================================
            1'b1: begin
                case (LUT_INDEX)
                    // Inicialização
                    LCD_INITIAL+0: LUT_DATA <= 9'h038;
                    LCD_INITIAL+1: LUT_DATA <= 9'h00C;
                    LCD_INITIAL+2: LUT_DATA <= 9'h001;
                    LCD_INITIAL+3: LUT_DATA <= 9'h006;
                    LCD_INITIAL+4: LUT_DATA <= 9'h080;

                    // Linha 1: "PROCESSANDO"
                    LCD_LINE1+0:  LUT_DATA <= 9'h150; // P
                    LCD_LINE1+1:  LUT_DATA <= 9'h172; // r
                    LCD_LINE1+2:  LUT_DATA <= 9'h16F; // o
                    LCD_LINE1+3:  LUT_DATA <= 9'h163; // c
                    LCD_LINE1+4:  LUT_DATA <= 9'h165; // e
                    LCD_LINE1+5:  LUT_DATA <= 9'h173; // s
                    LCD_LINE1+6:  LUT_DATA <= 9'h173; // s
                    LCD_LINE1+7:  LUT_DATA <= 9'h161; // a
                    LCD_LINE1+8:  LUT_DATA <= 9'h16E; // n
                    LCD_LINE1+9:  LUT_DATA <= 9'h164; // d
                    LCD_LINE1+10: LUT_DATA <= 9'h16F; // o
                    LCD_LINE1+11: LUT_DATA <= 9'h120;
                    LCD_LINE1+12: LUT_DATA <= 9'h120;
                    LCD_LINE1+13: LUT_DATA <= 9'h120;
                    LCD_LINE1+14: LUT_DATA <= 9'h120;
                    LCD_LINE1+15: LUT_DATA <= 9'h120;

                    // Muda para linha 2
                    LCD_CH_LINE:  LUT_DATA <= 9'h0C0;

                    // Linha 2: "AGUARDE..."
                    LCD_LINE2+0:  LUT_DATA <= 9'h141; // A
                    LCD_LINE2+1:  LUT_DATA <= 9'h147; // G
                    LCD_LINE2+2:  LUT_DATA <= 9'h155; // U
                    LCD_LINE2+3:  LUT_DATA <= 9'h141; // A
                    LCD_LINE2+4:  LUT_DATA <= 9'h172; // r
                    LCD_LINE2+5:  LUT_DATA <= 9'h164; // d
                    LCD_LINE2+6:  LUT_DATA <= 9'h145; // e
                    LCD_LINE2+7:  LUT_DATA <= 9'h12E; // .
                    LCD_LINE2+8:  LUT_DATA <= 9'h12E; // .
                    LCD_LINE2+9:  LUT_DATA <= 9'h12E; // .
                    LCD_LINE2+10: LUT_DATA <= 9'h120;
                    LCD_LINE2+11: LUT_DATA <= 9'h120;
                    LCD_LINE2+12: LUT_DATA <= 9'h120;
                    LCD_LINE2+13: LUT_DATA <= 9'h120;
                    LCD_LINE2+14: LUT_DATA <= 9'h120;
                    LCD_LINE2+15: LUT_DATA <= 9'h120;

                    default: LUT_DATA <= 9'h000;
                endcase
            end
        endcase
    end

    // -----------------------------
    //   CONTROLADOR DO LCD
    // -----------------------------
    LCD_Controller LCD_Controller(
        .iDATA(mLCD_DATA),
        .iRS(mLCD_RS),
        .iStart(mLCD_Start),
        .oDone(mLCD_Done),
        .iCLK(iCLK),
        .iRST_N(iRST_N),
        .LCD_DATA(LCD_DATA),
        .LCD_RW(LCD_RW),
        .LCD_EN(LCD_EN),
        .LCD_RS(LCD_RS)
    );

endmodule
