`timescale 1ns / 1ps

module output_display (
    output [7:0] coded_out_o,
    output alert_o,
    input [15:0] temp_Q_i,
    input [15:0] temp_R_i,
    input [7:0] active_sensors_nr);
    
    reg[15:0] aprox_temp; // va retine temperatura aproximata 
    reg[7:0] coded_out;
    reg alert;
    always @(temp_Q_i or temp_R_i or active_sensors_nr) begin
        // se compara restul cu jumatatea impartitorului
        // daca restul e mai mare sau egal, temperatura 
        // se aproximeaza la catul obtinut + 1
        if(2*temp_R_i >= active_sensors_nr) begin
            aprox_temp = temp_Q_i + 1;
        end
        else
            // altfel se aproximeaza direct la cat
            aprox_temp = temp_Q_i;
        
        // temperatura aproximata se codifica         
        // in modul scara prezentat in cerinta
        if(aprox_temp == 19) begin
            coded_out = 8'b0000_0001;
            alert = 0;
        end
        if(aprox_temp == 20) begin
            coded_out = 8'b0000_0011;
            alert = 0;
        end
        if(aprox_temp == 21) begin
            coded_out = 8'b0000_0111;
            alert = 0;
        end
        if(aprox_temp == 22) begin
            coded_out = 8'b0000_1111;
            alert = 0;
        end
        if(aprox_temp == 23) begin
            coded_out = 8'b0001_1111;
            alert = 0;
        end
        if(aprox_temp == 24) begin
            coded_out = 8'b0011_1111;
            alert = 0;
        end
        if(aprox_temp == 25) begin
            coded_out = 8'b0111_1111;
            alert = 0;
        end
        if(aprox_temp == 26) begin
            coded_out = 8'b1111_1111;
            alert = 0;
        end
        if(aprox_temp < 19) begin
            coded_out = 8'b0000_0001;
            alert = 1;
        end
        if(aprox_temp > 26) begin
            coded_out = 8'b1111_1111;
            alert = 1;
        end
    end 
    assign coded_out_o = coded_out;
    assign alert_o = alert;
endmodule
