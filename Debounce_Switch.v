module Debounce_Switch(
    input clk,           // Clock do sistema
    input switch_in,     // Entrada do switch
    output reg switch_out // Saída com debounce
);
    // Registradores para sincronização
    reg button_sync0, button_sync1;

    always @(posedge clk) begin
        button_sync0 <= switch_in;  // Removida inversão
        button_sync1 <= button_sync0;
    end

    // Contador para o debounce
    reg [16:0] counter;

    // Inicializar switch_out
    initial switch_out = 0;

    // Detectar mudança de estado e aplicar debounce
    always @(posedge clk) begin
        if (switch_out == button_sync1) begin
            counter <= 0;  // Se o estado é estável, resetar contador
        end else begin
            counter <= counter + 1; // Incrementar contador
            
            if (&counter) begin // Se o contador atingir o máximo
                switch_out <= button_sync1; // Atualizar estado do switch
            end
        end
    end
endmodule