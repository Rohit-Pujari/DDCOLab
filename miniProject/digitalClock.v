module digitalClock (
    input clk,             
    input reset,
    input [4:0] alarm_hour,
    input [5:0] alarm_min,
    input [5:0] alarm_sec,
    output reg [4:0] hour,
    output reg [5:0] min, 
    output reg [5:0] sec,
    output alarm
);

    assign alarm = (hour == alarm_hour && min == alarm_min && sec == alarm_sec);

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            hour <= 0;
            min  <= 0;
            sec  <= 0;
        end else begin
            if (sec == 59) begin
                sec <= 0;
                if (min == 59) begin
                    min <= 0;
                    if (hour == 23)
                        hour <= 0;
                    else
                        hour <= hour + 1;
                end else begin
                    min <= min + 1;
                end
            end else begin
                sec <= sec + 1;
            end
        end
    end
endmodule
