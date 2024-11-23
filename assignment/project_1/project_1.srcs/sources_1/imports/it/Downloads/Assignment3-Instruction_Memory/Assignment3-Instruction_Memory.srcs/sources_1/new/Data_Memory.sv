`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/21/2024 04:35:43 PM
// Design Name: 
// Module Name: Data_Memory
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


module Data_Memory#
(
parameter Width = 8,  // Address 
parameter Depth = 16  // Data 
)
(
    input logic clk,
    input logic RW, //enable read or write
    input logic [Width-1:0] addr, 
    input logic [Width-1:0] data_in, 
    input logic  EN, // enable  from the instruction decoder
    output logic [Width-1:0] data_out 
);
    logic [Width-1:0] memory [Depth-1:0]; // Memory array

  //Memory read 
  always @(*)
  begin 
  if (EN) begin
  if(!RW) //RW=0 is read 
  begin
  data_out=memory[addr];
  end
  else begin 
  data_out= {Width{1'b0}}; //output zero when not reading  
  end 
  end 
  end
  
  //Memory write 
  always @(posedge clk)
  begin
  if (EN) begin
  if(RW) // RW=1 is write
  begin
  memory[addr] <=data_in;
  end
  
  end 
  end 
 
endmodule
