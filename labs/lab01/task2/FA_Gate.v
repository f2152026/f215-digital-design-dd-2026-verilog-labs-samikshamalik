module FA_Gate (
  input  a,
  input  b,
  input  cin,
  output sum,
  output cout
);
  wire propagate;
  wire generated_carry;
  wire propagated_carry;

  xor (propagate,         a, b);
  xor (sum,               propagate, cin);
  and (generated_carry,   a, b);
  and (propagated_carry,  propagate, cin);
  or  (cout,              generated_carry, propagated_carry);
endmodule
