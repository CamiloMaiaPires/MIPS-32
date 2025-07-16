module Gerenciador_De_Saidas (
    input [31:0] entrada,
    input clk,  // Sinal de clock
    output reg [55:0] saida
);

    // Sinais intermediários para os dígitos
    wire [3:0] dez_milhoes, milhoes, cent_mil, dez_mil, mil, cent, tens, ones;
    
    // Instância para separar os dígitos
    Split_Digitos split (
        .value(entrada), 
		  .clk(clk),
        .dez_milhoes(dez_milhoes),
        .milhoes(milhoes),
        .cent_mil(cent_mil),
        .dez_mil(dez_mil),
        .mil(mil),
        .cent(cent),
        .tens(tens),
        .ones(ones)
    );

    // Contador para gerar o delay
    reg [15:0] contador = 0; // Ajuste o tamanho do contador conforme necessário
    reg atualiza = 0;

    always @(posedge clk) begin
        if (contador == 50000) begin  // Ajuste o valor do contador para o delay desejado
            atualiza <= 1;
            contador <= 0;  // Reinicia o contador
        end else begin
            atualiza <= 0;
            contador <= contador + 1;
        end
    end

    // Instâncias de cada módulo de display de 7 segmentos
    wire [55:0] saida_interna;

    display_7_seg dezmilhoes(.inp(dez_milhoes), .saida_7s(saida_interna[55:49]));
    display_7_seg milhoes_display(.inp(milhoes), .saida_7s(saida_interna[48:42]));
    display_7_seg cemmil(.inp(cent_mil), .saida_7s(saida_interna[41:35]));
    display_7_seg dezmil(.inp(dez_mil), .saida_7s(saida_interna[34:28]));
    display_7_seg mil_display(.inp(mil), .saida_7s(saida_interna[27:21]));
    display_7_seg centenas(.inp(cent), .saida_7s(saida_interna[20:14]));
    display_7_seg dezenas(.inp(tens), .saida_7s(saida_interna[13:7]));
    display_7_seg unidades(.inp(ones), .saida_7s(saida_interna[6:0]));

    // Atualiza a saída apenas quando o delay for atingido
    always @(posedge clk) begin
        if (atualiza) begin
            saida <= saida_interna;
        end
    end
endmodule