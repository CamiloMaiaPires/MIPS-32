module LCD(
    // Host Side
    input CLK, Clock,
	 input setLCD,
	 input [31:0] Read_Data1,
    // LCD Side
    output [7:0] LCD_DATA,
    output LCD_ON, LCD_BLON, LCD_RW, LCD_EN, LCD_RS    
);

	wire DLY_RST;
	reg [31:0] Msg;
	
	assign    LCD_ON   = 1'b1;
	assign    LCD_BLON = 1'b1;
	
	always@(posedge Clock) 
	begin
		if(setLCD)
		begin 
			Msg <= Read_Data1;	
		end
	end
	
	Reset_Delay r0(    .iCLK(CLK),.oRESET(DLY_RST) );
	
	LCD_TEST u1(
	// Host Side
		.iCLK(CLK),
		.iRST_N(DLY_RST),
	// LCD Side
		.LCD_DATA(LCD_DATA),
		.LCD_RW(LCD_RW),
		.LCD_EN(LCD_EN),
		.LCD_RS(LCD_RS),
		.Msg(Msg)
		
	);
endmodule