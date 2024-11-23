`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/21/2024 01:10:31 PM
// Design Name: 
// Module Name: fulladder
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


module fulladder(

input logic a,
input logic b,
input logic cin,
output logic c,
output logic s

);
logic w1 ,w2,w3;

// using my previous half adder
halfadder ha1(.a(a),.b(b),.s(w1),.c(w2));
halfadder ha2(.a(cin),.b(w1),.s(s),.c(w3));//sum out is evaluted here
or carry(c,w2,w3 );//carry out is evaluated here

endmodule