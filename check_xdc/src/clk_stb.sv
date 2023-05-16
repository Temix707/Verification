module clk_stb (
  input  logic       clk,
  input  logic       rst,
  
  output logic [3:0] led
);

  localparam DIV_BY = 27'd100_000_000;  // 100 million

  logic         stb;
  logic [26:0]  cnt = 0;      // log2(100_000_000) = 27 bit


  always_ff @( posedge clk ) begin
    if( rst ) begin
      cnt <= 0;
    end  
    else if( cnt != DIV_BY-1 ) begin
      stb         <= 0;
      cnt         <= cnt + 1;
    end 
    else begin
      stb         <= 1;
      cnt         <= 0;
    end
  end

  always_ff @( posedge clk ) begin
    if( stb ) begin
      led  <= led + 1;
    end
  end

endmodule