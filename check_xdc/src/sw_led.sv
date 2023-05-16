module sw_led(
  input  clk,
  input  logic [2:0] sw,
  output logic [5:0] led
);

 always_comb begin
        if (sw[0]) begin
            led[1:0] = 2'b11;
        end else begin
            led[1:0] = 2'b00;
        end

        if (sw[1]) begin
            led[3:2] = 2'b11;
        end else begin
            led[3:2] = 2'b00;
        end
        
        if (sw[2]) begin
            led[5:4] = 2'b00;
        end else begin
            led[5:4] = 2'b11;
        end
    end
endmodule
