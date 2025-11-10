`timescale 1ns/1ps
module digital_clock_top(
    input  wire tick,           
    input  wire reset_n,        
    input  wire [4:0] alarm_hour,
    input  wire [5:0] alarm_min,
    input  wire [5:0] alarm_sec,
    input  wire alarm_en,
    input  wire alarm_reset_n,
    output wire [4:0] hour,
    output wire [5:0] min,
    output wire [5:0] sec,
    output wire alarm_out
);

    wire minute_tick;
    wire hour_tick;

    second_counter sec_cnt (
        .tick(tick),
        .reset_n(reset_n),
        .sec(sec),
        .minute_tick(minute_tick)
    );

    minute_counter min_cnt (
        .minute_tick(minute_tick),
        .reset_n(reset_n),
        .min(min),
        .hour_tick(hour_tick)
    );

    hour_counter hr_cnt (
        .hour_tick(hour_tick),
        .reset_n(reset_n),
        .hour(hour)
    );

    alarm_module alarm (
        .cur_hour(hour),
        .cur_min(min),
        .cur_sec(sec),
        .alarm_hour(alarm_hour),
        .alarm_min(alarm_min),
        .alarm_sec(alarm_sec),
        .alarm_en(alarm_en),
        .clk(tick),              
        .reset_n(alarm_reset_n), 
        .alarm_out(alarm_out)
    );
endmodule