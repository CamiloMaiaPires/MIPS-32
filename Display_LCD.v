module Display_LCD(
    input CLK, Slow_Clock,
	 input setLCD,
	 input [31:0] Read_Data1,

    output [7:0] LCD_DATA,
    output LCD_ON, LCD_BLON, LCD_RW, LCD_EN, LCD_RS,
	 input reset
);

	wire DLY_RST;
	reg [31:0] Msg;
	
	assign    LCD_ON   = 1'b1;
	assign    LCD_BLON = 1'b1;
	
	always@(posedge Slow_Clock) 
	begin
		if(setLCD)
		begin 
			if(reset)begin
				Msg <= 32'b00000000000000000000000000001011;
			end else begin
				Msg <= Read_Data1;	
			end
		end
	end
	
	Reset_Delay r0(    .iCLK(CLK),.oRESET(DLY_RST) );
	
	LCD LCD(

		.iCLK(CLK),
		.iRST_N(DLY_RST),
		.Msg(Msg),

		.LCD_DATA(LCD_DATA),
		.LCD_RW(LCD_RW),
		.LCD_EN(LCD_EN),
		.LCD_RS(LCD_RS)
		
	);
endmodule