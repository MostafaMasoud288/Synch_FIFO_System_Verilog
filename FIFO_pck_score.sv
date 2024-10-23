package FIFO_pck_score;
import FIFO_pck::*;
import shared_pck::*;
class FIFO_scoreboard;
///variables////
logic [15:0] data_out_ref;
logic [15:0] ref_queue [$];

FIFO_transaction F_score =new;
////data checker////
function void check_data (FIFO_transaction F_check);
reference_model(F_check);

 if(this.data_out_ref !=F_check.data_out) begin
    $display("incorrect result %t that reference value : 0h%h, true value :0h%h",$time,data_out_ref,F_check.data_out);
    error_count=error_count+1; end
 else
  correct_count=correct_count+1;

endfunction

function reference_model (FIFO_transaction F_check);
if(!F_check.rst_n)begin
   ref_queue.delete();
end
else if (F_check.wr_en &&  !F_check.full) begin
   ref_queue.push_back(F_check.data_in);
end
else if (F_check.wr_en && F_check.rd_en && F_check.full) begin
   data_out_ref=ref_queue.pop_front();
end
else if (F_check.wr_en && F_check.rd_en && F_check.empty) begin
   ref_queue.push_back(F_check.data_in);
end
else if ( F_check.rd_en && !F_check.empty) begin
   data_out_ref=ref_queue.pop_front();
end



return data_out_ref ;
endfunction

endclass
endpackage
