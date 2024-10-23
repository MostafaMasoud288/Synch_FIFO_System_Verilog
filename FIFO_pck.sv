package FIFO_pck ;
class FIFO_transaction;

///variables///
parameter FIFO_WIDTH = 16;
parameter FIFO_DEPTH = 8;
rand logic [FIFO_WIDTH-1:0] data_in;
rand logic clk, rst_n, wr_en, rd_en;
logic [FIFO_WIDTH-1:0] data_out;
logic wr_ack, overflow;
logic full, empty, almostfull, almostempty, underflow;
integer RD_EN_ON_DIST , WR_EN_ON_DIST;

////constructor////
function new (integer RD_EN_ON_DIST =30,integer WR_EN_ON_DIST =70 );
this.RD_EN_ON_DIST=RD_EN_ON_DIST;
this.WR_EN_ON_DIST=WR_EN_ON_DIST;
endfunction
////constrains////
constraint c1{rst_n dist{0:/5,1:/95};}
constraint c2{wr_en dist{0:/100-WR_EN_ON_DIST ,1:/WR_EN_ON_DIST };}
constraint c3{rd_en dist{0:/100-RD_EN_ON_DIST,1:/RD_EN_ON_DIST};}

endclass
endpackage
