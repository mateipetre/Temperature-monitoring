`timescale 1ns / 1ps
module temperature_top (
    led_output_o,
    alert_o,
    sensors_data_i,
    sensors_en_i);
    
    // consider numarul de senzori ca parametru
    // pt a primi ca input un nr variabil, maxim 200
    parameter nr_sensors = 200;
    output [7:0] led_output_o;
    output alert_o;
    // adaptez input-ul pt orice nr de senzori
    // primit de la test
    input [8*nr_sensors-1:0] sensors_data_i;
    input [nr_sensors-1:0] sensors_en_i;
    // declar toate variabilele necesare conexiunii modulelor
    // care vor fi atat de input cat si de output pt cele 3 module
    wire[15:0] temp_sum, temp_Q, temp_R, nr_active_sensors_16bit;
    wire[7:0] nr_active_sensors;
    // instantiez cele 3 module si le conectez prin variabilele declarate
    sensors_input si(temp_sum, nr_active_sensors, sensors_data_i, sensors_en_i);
    // am nevoie de nr de senzori activi si pe 16 biti pt inputul lui division
    // a fost declarat anterior pe 8 biti
    assign nr_active_sensors_16bit = nr_active_sensors;
    division d(temp_Q, temp_R, temp_sum, nr_active_sensors_16bit);
    output_display od(led_output_o, alert_o, temp_Q, temp_R, nr_active_sensors);
endmodule
