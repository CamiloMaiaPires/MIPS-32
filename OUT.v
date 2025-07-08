module OUT (
    input [31:0] out_data,
    input        out_flag,
    output reg [3:0] display1,
    output reg [3:0] display2,
    output reg [3:0] display3,
    output reg [3:0] display4,
    output reg [3:0] display5,
    output reg [3:0] display6,
    output reg [3:0] display7,
    output reg [3:0] display8
);

    always @(*) begin
        if (out_flag == 1) begin
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

endmodule

