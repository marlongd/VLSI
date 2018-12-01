//////////////////////////////////////////////////
//////////////////////////////////////////////////

`timescale 1ns/1ps

`celldefine
module AND2X1 (A, B, Z);
    input A, B;
    output Z;
    and		(Z, A, B);
endmodule
`endcelldefine

`celldefine
module NAND2X1 (A, B, Z);
    input A, B;
    output Z;
    nand		(Z, A, B);
endmodule
`endcelldefine

`celldefine
module OR2X1 (A, B, Z);
    input A, B;
    output Z;
    or		(Z, A, B);
endmodule
`endcelldefine

`celldefine
module NOR2X1 (A, B, Z);
    input A, B;
    output Z;
    nor		(Z, A, B);
endmodule
`endcelldefine

`celldefine
module XOR2X1 (A, B, Z);
  input 	A, B;
  output 	Z;
  xor		(Z, A, B);
endmodule
`endcelldefine

`celldefine
module INVX1 (A, Z);
    input A;
    output Z;
    not		(Z, A);
endmodule
`endcelldefine

`celldefine
module INVX2 (A, Z);
    input A;
    output Z;
    not		(Z, A);
endmodule
`endcelldefine

`celldefine
module INVX4 (A, Z);
    input A;
    output Z;
    not		(Z, A);
endmodule
`endcelldefine

`celldefine
module INVX8 (A, Z);
    input A;
    output Z;
    not		(Z, A);
endmodule
`endcelldefine

`celldefine
module INVX16 (A, Z);
    input A;
    output Z;
    not		(Z, A);
endmodule
`endcelldefine

`celldefine
module INVX32 (A, Z);
    input A;
    output Z;
    not		(Z, A);
endmodule
`endcelldefine


`celldefine
module BUFX1 (A, Z);
    input A;
    output Z;
    buf		(Z, A);

endmodule
`endcelldefine


`celldefine
module MUX2X1 (A, B, S, Z);
   input A, B, S;
   output Z;

   reg  Z;

 always @ (S or A or B)
 begin : MUX
   if (S == 1'b0) begin
       Z = A;
   end else begin
     Z = B ;
   end
 end
 
endmodule
`endcelldefine

`celldefine
module NAND3X1 (A, B, C, Z);
    input A, B, C;
    output Z;
    nand		(Z, A, B, C);
endmodule
`endcelldefine


`celldefine
module DFFQX1 (D, CLK, Q);
    input D, CLK;
    output Q;
    reg Q;

always @(posedge CLK) 
begin
 Q <= D; 
end 
endmodule
`endcelldefine

`celldefine
module DFFQQBX1 (D, CLK, Q, QB);
    input D, CLK;
    output Q, QB;
    reg Q_reg;

always @(posedge CLK) 
begin
 Q_reg <= D; 
end 
assign Q = Q_reg;
assign QB = ~Q;
endmodule
`endcelldefine

`celldefine
module DFFQBX1 (D, CLK, QB);
    input D, CLK;
    output QB;
    reg QB;

always @(posedge CLK) 
begin
 QB <= !D; 
end 
endmodule
`endcelldefine


`celldefine
module DFFQSRX1 (CLK, D, SETB, RESETB, Q);

       output Q;
       input D, CLK, RESETB, SETB;
       reg Q;
       always @(posedge CLK or negedge RESETB or negedge SETB)
         if      (!RESETB) Q <= 0; // asynchronous reset
         else if (!SETB) Q <= 1; // asynchronous set
         else             Q <= D;
       // synopsys translate_off
       always @(RESETB or SETB)
         if (RESETB && !SETB) force   Q = 1;
         else                 release Q;
endmodule
`endcelldefine

`celldefine
module TIE1 (Z);
  output  Z;
  buf (Z, 1'b1);

endmodule
`endcelldefine

`celldefine
module TIE0 (Z);
  output  Z;
  buf (Z, 1'b0);

endmodule
`endcelldefine



`celldefine
module ANTENNA (A);
  input A;
endmodule
`endcelldefine
