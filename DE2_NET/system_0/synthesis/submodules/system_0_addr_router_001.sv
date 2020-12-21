// (C) 2001-2013 Altera Corporation. All rights reserved.
// Your use of Altera Corporation's design tools, logic functions and other 
// software and tools, and its AMPP partner logic functions, and any output 
// files any of the foregoing (including device programming or simulation 
// files), and any associated documentation or information are expressly subject 
// to the terms and conditions of the Altera Program License Subscription 
// Agreement, Altera MegaCore Function License Agreement, or other applicable 
// license agreement, including, without limitation, that your use is for the 
// sole purpose of programming logic devices manufactured by Altera and sold by 
// Altera or its authorized distributors.  Please refer to the applicable 
// agreement for further details.


// (C) 2001-2013 Altera Corporation. All rights reserved.
// Your use of Altera Corporation's design tools, logic functions and other 
// software and tools, and its AMPP partner logic functions, and any output 
// files any of the foregoing (including device programming or simulation 
// files), and any associated documentation or information are expressly subject 
// to the terms and conditions of the Altera Program License Subscription 
// Agreement, Altera MegaCore Function License Agreement, or other applicable 
// license agreement, including, without limitation, that your use is for the 
// sole purpose of programming logic devices manufactured by Altera and sold by 
// Altera or its authorized distributors.  Please refer to the applicable 
// agreement for further details.


// $Id: //acds/rel/13.0sp1/ip/merlin/altera_merlin_router/altera_merlin_router.sv.terp#1 $
// $Revision: #1 $
// $Date: 2013/03/07 $
// $Author: swbranch $

// -------------------------------------------------------
// Merlin Router
//
// Asserts the appropriate one-hot encoded channel based on 
// either (a) the address or (b) the dest id. The DECODER_TYPE
// parameter controls this behaviour. 0 means address decoder,
// 1 means dest id decoder.
//
// In the case of (a), it also sets the destination id.
// -------------------------------------------------------

