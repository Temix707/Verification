module Slow_Clock_4Hz(
  input   logic     clk_i,  // 100 MHz

  // 100 MHz / 4 Hz = 25_000_000 full cycles -_-_ => 25_000_000 / 2 = 12_500_000

  output logic clk_o   // 4Hz slow clock
);

  //localparam DIV_COUNT = 26'd12_500_000;

  logic [25:0] count = 0;

  always_ff @( posedge clk_i ) begin
    count <= count + 1;
    if( count == 12_500_000 ) begin
      count   <= 0;
      clk_o   = ~clk_o;   // inverts the clock    , during half of the cycle it will be on, during the next half of the cycle it will be off
    end
  end

endmodule
