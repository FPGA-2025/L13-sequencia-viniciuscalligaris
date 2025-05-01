module Sequencia (
    input wire clk,
    input wire rst_n,
    input wire setar_palavra,
    input wire [7:0] palavra,
    input wire start,
    input wire bit_in,
    output reg encontrado
);
    reg [7:0] palavra_buscada;          
    reg [7:0] deslocamento_recebido;             
    reg buscando;                   

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            palavra_buscada <= 8'b0;
            deslocamento_recebido <= 8'b0;
            encontrado <= 1'b0;
            buscando <= 1'b0;
        end else begin
            if (setar_palavra) begin
                palavra_buscada <= palavra;
                encontrado <= 1'b0;
                buscando <= 1'b0;
            end else if (start) begin
                buscando <= 1'b1;
                encontrado <= 1'b0;
            end

            if (buscando && !encontrado) begin
                deslocamento_recebido <= {deslocamento_recebido[6:0], bit_in};

                if (deslocamento_recebido == palavra_buscada) begin
                    encontrado <= 1'b1;
                    buscando <= 1'b0; 
                end
            end
        end
    end

endmodule
