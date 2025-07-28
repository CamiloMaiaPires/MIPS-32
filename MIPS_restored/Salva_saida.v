module Salva_saida (
    input clk, 
    input [31:0] data,
    input out_flag,
    output reg [31:0] out_data
);

    always @(posedge clk) begin  
        if (out_flag) begin
            out_data <= data;
        end
    end

endmodule 