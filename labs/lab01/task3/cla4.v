module cla4 (
  input  [3:0] a,
  input  [3:0] b,
  input        cin,
  output [3:0] sum,
  output       cout
);

  wire [3:0] propagate;
  wire [3:0] generate_bit;
  wire [4:0] carry;
  wire c1_from_cin;
  wire c2_from_g0, c2_from_cin;
  wire c3_from_g1, c3_from_g0, c3_from_cin;
  wire cout_from_g2, cout_from_g1, cout_from_g0, cout_from_cin;
  genvar bit_index;

  assign carry[0] = cin;

  generate
    for (bit_index = 0; bit_index < 4; bit_index = bit_index + 1) begin : propagate_generate
      xor (propagate[bit_index],    a[bit_index], b[bit_index]);
      and (generate_bit[bit_index], a[bit_index], b[bit_index]);
    end
  endgenerate

  and (c1_from_cin, carry[0], propagate[0]);
  or  (carry[1], generate_bit[0], c1_from_cin);

  and (c2_from_g0,  propagate[1], generate_bit[0]);
  and (c2_from_cin, propagate[1], propagate[0], carry[0]);
  or  (carry[2], generate_bit[1], c2_from_g0, c2_from_cin);

  and (c3_from_g1,  propagate[2], generate_bit[1]);
  and (c3_from_g0,  propagate[2], propagate[1], generate_bit[0]);
  and (c3_from_cin, propagate[2], propagate[1], propagate[0], carry[0]);
  or  (carry[3], generate_bit[2], c3_from_g1, c3_from_g0, c3_from_cin);

  and (cout_from_g2,  propagate[3], generate_bit[2]);
  and (cout_from_g1,  propagate[3], propagate[2], generate_bit[1]);
  and (cout_from_g0,  propagate[3], propagate[2], propagate[1], generate_bit[0]);
  and (cout_from_cin, propagate[3], propagate[2], propagate[1], propagate[0], carry[0]);
  or  (carry[4], generate_bit[3], cout_from_g2, cout_from_g1, cout_from_g0, cout_from_cin);

  xor (sum[0], propagate[0], carry[0]);
  xor (sum[1], propagate[1], carry[1]);
  xor (sum[2], propagate[2], carry[2]);
  xor (sum[3], propagate[3], carry[3]);

  assign cout = carry[4];
endmodule
