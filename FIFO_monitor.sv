import FIFO_pck::*;
import FIFO_pck_cov::*;
import FIFO_scoreboard_pkg::*;
import shared_pck::*;

module FIFO_monitor(FIFO_interface.monitor inter);


    FIFO_transaction fifo_tr ;
    FIFO_Scoreboard fifo_scoreboard ;
    FIFO_coverage fifo_coverage ;
initial begin
     fifo_tr = new();
     fifo_scoreboard = new();
     fifo_coverage = new();
    forever begin

        @(negedge inter.clk);
        fifo_tr.rst_n=inter.rst_n;
        fifo_tr.data_in=inter.data_in;
        fifo_tr.rd_en=inter.rd_en;
        fifo_tr.wr_en=inter.wr_en;
        fifo_tr.data_out=inter.data_out;
        fifo_tr.almostfull=inter.almostfull;
        fifo_tr.full=inter.full;
        fifo_tr.almostempty=inter.almostempty;
        fifo_tr.empty=inter.empty;
        fifo_tr.overflow=inter.overflow;
        fifo_tr.underflow=inter.underflow;
        fifo_tr.wr_ack=inter.wr_ack;
        
        fork
        begin
            fifo_coverage.sample_data(fifo_tr);
        end 

        begin
            fifo_scoreboard.check_data(fifo_tr);
        end
     join        
     if( test_finished == 1 ) begin
        $display("Testbench Summary: %0d Test Cases Passed , %0d Test Cases Failed",correct_count,error_count);
        $stop;
    end
    end

end

endmodule