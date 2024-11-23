`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/21/2024 12:49:06 PM
// Design Name: 
// Module Name: Multiplexers
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


module Multiplexers#(parameter n)
(
    input logic [n-1:0] imm,         // Immediate value
    input logic [n-1:0] ALU,         // ALU result
    input logic [n-1:0] data_mem,    // Data from memory
    input logic Data_Memory,         // Signal to select Data Memory
    input logic selection,           // Selection signal
    output logic [n-1:0] out         // Multiplexer output
);

always_comb begin
    if (Data_Memory) begin
        out = data_mem;              // Use Data Memory output
    end else begin
        out = (selection) ? ALU : imm; // Select between ALU and Immediate
    end
end

endmodule