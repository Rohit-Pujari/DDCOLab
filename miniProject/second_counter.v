`timescale 1ns/1ps
module second_counter(
    input  wire tick,       
    input  wire reset_n,    
    output reg  [5:0] sec,  
    output reg  minute_tick 
);
    always @(posedge tick or negedge reset_n) begin
        if (!reset_n) begin
            sec <= 6'd0;
            minute_tick <= 1'b0;
        end else begin
            if (sec == 6'd59) begin
                sec <= 6'd0;
                minute_tick <= 1'b1;
            end else begin
                sec <= sec + 6'd1;
                minute_tick <= 1'b0;
            end
        end
    end
endmodule
