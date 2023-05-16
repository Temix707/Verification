// pulse width modulation
// we reduce the brightness of four LEDs using a small duty cycle of 5/255.
module PWM(
  input      logic       clk,
  input      logic       rst,

  output     logic [3:0] led
);

  logic [7:0] cnt   = 0;              // 2.56*10^-6 bit
  logic [7:0] duty  = 8'd20;

  always_ff @( posedge clk ) begin
    if( rst ) begin
      cnt <= 0;
    end else begin
      cnt       <= cnt + 1;
      led[3:0]  <= ( cnt < duty ) ? 4'b1111 : 4'b0000;
    end
  end

endmodule
