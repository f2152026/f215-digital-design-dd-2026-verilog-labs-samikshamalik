module dut (
  input  [3:0] a,
  input  [3:0] b,
  input         cin,
  output [3:0] sum,
  output        cout
);

  rca implementation (
    .a    (a),
    .b    (b),
    .cin  (cin),
    .sum  (sum),
    .cout (cout)
  );

endmodule
