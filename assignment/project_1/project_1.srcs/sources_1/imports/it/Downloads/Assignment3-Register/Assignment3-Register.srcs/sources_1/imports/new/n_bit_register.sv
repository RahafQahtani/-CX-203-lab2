`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/18/2024 03:45:01 PM
// Design Name: 
// Module Name: n_bit_register
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


module n_bit_register#(parameter n)
(
input wire [n-1:0] d, //Data input
input wire CLK,
input wire CPU_RESETN,
input wire En,
output reg [n-1:0] q
);
wire clk,reset;
wire reg_clk;

assign clk = CLK;
assign reset=CPU_RESETN;

always @(posedge clk, posedge reset)
begin 
    if(reset) q <= 0;
    else if (En) q <= d;
end

endmodule

