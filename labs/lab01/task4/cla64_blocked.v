module cla64_blocked (
  input  [63:0] a,
  input  [63:0] b,
  input         cin,
  output [63:0] sum,
  output        cout
);

  wire [16:0] block_carry;
  genvar block_index;

  assign block_carry[0] = cin;

  generate
    for (block_index = 0; block_index < 16; block_index = block_index + 1) begin : cla_block
      cla4 four_bit_cla (
        .a    (a[4 * block_index +: 4]),
        .b    (b[4 * block_index +: 4]),
        .cin  (block_carry[block_index]),
        .sum  (sum[4 * block_index +: 4]),
        .cout (block_carry[block_index + 1])
      );
    end
  endgenerate

  assign cout = block_carry[16];
endmodule
