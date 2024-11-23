`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/23/2024 04:51:45 PM
// Design Name: 
// Module Name: clock_divider
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


module clock_divider#(parameter N = 100000000)(
    input logic clk_in,
    input logic reset,
    output logic clk_out
);
   //localparam N = 100000000;
    localparam WIDTH = $clog2(N);
    reg [WIDTH-1:0] count;
    reg clk_reg=0;

   always @(posedge clk_in or posedge reset) begin
        if (reset)begin 
            clk_reg <= 0;
            count<=0;
            end
        else if (count == N - 1) begin 
            clk_reg <= ~clk_reg;
            count<=0;
            end
        else begin
        
            count<=count+1;
        end 
        end
        assign clk_out =clk_reg;
endmodule