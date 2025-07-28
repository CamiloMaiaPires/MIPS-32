/*module OUT (
    input [31:0] out_data,
    input out_flag,
    output reg [6:0] seg1,
    output reg [6:0] seg2,
    output reg [6:0] seg3,
    output reg [6:0] seg4,
    output reg [6:0] seg5,
    output reg [6:0] seg6,
    output reg [6:0] seg7,
    output reg [6:0] seg8
);

    reg [3:0] display1, display2, display3, display4;
    reg [3:0] display5, display6, display7, display8;
	 
    // Conversão de número inteiro para dígitos decimais
    always @(*) begin
        if (out_flag == 1'b1) begin
            display1 = (out_data % 10);
            display2 = (out_data / 10) % 10;
            display3 = (out_data / 100) % 10;
            display4 = (out_data / 1000) % 10;
            display5 = (out_data / 10000) % 10;
            display6 = (out_data / 100000) % 10;
            display7 = (out_data / 1000000) % 10;
            display8 = (out_data / 10000000) % 10;
        end
    end

    // Função para decodificar dígito para 7 segmentos
    function [6:0] decode7seg;
        input [3:0] digit;
        begin
            case (digit)
                4'd0: decode7seg = 7'b1111110;
                4'd1: decode7seg = 7'b0110000;
                4'd2: decode7seg = 7'b1101101;
                4'd3: decode7seg = 7'b1111001;
                4'd4: decode7seg = 7'b0110011;
                4'd5: decode7seg = 7'b1011011;
                4'd6: decode7seg = 7'b1011111;
                4'd7: decode7seg = 7'b1110000;
                4'd8: decode7seg = 7'b1111111;
                4'd9: decode7seg = 7'b1111011;
                default: decode7seg = 7'b0000000;
            endcase
        end
    endfunction

    // Aplicando a decodificação
    always @(*) begin
		if (out_flag == 1'b1) begin
        seg1 = ~decode7seg(display1);
        seg2 = ~decode7seg(display2);
        seg3 = ~decode7seg(display3);
        seg4 = ~decode7seg(display4);
        seg5 = ~decode7seg(display5);
        seg6 = ~decode7seg(display6);
        seg7 = ~decode7seg(display7);
        seg8 = ~decode7seg(display8);
		end
    end

endmodule*/


module OUT(
    input  [31:0] value,
    input clk,
    output reg [3:0] dez_milhoes,
    output reg [3:0] milhoes,
    output reg [3:0] cent_mil,
    output reg [3:0] dez_mil,
    output reg [3:0] mil,
    output reg [3:0] cent,
    output reg [3:0] tens,
    output reg [3:0] ones
);

    always @(posedge clk) begin
        dez_milhoes <= (value / 10000000) % 10;
        milhoes <= (value / 1000000) % 10;
        cent_mil <= (value / 100000) % 10;
        dez_mil <= (value / 10000) % 10;
        mil <= (value / 1000) % 10;
        cent <= (value / 100) % 10;
        tens <= (value / 10) % 10;
        ones <= value % 10;
    end

endmodule
