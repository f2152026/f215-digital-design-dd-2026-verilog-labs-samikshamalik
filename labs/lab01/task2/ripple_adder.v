module ripple_adder (
  input  [3:0] a,
  input  [3:0] b,
  input        cin,
  output [3:0] sum,
  output       cout
);

  wire [4:0] carry;
  genvar bit_index;

  assign carry[0] = cin;

  generate
    for (bit_index = 0; bit_index < 4; bit_index = bit_index + 1) begin : ripple_stage
      FA_Gate full_adder (
        .a    (a[bit_index]),
        .b    (b[bit_index]),
        .cin  (carry[bit_index]),
        .sum  (sum[bit_index]),
        .cout (carry[bit_index + 1])
      );
    end
  endgenerate

  assign cout = carry[4];
endmodule
