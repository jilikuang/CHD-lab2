/*==============================================
# Module Name        : cam_decoder
# Author             : Sen Lin
# E-mail             : sl3773@columbia.edu
# Created Date       : 09/13/2014
# Last Modified Date : 09/13/2014
==============================================*/

module cam_decoder
#(parameter DATA_WIDTH = 32,
  parameter ADDR_WIDTH = 5,
  parameter DEPTH      = (1<<ADDR_WIDTH)
 )

(
 input                         en_i,
 input        [ADDR_WIDTH-1:0] addr_i,
 output logic [DEPTH-1:0]      en_o
);

 
 always_comb begin
   for(int iter=0;iter<DEPTH;iter++) begin
     en_o[iter] = (iter==addr_i)?en_i:'0;
   end
 end

endmodule
