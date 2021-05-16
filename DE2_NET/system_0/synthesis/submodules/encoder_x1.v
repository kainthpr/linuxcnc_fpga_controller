module encoder_x1(
    clk50,
    reset_n,
    enc_a,
    enc_b,
    count
);
    input clk50;
    input reset_n;
    input enc_a;
    input enc_b;
    output reg [31:0]count;
    
    reg a, a1, b, b1;
    reg last_a, last_b;

    always@(posedge clk50) begin // latch it twice
        a1 <= enc_a;
        a <= a1;
        b1 <= enc_b;
        b <= b1;
    end
    
    always @(posedge clk50) begin
        last_a <= a;
        last_b <= b;
    end

    always @(posedge clk50 or negedge reset_n) begin
        if(!reset_n) begin
            count <= 32'h7FFFFFFF;
        end
        else begin
            if  ((a == 1) && (b == 0)) begin // state 1
                if ((last_a == 0) && (last_b == 0)) begin // last state was 0. State 0 to 1 transition. Increment
                    count <= count + 31'b1;
                end
                else begin  // don't do anything
                    count <= count;
                end
            end
            else if  ((a == 0) && (b == 0)) begin // state 0
                if ((last_a == 1) && (last_b == 0)) begin // last state was 1. State 1 to 0 transition. Decrement
                    count <= count - 31'b1;
                end
                else begin  // don't do anything
                    count <= count;
                end
            end
            else begin // don;t do anything for any other states
                count <= count;
            end
        end
    end

endmodule