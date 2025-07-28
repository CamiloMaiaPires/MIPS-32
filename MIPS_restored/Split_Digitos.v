module Split_Digitos(
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