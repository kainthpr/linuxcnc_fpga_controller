module step_gen(
    clk50,
    reset_n,
    period,
    dir_in,
    dir_out,
    step_out,
    en,
    location
);
    input clk50;
    input reset_n;
    input [31:0] period;
    input dir_in;
    output dir_out;
    output reg step_out;
    input en;
    output reg [31:0] location;

    reg [31:0] counter;
    assign dir_out = dir_in;

    always@(posedge clk50 or negedge reset_n) begin    // Step generator
        if(!reset_n) begin
            counter <= 0; 
            step_out <= 0;
        end
        else begin
            if  (en) begin
                if (counter > period) begin
                    counter <= 0;
                    step_out <= ~step_out;
                end
                else begin
                    counter <= counter + 1;
                    step_out <= step_out;
                end
            end
            else begin
                counter <= 0; 
                step_out <= 0;
            end
        end
    end

    reg last_step_out;
    always@(posedge clk50) begin
        last_step_out <= step_out;
    end

    always@(posedge clk50 or negedge reset_n) begin  // steps accumulator. 0 is at 32h 80 00 00 00. MSb is sign. 1 is positive
        if(!reset_n) begin
            location <= 32'h80000000;
        end
        else begin
            if (step_out == 1 && last_step_out == 0) begin  // step pulse sent
                if(dir_out) begin
                    location <= location + 1;
                end
                else begin
                    location <= location - 1;
                end
            end
            else begin
                location <= location;
            end

        end
    end

endmodule