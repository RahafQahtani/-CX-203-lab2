`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/18/2024 08:16:50 AM
// Design Name: 
// Module Name: Dlatch
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


module Dlatch (
input wire d,
input wire CLK100MHZ,
input wire CPU_RESETN,
output reg q,
output reg qnot);

logic reset;
logic clk;
assign reset = CPU_RESETN;
assign clk = CLK100MHZ;

wire w1,w2,w3,w4;
nand(w1,d,clk);
nand(w3,~d,clk);
nand(w2,w1,qnot);

//reset
and(q,w2,reset);
nand(qnot,w3,q);

endmodule
