module stimulus ();

    reg clk = 1'b0;
    reg rst = 1'b1;
    reg [2:0] opcode_4;
    reg signed [3:0] input_data_4;
    wire signed [3:0] output_data_4;
    wire overflow_4;
    
    reg [2:0] opcode_8;
    reg signed [7:0] input_data_8;
    wire signed [7:0] output_data_8;
    wire overflow_8;

    reg [2:0] opcode_16;
    reg signed [15:0] input_data_16;
    wire signed [15:0] output_data_16;
    wire overflow_16;

    reg [2:0] opcode_32;
    reg signed [31:0] input_data_32;
    wire signed [31:0] output_data_32;
    wire overflow_32;



    always begin
        #1 clk = ~clk;
    end

    myStack #(.n(4)) stack4(clk, rst, opcode_4, input_data_4, output_data_4, overflow_4);
    myStack #(.n(8)) stack8(clk, rst, opcode_8, input_data_8, output_data_8, overflow_8);
    myStack #(.n(16)) stack16(clk, rst, opcode_16, input_data_16, output_data_16, overflow_16);
    myStack #(.n(32)) stack32(clk, rst, opcode_32, input_data_32, output_data_32, overflow_32);

    initial begin
        $display("checking 4 bit:");
        opcode_4 = 3'b110;
        input_data_4 = 4'd2;
        #2;
        input_data_4 = -4'd4;
        #2;
        opcode_4 = 3'b101; // multiplying -4 with 2 to get -8 which will not overflow
        #2
        $display("time: %t, multiplying -4 by 2, not overflowing, result: %d, overflow: %b", $time, output_data_4, overflow_4);
        opcode_4 = 3'b111;
        #2
        opcode_4 = 3'b110;
        input_data_4 = 4'd4;
        #2
        opcode_4 = 3'b101; // mulitplying 4 with 2 to get 8 which will   overflow

        #2;
        $display("time: %t, multiplying 4 by 2, will overflow, result: %d, overflow: %b", $time, output_data_4, overflow_4);
        opcode_4 = 3'b110;
        input_data_4 = 4'd3;
        #2
        input_data_4 = 4'd4;
        #2
        opcode_4 = 3'b100; // adding 3 to 4 which will not overflow
        #2
        $display("time: %t,  adding 3 with 4, will not overflow, result: %d, overflow: %b", $time, output_data_4, overflow_4);
        opcode_4 = 3'b111;
        #2
        opcode_4 = 3'b110;
        input_data_4 = 4'd5;
        #2
        opcode_4 = 3'b100; // adding 3 to 5 which will overflow
        
        #2 
        $display("time: %t, adding 4 with 4, will overflow, result: %d, overflow: %b", $time, output_data_4, overflow_4 );
        opcode_4 = 3'b000;

        // 8bit ----------------------------------

        $display("checking 8 bit:");
        opcode_8 = 3'b110;
        input_data_8 = 8'd32;
        #2;
        input_data_8 = -8'd4;
        #2;
        opcode_8 = 3'b101; // multiplying -4 with 32 to get -128 which will not overflow
        #2
        $display("time: %t, multiplying -4 by 32, not overflowing, result: %d, overflow: %b", $time, output_data_8, overflow_8);
        opcode_8 = 3'b111; // pop
        #2
        opcode_8 = 3'b110;
        input_data_8 = 8'd4;
        #2
        opcode_8 = 3'b101; // mulitplying 4 with 2 to get 128 which will overflow

        #2;
        $display("time: %t, multiplying 4 by 32, will overflow, result: %d, overflow: %b", $time, output_data_8, overflow_8);
        opcode_8 = 3'b110;
        input_data_8 = 8'd63;
        #2
        input_data_8 = 8'd64;
        #2
        opcode_8 = 3'b100; // adding 63 to 64 which will not overflow
        #2
        $display("time: %t,  adding 63 with 64, will not overflow, result: %d, overflow: %b", $time, output_data_8, overflow_8);
        opcode_8 = 3'b111;
        #2
        opcode_8 = 3'b110;
        input_data_8 = 8'd65;
        #2
        opcode_8 = 3'b100; // adding 63 to 65 which will overflow
        #2 
        $display("time: %t, adding 63 with 65, will overflow, result: %d, overflow: %b", $time, output_data_8, overflow_8);
        opcode_8 = 3'b000;

        // 16bit ----------------------------------

        $display("checking 16 bit:");
        opcode_16 = 3'b110;
        input_data_16 = 16'd8192;
        #2;
        input_data_16 = -16'd4;
        #2;
        opcode_16 = 3'b101; // multiplying -4 with 8192 to get -32768 which will not overflow
        #2
        $display("time: %t, multiplying -4 by 8192, not overflowing, result: %d, overflow: %b", $time, output_data_16, overflow_16);
        opcode_16 = 3'b111;
        #2
        opcode_16 = 3'b110;
        input_data_16 = 16'd4;
        #2
        opcode_16 = 3'b101; // mulitplying 4 with 8192 to get 32768 which will overflow

        #2;
        $display("time: %t, multiplying 4 by 32, will overflow, result: %d, overflow: %b", $time, output_data_16, overflow_16);
        opcode_16 = 3'b110;
        input_data_16 = 16'd16383;
        #2
        input_data_16 = 16'd16384;
        #2
        opcode_16 = 3'b100; // adding 63 to 64 which will not overflow
        #2
        $display("time: %t,  adding 16383 with 16384, will not overflow, result: %d, overflow: %b", $time, output_data_16, overflow_16);
        opcode_16 = 3'b111;
        #2
        opcode_16 = 3'b110;
        input_data_16 = 16'd16385;
        #2
        opcode_16 = 3'b100; // adding 16383 to 16385 which will overflow
        #2 
        $display("time: %t, adding 16383 with 16385, will overflow, result: %d, overflow: %b", $time, output_data_16, overflow_16);
        opcode_16 = 3'b000;

        // 32bit ----------------------------------

        $display("checking 32 bit:");
        opcode_32 = 3'b110;
        input_data_32 = 32'd536_870_912;
        #2;
        input_data_32 = -32'd4;
        #2;
        opcode_32 = 3'b101; // multiplying -4 with 8192 to get -32768 which will not overflow
        #2
        $display("time: %t, multiplying -4 by 2^29, not overflowing, result: %d, overflow: %b", $time, output_data_32, overflow_32);
        opcode_32 = 3'b111;
        #2
        opcode_32 = 3'b110;
        input_data_32 = 32'd4;
        #2
        opcode_32 = 3'b101; // mulitplying 4 with 8192 to get 32768 which will overflow

        #2;
        $display("time: %t, multiplying 4 by 2^29, will overflow, result: %d, overflow: %b", $time, output_data_32, overflow_32);
        opcode_32 = 3'b110;
        input_data_32 = 32'd1_073_741_823;
        #2
        input_data_32 = 32'd1_073_741_824;
        #2
        opcode_32 = 3'b100; // adding 63 to 64 which will not overflow
        #2
        $display("time: %t,  adding 2^31-1 with 2^31, will not overflow, result: %d, overflow: %b", $time, output_data_32, overflow_32);
        opcode_32 = 3'b111;
        #2
        opcode_32 = 3'b110;
        input_data_32 = 32'd1_073_741_825;
        #2
        opcode_32 = 3'b100; // adding 1073741823 to 1073741825 which will overflow
        #2 
        $display("time: %t, adding 2^31 - 1 with 2^31 + 1, will overflow, result: %d, overflow: %b", $time, output_data_32, overflow_32);
        opcode_32 = 3'b000;



    end

    initial begin
        // $monitor("time: %t, output_data: %d, overflow: %b", $time, output_data_4, overflow_4);
    end
    
endmodule