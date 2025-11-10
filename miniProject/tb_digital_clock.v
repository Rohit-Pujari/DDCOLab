`timescale 1ns/1ps
module tb_digital_clock;
    reg tick;
    reg reset_n;
    reg alarm_en;
    reg alarm_reset_n;
    reg [4:0] alarm_hour;
    reg [5:0] alarm_min;
    reg [5:0] alarm_sec;

    wire [4:0] hour;
    wire [5:0] min;
    wire [5:0] sec;
    wire alarm_out;

    digital_clock_top dut (
        .tick(tick),
        .reset_n(reset_n),
        .alarm_hour(alarm_hour),
        .alarm_min(alarm_min),
        .alarm_sec(alarm_sec),
        .alarm_en(alarm_en),
        .alarm_reset_n(alarm_reset_n),
        .hour(hour),
        .min(min),
        .sec(sec),
        .alarm_out(alarm_out)
    );

    initial begin
        $dumpfile("clock_tb.vcd");
        $dumpvars(0, tb_digital_clock);
    end

    initial begin
        tick = 0;
        forever begin
            #5 tick = ~tick;
        end
    end

    initial begin
        reset_n = 0;
        alarm_reset_n = 1;
        alarm_en = 0;
        alarm_hour = 5'd0;
        alarm_min  = 6'd0;
        alarm_sec  = 6'd20;
        #30; 
        reset_n = 1; 

        #200; 
        alarm_en = 1;

        #400;

        $display("Time: %0t ns, Clock = %0d:%0d:%0d, alarm_out=%b", $time, hour, min, sec, alarm_out);

        #20;
        alarm_reset_n = 0;
        #10;
        alarm_reset_n = 1;
        alarm_en = 0;

        #200;
        $display("Simulation finished at %0t ns", $time);
        $finish;
    end

    always @(posedge tick) begin
        $display("T=%0t ns : %0d:%0d:%0d alarm=%b", $time, hour, min, sec, alarm_out);
    end

endmodule
