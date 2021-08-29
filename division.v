`timescale 1ns / 1ps

module division (
    output [15:0] Q,
    output [15:0] R,
    input [15:0] N,
    input [15:0] D);
    
    integer i;
    reg[15:0] Q_aux, R_aux;
    always @(N or D) begin
        // se initializeaza catul si restul cu 0
        Q_aux = 0;
        R_aux = 0;
        // se implementeaza integer division pt cazul unsigned
        // pentru deimpartit si impartitor pe 16 biti
        for(i = 15; i >= 0; i = i - 1) begin
            R_aux = R_aux << 1;
            R_aux[0] = N[i];
            // de fiecare data cand restul este mai mare 
            // decat impartitorul, se scade impartitorul din rest
            // si se seteaza bitul i al catului pe 1
            if(R_aux >= D) begin
                R_aux = R_aux - D;
                Q_aux[i] = 1;
            end
        end
    end
    assign Q = Q_aux;
    assign R = R_aux;
endmodule