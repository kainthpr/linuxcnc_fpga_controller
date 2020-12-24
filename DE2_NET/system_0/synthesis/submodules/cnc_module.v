module cnc_module (	
    osteps, 
    odirs,
    ospindle_pwm,
    cp,
    ogpio,
    igpio,
    clk,
    reset_n,
    address,
    read,
    write, 
    readdata,
    writedata,
    chipselect
);

input   clk, reset_n, read, write, chipselect;// avalon signals
input	[31:0]	writedata;        // avalon write data
output reg [31:0]	readdata;         // avalon read data
input	[5:0]	address;          // avalon address

// conduit
output	[4:0]	osteps;           // 5 axis step outputs
output	[4:0]	odirs;            // 5 axis dir outputs
output  ospindle_pwm;             // spindle pwm
output  cp;                       // charge pump
output reg		[31:0]	ogpio;            // 32 general purpose outputs
input   [31:0]	igpio;            // 32 general purpose inputs

reg [31:0] sg0_per;
reg [31:0] sg1_per;
reg [31:0] sg2_per;
reg [31:0] sg3_per;
reg [31:0] sg4_per;

reg [4:0]  sg_dirs;
reg [4:0]  sg_ens;
reg pwm_en;
reg [31:0] pwm_counter;
reg [31:0] pwm_capture;
reg [20:0] spare;

always@(posedge clk or negedge reset_n)
begin
	if(!reset_n) begin
    	ogpio <= 31'hAAAAAAAA;
        sg0_per <= 0;
        sg1_per <= 0;
        sg2_per <= 0;
        sg3_per <= 0;
        sg4_per <= 0;
        sg_ens[4:0] <= 5'b0;
        sg_dirs[4:0] <= 5'b0;
        ogpio[31:0] <= 32'b0;
        pwm_counter <= 0;
        pwm_capture <= 0;
    

    end
    else begin
		if(chipselect & write) begin
            case (address)
                6'h0: sg0_per[31:0] <= writedata; // stepgen0 rate
                6'h1: sg1_per[31:0] <= writedata; // stepgen1 rate
                6'h2: sg2_per[31:0] <= writedata; // stepgen2 rate
                6'h3: sg3_per[31:0] <= writedata; // stepgen3 rate
                6'h4: sg4_per[31:0] <= writedata; // stepgen4 rate
                6'h5: begin
                    sg_dirs[4:0] <= writedata[4:0];   // stepgen dirs
                    sg_ens[4:0] <= writedata[9:5];    // stepgen enables
                    pwm_en <= writedata[10];          // pwm en
                    spare[20:0] <= writedata[31:11];  // spares
                end
                6'h6: pwm_counter[31:0] <= writedata[31:0]; // pwm counter
                6'h7: pwm_capture[31:0] <= writedata[31:0]; // pwm compare
                6'h8: ogpio[31:0] <= writedata[31:0];       // ogpio
            endcase
        end
        else if(chipselect & read) begin
            case (address)
                6'h0: readdata[31:0] <= sg0_per[31:0];  // stepgen0 rate
                6'h1: readdata[31:0] <= sg1_per[31:0]; // stepgen1 rate
                6'h2: readdata[31:0] <= sg2_per[31:0]; // stepgen2 rate
                6'h3: readdata[31:0] <= sg3_per[31:0]; // stepgen3 rate
                6'h4: readdata[31:0] <= sg4_per[31:0]; // stepgen4 rate
                6'h5: begin
                    readdata[4:0] <= sg_dirs[4:0];   // stepgen dirs
                    readdata[9:5] <= sg_ens[4:0];    // stepgen enables
                    readdata[10] <= pwm_en;          // pwm en
                    readdata[31:11] <= spare[20:0];  // spares
                end
                6'h6: readdata[31:0] <= pwm_counter[31:0]; // pwm counter
                6'h7: readdata[31:0] <= pwm_capture[31:0]; // pwm compare
                6'h8: readdata[31:0] <= ogpio[31:0];       // ogpio readback
                6'h9: readdata[31:0] <= igpio[31:0];       // igpio
                6'hA: readdata[31:0] <= sg0_loc;       // sg0_loc
                6'hB: readdata[31:0] <= sg1_loc;       // sg1_loc
                6'hC: readdata[31:0] <= sg2_loc;       // sg2_loc
                6'hD: readdata[31:0] <= sg3_loc;       // sg3_loc
                6'hE: readdata[31:0] <= sg4_loc;       // sg4_loc

            endcase
        end
        else begin
            readdata[31:0] <= readdata[31:0];
            pwm_counter[31:0] <= pwm_counter[31:0];
            pwm_capture[31:0] <= pwm_capture[31:0];
            sg0_per[31:0] <= sg0_per[31:0];
            sg1_per[31:0] <= sg1_per[31:0];
            sg2_per[31:0] <= sg2_per[31:0];
            sg3_per[31:0] <= sg3_per[31:0];
            sg4_per[31:0] <= sg4_per[31:0];
            sg_dirs[4:0] <= sg_dirs[4:0];
            sg_ens[4:0] <= sg_ens[4:0];
            pwm_en <= pwm_en;
            spare[20:0] <= spare[20:0];
            ogpio[31:0] <= ogpio[31:0];
        end
	end
