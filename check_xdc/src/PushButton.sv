module PushButton(
  input   logic clk_i,
  input   logic push_b,

  output  logic led
);

wire logic clk_o;
wire logic Q1, Q2, Q2_bar;

Slow_Clock_4Hz DUT_CLK_4Hz
(
  .clk_i( clk_i ),
  .clk_o( clk_o )
);

D_FF D1
(
  .clk( clk_o   ),
  .D  ( push_b  ),

  .Q  ( Q1 )
);

D_FF D2
(
  .clk( clk_o   ),
  .D  ( Q1      ),

  .Q  ( Q2 )
);

assign Q2_bar = ~Q2;
assign led    = Q1 & Q2_bar;


endmodule
