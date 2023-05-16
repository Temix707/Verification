module shell_check(

/* sw_led
input  logic [2:0] SW,
  output logic [5:0] LED*/

/* clk_counter / PWM
  input   logic         CLK100MHZ,
  input   logic [15:0]  SW,
  output  logic [3:0]   LED*/


//  CLK 4Hz
  input   logic         CLK100MHZ,
  input   logic         BTND,
  //input   logic [15:0]  SW,

  output  logic [3:0]   LED

);

PushButton DUT_PB_4Hz     // modules: PushButton, Slow_Clock_4Hz, D_FF
(
  .clk_i    ( CLK100MHZ ),
  .push_b   ( BTND     ),
  
  .led      ( LED[0]    )
);


/*
PWM DUT_PWM (
  .clk ( CLK100MHZ ),
  .rst ( SW[15]    ),
  .led ( LED       )
 );*/


/*
clk_stb DUT_STB (
  .clk ( CLK100MHZ ),
  .rst ( SW[15]    ),
  .led ( LED       )
 );*/



/*
clk_counter DUT_CLK (
  .clk ( CLK100MHZ ),
  .rst ( SW[15]    ),
  .led ( LED       )
);*/


/*
sw_led DUT_SW_LED (
  .sw   ( SW  ),
  .led  ( LED )
);
*/

endmodule
