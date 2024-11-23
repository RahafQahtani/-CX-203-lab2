`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/18/2024 08:18:25 AM
// Design Name: 
// Module Name: D Flip_Flop
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


module DFlip_Flop(
input wire d, //Data input
input wire CLK,
input wire RESETN,
output wire q,  //flip flop output
output wire qnot 
);
wire q_master,qnot_master;

assign reset = RESETN;

Dlatch master 
(
.d(d),.CLK100MHZ(CLK100MHZ), .CPU_RESETN(reset),
.q(q_master),.qnot(qnot_master)
);

Dlatch slave
(
.d(q_master),.CLK100MHZ(~CLK100MHZ),.CPU_RESETN(reset),
.q(q),
.qnot(qnot)
);

endmodule
