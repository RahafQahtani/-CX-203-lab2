`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/21/2024 12:49:05 PM
// Design Name: 
// Module Name: ALU
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


module ALU #(parameter N = 8)(
input wire clk,
input wire [N-1:0] A ,
input wire [N-1:0] B ,
input wire M ,
output reg [N-1:0] S,
output reg Cout
);

 
//vribles 
logic [N-1:0]b;
logic [N-1:0] C;
reg [N:0] op ;
assign C[0]=M;
/*
assign b=B^M;

always @(posedge clk) begin 
op = A+b+M;
S=op[N-1:0];
Cout= op[N];
end 
*/
genvar i;

generate 
for(i=0;i<N; i=i+1) begin
 xor (b[i],B[i],M);
 fulladder f(.a(A[i]),.b(b[i]),.cin(C[i]),.s(S[i]),.c(C[i+1]));
end 
endgenerate
assign Cout=C[N-1];


endmodule