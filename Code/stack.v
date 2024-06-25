module myStack #(
    parameter n = 4
) (
    input clk,
    input rst,
    input [2:0] opcode,
    input [n - 1:0] input_data,
    output signed [n - 1:0] output_data,
    output reg overflow
);
    
    reg signed [n - 1:0] mem [1023:0];
    reg [10:0] head = 1'b0;
    reg signed [2 * n - 1:0] temp;

    assign output_data[n - 1:0] = temp[n - 1:0];

    always @(posedge clk, negedge rst) begin
        if (rst === 1'b0) begin
            head = 0;
            overflow = 1'b0;
            temp = 0;
        end

        else begin
            case (opcode)
                3'b110:
                    begin
                        if (head < (2 ** 10)) begin
                            mem[head] = input_data;
                            head = head + 1;
                            overflow = 1'bx;
                            temp = {n{1'bx}};
                        end
                        else begin
                            $display("stack is full, can't push!");
                        end
                    end
                
                3'b111:
                    begin
                        if (head != 0) begin
                            head = head - 1;
                            overflow = 1'bx;
                            temp = {n{1'bx}};
                        end
                        else begin
                            $display("stack is empty, can't pop!");
                        end
                    end

                3'b100:
                    begin
                        if (head >= 2) begin
                            temp = mem[head - 1] + mem[head - 2];
                            if ((temp >= (2 ** (n - 1))) || (temp < -(2 ** (n - 1)))) begin
                                overflow = 1'b1;
                            end else begin
                                overflow = 1'b0;
                            end
                        end
                        else begin
                            $display("We don't have 2 elements in stack.");
                        end
                    end

                3'b101:
                    begin
                        if (head >= 2) begin
                            temp = mem[head - 1] * mem[head - 2];
                            if (temp >= (2 ** (n - 1)) || temp < -(2 ** (n - 1))) begin
                                overflow = 1'b1;
                            end else begin
                                overflow = 1'b0;
                            end
                        end
                        else begin
                            $display("We don't have 2 elements in stack.");
                        end
                    end


                default: 
                    begin
                        overflow = 1'bx;
                        temp = {n{1'bx}};
                    end
            endcase
        end

    end

endmodule