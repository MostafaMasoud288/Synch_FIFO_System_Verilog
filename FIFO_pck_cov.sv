package FIFO_pck_cov;
import FIFO_pck::*;
class FIFO_coverage;
////object////
FIFO_transaction F_cvg_txn =new;
////functional coverage////
covergroup cov;

wr_ack_cp:coverpoint F_cvg_txn.wr_ack
{
    bins wr_ack_0={0};
    bins wr_ack_1={1};
}
overflow_cp:coverpoint F_cvg_txn.overflow
{
    bins overflow_0={0};
    bins overflow_1={1};
}
underflow_cp:coverpoint F_cvg_txn.underflow
{
    bins underflow_0={0};
    bins underflow_1={1};
}
full_cp:coverpoint F_cvg_txn.full
{
    bins full_0={0};
    bins full_1={1};
}
almostfull_cp:coverpoint F_cvg_txn.almostfull
{
    bins almostfull_0={0};
    bins almostfull_1={1};
}
empty_cp:coverpoint F_cvg_txn.empty
{
    bins empty_0={0};
    bins empty_1={1};
}
almostempty_cp:coverpoint F_cvg_txn.almostempty
{
    bins almostempty_0={0};
    bins almostempty_1={1};
}
wr_ack: cross F_cvg_txn.wr_en, F_cvg_txn.rd_en,wr_ack_cp;
overflow: cross F_cvg_txn.wr_en, F_cvg_txn.rd_en,overflow_cp;
underflow: cross F_cvg_txn.wr_en, F_cvg_txn.rd_en,underflow_cp;
full: cross F_cvg_txn.wr_en, F_cvg_txn.rd_en,full_cp;
empty: cross F_cvg_txn.wr_en, F_cvg_txn.rd_en,empty_cp;
almostfull: cross F_cvg_txn.wr_en, F_cvg_txn.rd_en,almostfull_cp;
almostempty: cross F_cvg_txn.wr_en, F_cvg_txn.rd_en,almostempty_cp;
endgroup

function new();
 cov=new();
 cov.start();
endfunction 

////sampling////
function void sample_data (FIFO_transaction F_txn);
F_cvg_txn=F_txn;
cov.sample();
endfunction

endclass
endpackage
