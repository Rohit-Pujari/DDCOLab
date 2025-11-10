`timescale 1ns/1ps
module alarm_module(
    input  wire [4:0] cur_hour,    
    input  wire [5:0] cur_min,     
    input  wire [5:0] cur_sec,     
    input  wire [4:0] alarm_hour,
    input  wire [5:0] alarm_min,
    input  wire [5:0] alarm_sec,
    input  wire alarm_en,          
    input  wire clk,               
    input  wire reset_n,           
    output reg  alarm_out          
);

    wire match = alarm_en &&
                 (cur_hour == alarm_hour) &&
                 (cur_min  == alarm_min)  &&
                 (cur_sec  == alarm_sec);

    always @(posedge clk or negedge reset_n) begin
        if (!reset_n)
            alarm_out <= 1'b0;
        else if (match)
            alarm_out <= 1'b1;
        else
            alarm_out <= alarm_out; 
    end

endmodule
