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


// $Id: //acds/rel/13.0sp1/ip/merlin/altera_tristate_conduit_bridge/altera_tristate_conduit_bridge.sv.terp#1 $
// $Revision: #1 $
// $Date: 2013/03/07 $
// $Author: swbranch $

//Defined Terp Parameters


			    

`timescale 1 ns / 1 ns
  				      
module system_0_tri_state_bridge_0_bridge_0 (
     input  logic clk
    ,input  logic reset
    ,input  logic request
    ,output logic grant
    ,output logic[ 7 :0 ] tcs_tri_state_bridge_0_data_in
    ,input  logic[ 7 :0 ] tcs_tri_state_bridge_0_data
    ,input  logic tcs_tri_state_bridge_0_data_outen
    ,inout  wire [ 7 :0 ]  tri_state_bridge_0_data
    ,input  logic[ 0 :0 ] tcs_tri_state_bridge_0_readn
    ,output  wire [ 0 :0 ] tri_state_bridge_0_readn
    ,input  logic[ 0 :0 ] tcs_write_n_to_the_cfi_flash_0
    ,output  wire [ 0 :0 ] write_n_to_the_cfi_flash_0
    ,input  logic[ 21 :0 ] tcs_tri_state_bridge_0_address
    ,output  wire [ 21 :0 ] tri_state_bridge_0_address
    ,input  logic[ 0 :0 ] tcs_select_n_to_the_cfi_flash_0
    ,output  wire [ 0 :0 ] select_n_to_the_cfi_flash_0
		     
   );
   reg grant_reg;
   assign grant = grant_reg;
   
   always@(posedge clk) begin
      if(reset)
	grant_reg <= 0;
      else
	grant_reg <= request;      
   end
   


 // ** Bidirectional Pin tri_state_bridge_0_data 
   
    reg                       tri_state_bridge_0_data_outen_reg;
  
    always@(posedge clk) begin
	 tri_state_bridge_0_data_outen_reg <= tcs_tri_state_bridge_0_data_outen;
     end
  
  
    reg [ 7 : 0 ] tri_state_bridge_0_data_reg;   

     always@(posedge clk) begin
	 tri_state_bridge_0_data_reg   <= tcs_tri_state_bridge_0_data[ 7 : 0 ];
      end
         
  
    assign 	tri_state_bridge_0_data[ 7 : 0 ] = tri_state_bridge_0_data_outen_reg ? tri_state_bridge_0_data_reg : 'z ;
       
  
    reg [ 7 : 0 ] 	tri_state_bridge_0_data_in_reg;
								    
    always@(posedge clk) begin
	 tri_state_bridge_0_data_in_reg <= tri_state_bridge_0_data[ 7 : 0 ];
    end
    
  
    assign      tcs_tri_state_bridge_0_data_in[ 7 : 0 ] = tri_state_bridge_0_data_in_reg[ 7 : 0 ];
        


 // ** Output Pin tri_state_bridge_0_readn 
 
    reg                       tri_state_bridge_0_readnen_reg;     
  
    always@(posedge clk) begin
	 if( reset ) begin
	   tri_state_bridge_0_readnen_reg <= 'b0;
	 end
	 else begin
	   tri_state_bridge_0_readnen_reg <= 'b1;
	 end
     end		     
   
 
    reg [ 0 : 0 ] tri_state_bridge_0_readn_reg;   

     always@(posedge clk) begin
	 tri_state_bridge_0_readn_reg   <= tcs_tri_state_bridge_0_readn[ 0 : 0 ];
      end
          
 
    assign 	tri_state_bridge_0_readn[ 0 : 0 ] = tri_state_bridge_0_readnen_reg ? tri_state_bridge_0_readn_reg : 'z ;
        


 // ** Output Pin write_n_to_the_cfi_flash_0 
 
    reg                       write_n_to_the_cfi_flash_0en_reg;     
  
    always@(posedge clk) begin
	 if( reset ) begin
	   write_n_to_the_cfi_flash_0en_reg <= 'b0;
	 end
	 else begin
	   write_n_to_the_cfi_flash_0en_reg <= 'b1;
	 end
     end		     
   
 
    reg [ 0 : 0 ] write_n_to_the_cfi_flash_0_reg;   

     always@(posedge clk) begin
	 write_n_to_the_cfi_flash_0_reg   <= tcs_write_n_to_the_cfi_flash_0[ 0 : 0 ];
      end
          
 
    assign 	write_n_to_the_cfi_flash_0[ 0 : 0 ] = write_n_to_the_cfi_flash_0en_reg ? write_n_to_the_cfi_flash_0_reg : 'z ;
        


 // ** Output Pin tri_state_bridge_0_address 
 
    reg                       tri_state_bridge_0_addressen_reg;     
  
    always@(posedge clk) begin
	 if( reset ) begin
	   tri_state_bridge_0_addressen_reg <= 'b0;
	 end
	 else begin
	   tri_state_bridge_0_addressen_reg <= 'b1;
	 end
     end		     
   
 
    reg [ 21 : 0 ] tri_state_bridge_0_address_reg;   

     always@(posedge clk) begin
	 tri_state_bridge_0_address_reg   <= tcs_tri_state_bridge_0_address[ 21 : 0 ];
      end
          
 
    assign 	tri_state_bridge_0_address[ 21 : 0 ] = tri_state_bridge_0_addressen_reg ? tri_state_bridge_0_address_reg : 'z ;
        


 // ** Output Pin select_n_to_the_cfi_flash_0 
 
    reg                       select_n_to_the_cfi_flash_0en_reg;     
  
    always@(posedge clk) begin
	 if( reset ) begin
	   select_n_to_the_cfi_flash_0en_reg <= 'b0;
	 end
	 else begin
	   select_n_to_the_cfi_flash_0en_reg <= 'b1;
	 end
     end		     
   
 
    reg [ 0 : 0 ] select_n_to_the_cfi_flash_0_reg;   

     always@(posedge clk) begin
	 select_n_to_the_cfi_flash_0_reg   <= tcs_select_n_to_the_cfi_flash_0[ 0 : 0 ];
      end
          
 
    assign 	select_n_to_the_cfi_flash_0[ 0 : 0 ] = select_n_to_the_cfi_flash_0en_reg ? select_n_to_the_cfi_flash_0_reg : 'z ;
        

endmodule


