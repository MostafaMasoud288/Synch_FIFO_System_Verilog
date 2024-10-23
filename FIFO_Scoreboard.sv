package FIFO_scoreboard_pkg;

import FIFO_pck::*;
import shared_pck::*;

class FIFO_Scoreboard;

bit almostfull_ref,full_ref;
bit almostempty_ref,empty_ref;
bit overflow_ref,underflow_ref;
bit wr_ack_ref;
bit [15:0]data_out_ref;

bit [15:0] mem [$];

function void reference_model (FIFO_transaction tr1) ;
if(tr1.rst_n) begin
    if(tr1.wr_en &&!tr1.rd_en && !tr1.full) begin
        mem.push_front(tr1.data_in);
    end
    else if(!tr1.wr_en && tr1.rd_en && !tr1.empty) begin
        data_out_ref<=mem.pop_back;
         
    end

    else if(tr1.wr_en && tr1.rd_en && !tr1.full && !tr1.empty) begin
         mem.push_front(tr1.data_in);
         data_out_ref<=mem.pop_back;
        
          
    end
    else if (tr1.wr_en && tr1.rd_en && tr1.full) begin
         data_out_ref<=mem.pop_back;
          
    end
     else if (tr1.wr_en && tr1.rd_en && tr1.empty) begin
            mem.push_front(tr1.data_in);
    end
end
else if(!tr1.rst_n) begin
    mem.delete;
end


if(data_out_ref == tr1.data_out) begin
        correct_count=correct_count+1;
        end
        else begin
            error_count=error_count+1;
            $display("Error: at %0t ns  Expected data_out = 0x%0h  ,data_out = 0x%0h ",$time,data_out_ref,tr1.data_out);
            $display("Transaction details at %0t ns: rst_n = %0b, wr_en = %0b, rd_en = %0b, data_in = 0x%0h, data_out = 0x%0h, full = %0b, empty = %0b, wr_ack = %0b",
            $time, tr1.rst_n, tr1.wr_en, tr1.rd_en, tr1.data_in, tr1.data_out, tr1.full, tr1.empty, tr1.wr_ack);
        end

endfunction

function void check_data (FIFO_transaction tr2) ;
reference_model(tr2);
endfunction

endclass
endpackage