`timescale 1 ns / 1 ns

module system_0_addr_router_001_default_decode
  #(
     parameter DEFAULT_CHANNEL = 1,
               DEFAULT_WR_CHANNEL = -1,
               DEFAULT_RD_CHANNEL = -1,
               DEFAULT_DESTID = 18 
   )
  (output [91 - 87 : 0] default_destination_id,
   output [25-1 : 0] default_wr_channel,
   output [25-1 : 0] default_rd_channel,
   output [25-1 : 0] default_src_channel
  );

  assign default_destination_id = 
    DEFAULT_DESTID[91 - 87 : 0];

  generate begin : default_decode
    if (DEFAULT_CHANNEL == -1) begin
      assign default_src_channel = '0;
    end
    else begin
      assign default_src_channel = 25'b1 << DEFAULT_CHANNEL;
    end
  end
  endgenerate

  generate begin : default_decode_rw
    if (DEFAULT_RD_CHANNEL == -1) begin
      assign default_wr_channel = '0;
      assign default_rd_channel = '0;
    end
    else begin
      assign default_wr_channel = 25'b1 << DEFAULT_WR_CHANNEL;
      assign default_rd_channel = 25'b1 << DEFAULT_RD_CHANNEL;
    end
  end
  endgenerate

endmodule


module system_0_addr_router_001
(
    // -------------------
    // Clock & Reset
    // -------------------
    input clk,
    input reset,

    // -------------------
    // Command Sink (Input)
    // -------------------
    input                       sink_valid,
    input  [102-1 : 0]    sink_data,
    input                       sink_startofpacket,
    input                       sink_endofpacket,
    output                      sink_ready,

    // -------------------
    // Command Source (Output)
    // -------------------
    output                          src_valid,
    output reg [102-1    : 0] src_data,
    output reg [25-1 : 0] src_channel,
    output                          src_startofpacket,
    output                          src_endofpacket,
    input                           src_ready
);

    // -------------------------------------------------------
    // Local parameters and variables
    // -------------------------------------------------------
    localparam PKT_ADDR_H = 60;
    localparam PKT_ADDR_L = 36;
    localparam PKT_DEST_ID_H = 91;
    localparam PKT_DEST_ID_L = 87;
    localparam PKT_PROTECTION_H = 95;
    localparam PKT_PROTECTION_L = 93;
    localparam ST_DATA_W = 102;
    localparam ST_CHANNEL_W = 25;
    localparam DECODER_TYPE = 0;

    localparam PKT_TRANS_WRITE = 63;
    localparam PKT_TRANS_READ  = 64;

    localparam PKT_ADDR_W = PKT_ADDR_H-PKT_ADDR_L + 1;
    localparam PKT_DEST_ID_W = PKT_DEST_ID_H-PKT_DEST_ID_L + 1;



    // -------------------------------------------------------
    // Figure out the number of bits to mask off for each slave span
    // during address decoding
    // -------------------------------------------------------
    localparam PAD0 = log2ceil(64'h80000 - 64'h0); 
    localparam PAD1 = log2ceil(64'h81800 - 64'h81000); 
    localparam PAD2 = log2ceil(64'h82000 - 64'h81800); 
    localparam PAD3 = log2ceil(64'h82100 - 64'h82000); 
    localparam PAD4 = log2ceil(64'h82120 - 64'h82100); 
    localparam PAD5 = log2ceil(64'h82140 - 64'h82120); 
    localparam PAD6 = log2ceil(64'h82160 - 64'h82140); 
    localparam PAD7 = log2ceil(64'h82170 - 64'h82160); 
    localparam PAD8 = log2ceil(64'h82180 - 64'h82170); 
    localparam PAD9 = log2ceil(64'h82190 - 64'h82180); 
    localparam PAD10 = log2ceil(64'h821a0 - 64'h82190); 
    localparam PAD11 = log2ceil(64'h821b0 - 64'h821a0); 
    localparam PAD12 = log2ceil(64'h821c0 - 64'h821b0); 
    localparam PAD13 = log2ceil(64'h821d0 - 64'h821c0); 
    localparam PAD14 = log2ceil(64'h821e0 - 64'h821d0); 
    localparam PAD15 = log2ceil(64'h821f0 - 64'h821e8); 
    localparam PAD16 = log2ceil(64'h821f8 - 64'h821f0); 
    localparam PAD17 = log2ceil(64'h82200 - 64'h821f8); 
    localparam PAD18 = log2ceil(64'h82208 - 64'h82200); 
    localparam PAD19 = log2ceil(64'h82210 - 64'h82208); 
    localparam PAD20 = log2ceil(64'h82214 - 64'h82210); 
    localparam PAD21 = log2ceil(64'h82218 - 64'h82214); 
    localparam PAD22 = log2ceil(64'h400000 - 64'h200000); 
    localparam PAD23 = log2ceil(64'h1800000 - 64'h1000000); 
    localparam PAD24 = log2ceil(64'h1c00000 - 64'h1800000); 
    // -------------------------------------------------------
    // Work out which address bits are significant based on the
    // address range of the slaves. If the required width is too
    // large or too small, we use the address field width instead.
    // -------------------------------------------------------
    localparam ADDR_RANGE = 64'h1c00000;
    localparam RANGE_ADDR_WIDTH = log2ceil(ADDR_RANGE);
    localparam OPTIMIZED_ADDR_H = (RANGE_ADDR_WIDTH > PKT_ADDR_W) ||
                                  (RANGE_ADDR_WIDTH == 0) ?
                                        PKT_ADDR_H :
                                        PKT_ADDR_L + RANGE_ADDR_WIDTH - 1;

    localparam RG = RANGE_ADDR_WIDTH-1;

      wire [PKT_ADDR_W-1 : 0] address = sink_data[OPTIMIZED_ADDR_H : PKT_ADDR_L];

    // -------------------------------------------------------
    // Pass almost everything through, untouched
    // -------------------------------------------------------
    assign sink_ready        = src_ready;
    assign src_valid         = sink_valid;
    assign src_startofpacket = sink_startofpacket;
    assign src_endofpacket   = sink_endofpacket;

    wire [PKT_DEST_ID_W-1:0] default_destid;
    wire [25-1 : 0] default_src_channel;





    system_0_addr_router_001_default_decode the_default_decode(
      .default_destination_id (default_destid),
      .default_wr_channel   (),
      .default_rd_channel   (),
      .default_src_channel  (default_src_channel)
    );

    always @* begin
        src_data    = sink_data;
        src_channel = default_src_channel;
        src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = default_destid;

        // --------------------------------------------------
        // Address Decoder
        // Sets the channel and destination ID based on the address
        // --------------------------------------------------

    // ( 0x0 .. 0x80000 )
    if ( {address[RG:PAD0],{PAD0{1'b0}}} == 25'h0   ) begin
            src_channel = 25'b0000000000000000000100000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 19;
    end

    // ( 0x81000 .. 0x81800 )
    if ( {address[RG:PAD1],{PAD1{1'b0}}} == 25'h81000   ) begin
            src_channel = 25'b0000000000000000000000100;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 13;
    end

    // ( 0x81800 .. 0x82000 )
    if ( {address[RG:PAD2],{PAD2{1'b0}}} == 25'h81800   ) begin
            src_channel = 25'b0000000000000000000000001;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 12;
    end

    // ( 0x82000 .. 0x82100 )
    if ( {address[RG:PAD3],{PAD3{1'b0}}} == 25'h82000   ) begin
            src_channel = 25'b1000000000000000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 11;
    end

    // ( 0x82100 .. 0x82120 )
    if ( {address[RG:PAD4],{PAD4{1'b0}}} == 25'h82100   ) begin
            src_channel = 25'b0000000000000001000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 23;
    end

    // ( 0x82120 .. 0x82140 )
    if ( {address[RG:PAD5],{PAD5{1'b0}}} == 25'h82120   ) begin
            src_channel = 25'b0000000000000000100000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 22;
    end

    // ( 0x82140 .. 0x82160 )
    if ( {address[RG:PAD6],{PAD6{1'b0}}} == 25'h82140   ) begin
            src_channel = 25'b0000000000000000010000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 24;
    end

    // ( 0x82160 .. 0x82170 )
    if ( {address[RG:PAD7],{PAD7{1'b0}}} == 25'h82160   ) begin
            src_channel = 25'b0000000100000000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 4;
    end

    // ( 0x82170 .. 0x82180 )
    if ( {address[RG:PAD8],{PAD8{1'b0}}} == 25'h82170   ) begin
            src_channel = 25'b0000000010000000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 5;
    end

    // ( 0x82180 .. 0x82190 )
    if ( {address[RG:PAD9],{PAD9{1'b0}}} == 25'h82180   ) begin
            src_channel = 25'b0000000001000000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 6;
    end

    // ( 0x82190 .. 0x821a0 )
    if ( {address[RG:PAD10],{PAD10{1'b0}}} == 25'h82190   ) begin
            src_channel = 25'b0000000000100000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 20;
    end

    // ( 0x821a0 .. 0x821b0 )
    if ( {address[RG:PAD11],{PAD11{1'b0}}} == 25'h821a0   ) begin
            src_channel = 25'b0000000000010000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 9;
    end

    // ( 0x821b0 .. 0x821c0 )
    if ( {address[RG:PAD12],{PAD12{1'b0}}} == 25'h821b0   ) begin
            src_channel = 25'b0000000000001000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 16;
    end

    // ( 0x821c0 .. 0x821d0 )
    if ( {address[RG:PAD13],{PAD13{1'b0}}} == 25'h821c0   ) begin
            src_channel = 25'b0000000000000100000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 17;
    end

    // ( 0x821d0 .. 0x821e0 )
    if ( {address[RG:PAD14],{PAD14{1'b0}}} == 25'h821d0   ) begin
            src_channel = 25'b0000000000000010000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 15;
    end

    // ( 0x821e8 .. 0x821f0 )
    if ( {address[RG:PAD15],{PAD15{1'b0}}} == 25'h821e8   ) begin
            src_channel = 25'b0010000000000000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 1;
    end

    // ( 0x821f0 .. 0x821f8 )
    if ( {address[RG:PAD16],{PAD16{1'b0}}} == 25'h821f0   ) begin
            src_channel = 25'b0000000000000000000010000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 21;
    end

    // ( 0x821f8 .. 0x82200 )
    if ( {address[RG:PAD17],{PAD17{1'b0}}} == 25'h821f8   ) begin
            src_channel = 25'b0000010000000000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 2;
    end

    // ( 0x82200 .. 0x82208 )
    if ( {address[RG:PAD18],{PAD18{1'b0}}} == 25'h82200   ) begin
            src_channel = 25'b0000001000000000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 3;
    end

    // ( 0x82208 .. 0x82210 )
    if ( {address[RG:PAD19],{PAD19{1'b0}}} == 25'h82208   ) begin
            src_channel = 25'b0000000000000000001000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 14;
    end

    // ( 0x82210 .. 0x82214 )
    if ( {address[RG:PAD20],{PAD20{1'b0}}} == 25'h82210   ) begin
            src_channel = 25'b0100000000000000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 7;
    end

    // ( 0x82214 .. 0x82218 )
    if ( {address[RG:PAD21],{PAD21{1'b0}}} == 25'h82214   ) begin
            src_channel = 25'b0000100000000000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 0;
    end

    // ( 0x200000 .. 0x400000 )
    if ( {address[RG:PAD22],{PAD22{1'b0}}} == 25'h200000   ) begin
            src_channel = 25'b0001000000000000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 8;
    end

    // ( 0x1000000 .. 0x1800000 )
    if ( {address[RG:PAD23],{PAD23{1'b0}}} == 25'h1000000   ) begin
            src_channel = 25'b0000000000000000000000010;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 18;
    end

    // ( 0x1800000 .. 0x1c00000 )
    if ( {address[RG:PAD24],{PAD24{1'b0}}} == 25'h1800000   ) begin
            src_channel = 25'b0000000000000000000001000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 10;
    end

end


    // --------------------------------------------------
    // Ceil(log2()) function
    // --------------------------------------------------
    function integer log2ceil;
        input reg[65:0] val;
        reg [65:0] i;

        begin
            i = 1;
            log2ceil = 0;

            while (i < val) begin
                log2ceil = log2ceil + 1;
                i = i << 1;
            end
        end
    endfunction

endmodule


