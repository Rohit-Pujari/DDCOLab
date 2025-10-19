`timescale 1ns/1ns
module digitalClockTb;
    reg clk = 0;
    reg reset = 0;
    wire [4:0] hour;
    wire [5:0] min, sec;
    wire alarm;

    digitalClock uut (
        .clk(clk),
        .reset(reset),
        .alarm_hour(5'd0),
        .alarm_min(6'd0),
        .alarm_sec(6'd10),
        .hour(hour),
        .min(min),
        .sec(sec),
        .alarm(alarm)
    );

    always #0.5 clk = ~clk;

    initial begin
        $dumpfile("clock.vcd");
        $dumpvars(0, digitalClockTb);

        reset = 1;
        #1 reset = 0;

        #70;
        $finish;
    end
endmodule
