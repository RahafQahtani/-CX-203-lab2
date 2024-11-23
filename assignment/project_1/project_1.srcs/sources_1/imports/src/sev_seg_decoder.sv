module seven_seg_decoder(
    input  wire [3:0] D,      // 4-bit binary input (0–F)
    output reg  [6:0] seg       // 7-bit output for segments a-g
);

// Add your code here -----------------------------------
assign seg[6]=(~D[3]&~D[2]&~D[1])|(~D[3]&D[2]&D[1]&D[0])|(D[3]&D[2]&~D[1]&~D[0]);
assign seg[5]=(~D[3]&~D[2]&D[1])|(~D[3]&~D[2]&D[0])|(~D[3]&D[1]&D[0])|(D[3]&D[2]&~D[1]&D[0]);
assign seg[4]=(~D[1]&D[0]&~D[2])|(~D[3]&D[2]&~D[1])|(D[0]&~D[3]);
assign seg[3]=(~D[3]&D[2]&~D[1]&~D[0])|(D[2]&D[1]&D[0])|(D[3]&~D[2]&D[1]&~D[0])|(~D[3]&~D[2]&~D[1]&D[0]);
assign seg[2]=(~D[3]&~D[2]&D[1]&~D[0])|(D[3]&D[2]&D[1]&~D[0])|(D[3]&D[2]&D[1]);
assign seg[1]=D[2]&((~D[3]&~D[1]&D[0])|(D[3]&~D[0]|D[1]&~D[0])|(D[3]&D[1]))|(D[3]&D[1]&D[0]);
assign seg[0]=(D[3]&~D[2]&D[1]&D[0])|(D[3]&D[2]&~D[1]&D[0])|(~D[3]&D[2]&~D[1]&~D[0])|(~D[3]&~D[2]&~D[1]&D[0]);


/*always @ (bin)
begin 
case (bin)
4'b0 : seg=7'b1;
4'b0001 : assign seg=7'b1001111;
4'b0010 : assign seg=7'b0010010;
4'b0011 : assign seg=7'b0000110;
4'b0100 : assign seg=7'b1001100;
4'b0101 : assign seg=7'b0100100;
4'b0110 : assign seg=7'b0100000;
4'b0111 : assign seg=7'b0001111;
4'b1000 : assign seg=7'b0000000;
4'b1001 : assign seg=7'b0000100;
4'b1010 : assign seg=7'b0001000;
4'b1011 : assign seg=7'b1100000;
4'b1100 : assign seg=7'b0110001;
4'b1101 : assign seg=7'b1000010;
4'b1110 : assign seg=7'b0110000;
4'b1111 : assign seg=7'b0111000;
end*/

// Add your code here -----------------------------------

endmodule
