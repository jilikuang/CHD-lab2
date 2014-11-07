/*==============================================
# Module Name        : eff
# Author             : Sen Lin
# E-mail             : sl3773@columbia.edu
# Created Date       : 10/09/2014
# Last Modified Date : 10/09/2014
==============================================*/

module eff #(DATA_WIDTH=32)
(
 input                         clk,
 input                         rst_n,
 input                         wr_en_i,
 input        [DATA_WIDTH-1:0] data_i,
 output logic [DATA_WIDTH-1:0] data_o,
 output logic                  written_o
);

 logic [DATA_WIDTH-1:0] data;


 always_ff @(posedge clk or negedge rst_n) begin
   if(rst_n == '0) begin
     written_o <= '0;
   end else if(wr_en_i) begin
     data <= data_i;
     written_o <= 1'b1;
   end
 end

 always_comb begin
     data_o = data;
 end

endmodule
