`timescale 1ns/1ps
module hour_counter(
    input  wire hour_tick,   
    input  wire reset_n,
    output reg  [4:0] hour   
);
    always @(posedge hour_tick or negedge reset_n) begin
        if (!reset_n) begin
            hour <= 5'd0;
        end else begin
            if (hour == 5'd23)
                hour <= 5'd0;
            else
                hour <= hour + 5'd1;
        end
    end
endmodule
