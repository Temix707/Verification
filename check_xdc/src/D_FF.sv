module D_FF(
  input   logic   clk,          // slow clock
  input   logic   D,            // pushbutton

  output  logic   Q,
  output  logic   Qbar
);

always_ff @( posedge clk ) begin
  Q     <= D;
  Qbar  <= !Q;
end


endmodule
