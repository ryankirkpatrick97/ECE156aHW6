
module counter_S ( clk, reset, count );
  output [3:0] count;
  input clk, reset;
  wire   N9, N10, N11, N12, n3, n5, n6, n11, n12, n13, n14, n15, n16, n17, n18,
         n19;

  FD2 \count_reg[0]  ( .D(N9), .CP(clk), .CD(n3), .Q(count[0]), .QN(n18) );
  FD2 \count_reg[1]  ( .D(N10), .CP(clk), .CD(n3), .Q(count[1]), .QN(n6) );
  FD2 \count_reg[2]  ( .D(N11), .CP(clk), .CD(n3), .Q(count[2]), .QN(n5) );
  FD2 \count_reg[3]  ( .D(N12), .CP(clk), .CD(n3), .Q(count[3]), .QN(n19) );
  IV U13 ( .A(reset), .Z(n3) );
  AO4 U14 ( .A(n19), .B(n11), .C(n12), .D(n13), .Z(N12) );
  OR2 U15 ( .A(n5), .B(n6), .Z(n13) );
  MUX21L U16 ( .A(n14), .B(n15), .S(n5), .Z(N11) );
  OR2 U17 ( .A(n12), .B(n6), .Z(n15) );
  AO6 U18 ( .A(n6), .B(n16), .C(N9), .Z(n14) );
  IV U19 ( .A(n17), .Z(N9) );
  MUX21L U20 ( .A(n17), .B(n12), .S(n6), .Z(N10) );
  OR2 U21 ( .A(n11), .B(n18), .Z(n12) );
  ND2 U22 ( .A(n18), .B(n16), .Z(n17) );
  IV U23 ( .A(n11), .Z(n16) );
  AO6 U24 ( .A(n5), .B(n6), .C(n19), .Z(n11) );
endmodule

