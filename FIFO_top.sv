module FIFO_top();
bit clk;
	//clock generation
  initial begin
    clk = 0;
    forever begin
      #5 clk = ~clk;
    end
  end
FIFO_interface inf(clk);
FIFO DUT (inf);
FIFO_tb TEST (inf);
FIFO_monitor MONITOR (inf);

endmodule
