`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/23/2024 03:53:27 PM
// Design Name: 
// Module Name: K2_Microprosser
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


module K2_Microprosser(
    input logic clk,
    input logic resetn,
    //output logic [7:0] output_data, // Final output for debugging
    output wire [7:0] seg,         // Segments for seven-segment display
    output wire [7:0] AN           // Anodes for three seven-segment displays
);
    localparam N = 8; // Number of bits for K2

    // Internal Signals
    logic clk_1HZ;                // 1Hz clock
    logic [N-1:0] instruction;    // Instruction from Instruction Memory
    logic jump;                   // Jump condition
    logic [N-1:0] data_out;       // Data from Data Memory
    logic [N-1:0] alu_out;        // Output from ALU
    logic [N-1:0] pc=0;             // Program Counter
    logic [N-1:0] next_instruction;
    logic [3:0] reg_En;           // Register enable signals
    logic [N-1:0] reg_in_RA,reg_in_RB,reg_in_RO;         // Data for register input
    logic [N-1:0] reg_out_RA, reg_out_RB, reg_out_R0; // Outputs from registers
    logic data_En;                // Enable for Data Memory
    logic RW;                     // Read/Write signal for Data Memory
    logic [N-1:0] imm;            // Immediate value
    logic J, C, S_reg, JZ;        // Control signals from Decoder
    logic [1:0] D;                // Control signals for register selection
    logic alu_cout, dff_cout;     // Carry-out 

    // Instantiate Clock Divider
    clock_divider #(
        .N(100000000) // Divide 100MHz clock to 1Hz
    ) clk_div (
        .clk_in(clk),
        .reset(resetn),
        .clk_out(clk_1HZ)
    );

    // Instantiate Instruction Memory
    Instruction_Memory #(
        .Width(N),
        .Depth(16)
    ) instruction_memory (
        .addr(pc),
        .data(instruction)
    );

    // Instantiate Instruction Decoder
    instructions_decoder #(
        .N(N)
    ) decoder (
        .Data(instruction),
        .J(J),
        .C(C),
        .S_reg(S_reg),
        .JZ(JZ),
        .RW(RW),
        .Datamemo_EN(data_En),
        .D(D),
        .IMM(imm)
    );
     // Instantiate Registers Decoder
    decoder  #(
        .N(N)
    ) reg_decoder (
        .D(D),
        .En(reg_En)
    );
    // Instantiate Multiplexer 
    Multiplexers #(
    .n(8)
) mux_RA (
    .imm(imm),
    .ALU(alu_out),
    .data_mem(data_out),
    .Data_Memory(data_En),  // Enable signal for Data Memory
    .selection(S_reg),          // Selection signal for ALU or Immediate
    .out(reg_in_RA)         // Output to RA
);

Multiplexers #(
    .n(8)
) mux_RB (
    .imm(imm),
    .ALU(alu_out),
    .data_mem(data_out),
    .Data_Memory(data_En),  // Enable signal for Data Memory
    .selection(S_reg),          // Selection signal for ALU or Immediate
    .out(reg_in_RB)         // Output to RB
);
Multiplexers #(
    .n(8)
) mux_RO (
    .imm(imm),
    .ALU(alu_out),
    .data_mem(data_out),
    .Data_Memory(0),  // Enable signal for Data Memory
    .selection(S_reg),          // Selection signal for ALU or Immediate
    .out(reg_in_R0)         // Output to RB
);
    // Instantiate Data Memory
    Data_Memory #(
        .Width(N),
        .Depth(16)
    ) data_memory (
        .clk(clk_1HZ),
        .EN(data_En),
        .RW(RW),
        .addr(imm),
        .data_in(reg_out_RA), // Always use RA for data memory
        .data_out(data_out)
    );

    // Instantiate ALU
    ALU #(
        .N(N)
    ) alu (
        .clk(clk_1HZ),
        .A(reg_out_RA),
        .B(reg_out_RB),
        .M(S_reg),       // ALU operation mode
        .S(alu_out),
        .Cout(alu_cout)
    );

    // Carry Flip Flop
    DFlip_Flop carryDFF (
        .d(alu_cout),
        .CLK(clk_1HZ),
        .RESETN(resetn),
        .q(dff_cout) // Flip-flop output
    );

    // Jump Condition
    assign jump = (J & dff_cout) | JZ;
    assign next_instruction = jump ? imm : (pc + 1);

    // Instantiate Program Counter
    Counter #(
        .n(N)
    ) program_counter (
        .clk(clk_1HZ),
        .resetn(resetn),
        .load(jump),
        .en(~jump),
        .load_data(next_instruction),
        .count(pc)
    );

   

    // Instantiate Registers
    n_bit_register #(
        .n(N)
    ) RA (
        .d(reg_in_RA),
        .CLK(clk_1HZ),
        .CPU_RESETN(resetn),
        .En(reg_En[0]),
        .q(reg_out_RA)
    );
    

    n_bit_register #(
        .n(N)
    ) RB (
        .d(reg_in_RB),
        .CLK(clk_1HZ),
        .CPU_RESETN(resetn),
        .En(reg_En[1]),
        .q(reg_out_RB)
    );

    n_bit_register #(
        .n(N)
    ) R0 (
        .d(reg_in_RO),
        .CLK(clk_1HZ),
        .CPU_RESETN(resetn),
        .En(reg_En[2]),
        .q(reg_out_R0)
    );

    // Instantiate Seven-Segment Controller
    sev_seg_top sev_seg_display (
        .CLK100MHZ(clk),
        .CPU_RESETN(resetn),
        .SW({reg_out_RA, reg_out_RB, reg_out_R0}), // Combine RA, RB, R0 outputs
        .CA(seg[7]),       // Outputs for the seven-segment display
        .CB(seg[6]),
        .CC(seg[5]),
        .CD(seg[4]),
        .CE(seg[3]),
        .CF(seg[2]),
        .CG(seg[1]),
        .DP(seg[0]),
        .AN(AN)            // selection for  displays
    );

    // Output Debug
    //assign output_data = reg_out_RA; // Debug output

endmodule