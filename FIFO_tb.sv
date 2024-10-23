import FIFO_pck::*;
import shared_pck::*;
module FIFO_tb(FIFO_interface.test inter);

 FIFO_transaction tr;
initial begin
    test_finished=1'b0;
    tr=new();

    inter.rst_n=1'b0; tr.rst_n=1'b0;
    @(posedge inter.clk);#1;

    for (int i =0 ;i<100000 ;i++ ) begin
        RANDOMIZATION:assert(tr.randomize());
        //@(negedge inter.clk);#1;
        inter.rst_n = tr.rst_n;
        inter.wr_en = tr.wr_en;
        inter.rd_en = tr.rd_en;
        inter.data_in = tr.data_in;
        tr.data_out = inter.data_out;
        tr.almostfull = inter.almostfull;
        tr.full = inter.full;
        tr.almostempty = inter.almostempty;
        tr.empty = inter.empty;
        tr.overflow = inter.overflow;
        tr.underflow = inter.underflow;
        tr.wr_ack  = inter.wr_ack;
        @(posedge inter.clk); #1;
    end
    test_finished=1'b1;
end
endmodule