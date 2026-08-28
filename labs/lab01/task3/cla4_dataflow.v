module cla4_dataflow (
  input  [3:0] a,
  input  [3:0] b,
  input        cin,
  output [3:0] sum,
  output       cout
);

  wire [3:0] propagate;
  wire [3:0] generate_bit;
  wire [4:0] carry;

  assign propagate    = a ^ b;
  assign generate_bit = a & b;
  assign carry[0]     = cin;

  assign carry[1] = generate_bit[0] | (propagate[0] & carry[0]);
  assign carry[2] = generate_bit[1] | (propagate[1] & generate_bit[0]) |
                    (propagate[1] & propagate[0] & carry[0]);
  assign carry[3] = generate_bit[2] | (propagate[2] & generate_bit[1]) |
                    (propagate[2] & propagate[1] & generate_bit[0]) |
                    (propagate[2] & propagate[1] & propagate[0] & carry[0]);
  assign carry[4] = generate_bit[3] | (propagate[3] & generate_bit[2]) |
                    (propagate[3] & propagate[2] & generate_bit[1]) |
                    (propagate[3] & propagate[2] & propagate[1] & generate_bit[0]) |
                    (propagate[3] & propagate[2] & propagate[1] & propagate[0] & carry[0]);

  assign sum  = propagate ^ carry[3:0];
  assign cout = carry[4];

endmodule
