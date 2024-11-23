`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/21/2024 03:53:40 PM
// Design Name: 
// Module Name: decoder
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module decoder #(parameter N)(
input  reg [1:0]D,
output reg [N-1:0]En
    );
    
    always @(*)
   begin 
   case(D)
   00:En=0001;//EN FOR RA
   01:En=0010;//EN FOR RB
   10: En=0100;//EN FOR R0
   11:En=1000;//rubbish
   default : En=0000;// no reg is selected
   endcase 
   end 
endmodule
