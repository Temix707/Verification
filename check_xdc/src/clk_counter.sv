module clk_counter(
  input  logic        clk,
  input  logic        rst,
  output logic [3:0]  led
);

  logic [31:0] cnt = 0;  // 32-bit counter

  always_ff @( posedge clk ) begin
    if( rst ) begin
      cnt <= 0;
    end else begin
      cnt    <= cnt + 1;
      led[0] <= cnt[26];    // counts up to 67_108_864, blinks the slowest, 2^26 * 10*10^-9 = 0,67 sec
      led[1] <= cnt[24];    // counts up to 16_777_216
      led[2] <= cnt[22];    // counts up to 4_194_304
      led[3] <= cnt[20];    // counts up to 1_048_576,  blinks the fastest  2^20 * 10*10^-9 = 0,0104 sec
    end
  end

endmodule
