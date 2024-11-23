`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/21/2024 01:49:28 PM
// Design Name: 
// Module Name: Instruction_Memory
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


module Instruction_Memory#(
    parameter Width = 8,  // Address 
    parameter Depth = 16  //Data  
) 
(
    input logic [Width:0] addr, // Address input
    output logic [Width:0] data //data output
);
    logic [Width-1:0] memory [Depth-1:0]; // Memory array

    initial begin
        memory[0] = 8'b00001000; //load zero to A
        memory[1] = 8'b00011001; //load 1 to B
        memory[2] = 8'b00100000; // push A to output 
        memory[3] = 8'b00010000; //Add A to B
        memory[4] = 8'b01110000; //if A+B produce carry jump to start
        memory[5] = 8'b00000000; //Swap A and B
        memory[6] = 8'b00010100; //Swap A and B
        memory[7] = 8'b00000100; //Swap A and B
        memory[8] = 8'b10110010; //Jump to 3rd instruction 
        memory[9] = 8'b11000001; //RA=[imm]
        memory[10] = 8'b11010010; //RB=[imm]
        memory[11] = 8'b11001000; //[imm]=RA
        memory[12] = 8'b11110010; //JZ
          


    end
    assign data = memory[addr]; // Read instruction //output
endmodule
