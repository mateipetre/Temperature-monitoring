`timescale 1ns / 1ps

module sensors_input (
    temp_sum_o,
    nr_active_sensors_o,
    sensors_data_i,
    sensors_en_i);
    
    reg[7:0] nr_active_sensors, temp;
    reg[15:0] temp_sum;
    // consider numarul de senzori ca parametru
    // pt a primi ca input un nr variabil, maxim 200
    parameter nr_sensors = 200;
    output [15:0] temp_sum_o;
    output [7:0] nr_active_sensors_o;
    // adaptez input-ul pt orice nr de senzori
    // primit de la test 
    input [8*nr_sensors-1:0] sensors_data_i;
    input [nr_sensors-1:0] sensors_en_i;
    integer i;
    always @(sensors_data_i or sensors_en_i) begin
        // initializez suma si numarul de senzori activi cu 0
        temp_sum = 0;
        nr_active_sensors = 0;
        // extrag din input pt fiecare senzor temperatura asociata pe 8 biti
        for(i = 0; i < nr_sensors; i = i + 1) begin
            // o creez prin concatenarea bitilor din input vazut ca un vector
            temp = {sensors_data_i[8*i + 7], sensors_data_i[8*i + 6], sensors_data_i[8*i + 5],
                    sensors_data_i[8*i + 4], sensors_data_i[8*i + 3], sensors_data_i[8*i + 2],
                    sensors_data_i[8*i + 1], sensors_data_i[8*i]};
            // daca bitul de enable e activat pt senzorul i
            // se aduna la suma temperatura corespunzatoare senzorului
            // si se incrementeaza nr de senzori activi
            if(sensors_en_i[i] == 1) begin
                temp_sum = temp_sum + temp;
                nr_active_sensors = nr_active_sensors + 1;
            end
        end
    end
    assign temp_sum_o = temp_sum;
    assign nr_active_sensors_o = nr_active_sensors;
endmodule