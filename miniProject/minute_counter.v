`timescale 1ns/1ps
module minute_counter(
    input  wire minute_tick, 
    input  wire reset_n,
    output reg  [5:0] min,   
    output reg  hour_tick    
);
    always @(posedge minute_tick or negedge reset_n) begin
        if (!reset_n) begin
            min <= 6'd0;
            hour_tick <= 1'b0;
        end else begin
            if (min == 6'd59) begin
                min <= 6'd0;
                hour_tick <= 1'b1;
            end else begin
                min <= min + 6'd1;
                hour_tick <= 1'b0;
            end
        end
    end
endmodule
