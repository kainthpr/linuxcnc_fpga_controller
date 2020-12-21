module pwm_gen(
    clk50,
    reset_n,
    pwm_counter,
    pwm_capture,
    pwm_out
);

input clk50;
input reset_n;
input [31:0] pwm_capture;
input [31:0] pwm_counter;
output pwm_out;


reg [31:0] count;

always @(posedge clk50 or negedge reset_n) begin
    if (!reset_n) begin
        count <= 32'hFFFFFFFF;
    end
    else begin
        if (count > pwm_counter) begin
            count <= 0;
        end
        else begin
            count <= count + 1;    
        end
    end
end

assign pwm_out = (count < pwm_capture) ? 1 : 0;

endmodule