end

wire sg0_dir = sg_dirs[0];
wire sg0_en =  sg_ens[0];
wire [31:0] sg0_loc;
step_gen sg0
(
    .clk50(clk),
    .reset_n(reset_n),
    .period(sg0_per),
    .dir_in(sg0_dir),
    .dir_out(odirs[0]),
    .step_out(osteps[0]),
    .en(sg0_en),
    .location(sg0_loc)
);

wire sg1_dir = sg_dirs[1];
wire sg1_en =  sg_ens[1];
wire [31:0] sg1_loc;
step_gen sg1
(
    .clk50(clk),
    .reset_n(reset_n),
    .period(sg1_per),
    .dir_in(sg1_dir),
    .dir_out(odirs[1]),
    .step_out(osteps[1]),
    .en(sg1_en),
    .location(sg1_loc)
);

wire sg2_dir = sg_dirs[2];
wire sg2_en =  sg_ens[2];
wire [31:0] sg2_loc;
step_gen sg2
(
    .clk50(clk),
    .reset_n(reset_n),
    .period(sg2_per),
    .dir_in(sg2_dir),
    .dir_out(odirs[2]),
    .step_out(osteps[2]),
    .en(sg2_en),
    .location(sg2_loc)
);

wire sg3_dir = sg_dirs[3];
wire sg3_en =  sg_ens[3];
wire [31:0] sg3_loc;
step_gen sg3
(
    .clk50(clk),
    .reset_n(reset_n),
    .period(sg3_per),
    .dir_in(sg3_dir),
    .dir_out(odirs[3]),
    .step_out(osteps[3]),
    .en(sg3_en),
    .location(sg3_loc)
);
wire sg4_dir = sg_dirs[4];
wire sg4_en =  sg_ens[4];
wire [31:0] sg4_loc;
step_gen sg4
(
    .clk50(clk),
    .reset_n(reset_n),
    .period(sg4_per),
    .dir_in(sg4_dir),
    .dir_out(odirs[4]),
    .step_out(osteps[4]),
    .en(sg4_en),
    .location(sg4_loc)
);

pwm_gen pwm1
(
    .clk50(clk),
    .reset_n(reset_n),
    .pwm_counter(pwm_counter),
    .pwm_capture(pwm_capture),
    .pwm_out(ospindle_pwm) 
);

pwm_gen cp1
(
    .clk50(clk),
    .reset_n(reset_n),
    .pwm_counter(32'd5000),
    .pwm_capture(32'd2500),
    .pwm_out(cp) 
);

endmodule