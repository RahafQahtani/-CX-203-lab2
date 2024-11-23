`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/21/2024 04:43:28 PM
// Design Name: 
// Module Name: instructions_decoder
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


module instructions_decoder#(parameter N=8)( 
input  reg [N-1:0]Data,//instruction
output reg J,C,S_reg,JZ,RW,Datamemo_EN,
output reg [1:0] D,
output reg [2:0]IMM 
    );
    
    always @(*)
   begin 
  J=Data[7];
  C=Data[6];
  D[1:0]=Data[5:4];//INPUT FOR DECODER
  S_reg=Data[3];// input ALU
  IMM[2:0]=Data[2:0];
  
  if (J&&C)begin 
  RW=S_reg;
  Datamemo_EN=1;
  end
  else 
  Datamemo_EN=0;
  
  if (J&C&(D==3))begin
  JZ=1;
  end
  else 
  JZ=0;
   end 
endmodule
    

