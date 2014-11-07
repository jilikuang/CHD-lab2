/*==============================================
# Module Name        : rws_ff
# Author             : Sen Lin
# E-mail             : sl3773@columbia.edu
# Created Date       : 09/13/2014
# Last Modified Date : 09/13/2014
==============================================*/

module rws_ff #(DATA_WIDTH=32)
(
 input                         clk,
 input                         rst_n,
 input                         wr_en_i,
 input        [DATA_WIDTH-1:0] data_i,
 input        [DATA_WIDTH-1:0] data_compare_i,
 input                         compare_en_i,
 output logic [DATA_WIDTH-1:0] data_o,
 output logic                  match_o,
 output logic                  written_o
);

 //logic [DATA_WIDTH-1:0] data;

 eff #(.DATA_WIDTH(DATA_WIDTH))
  ff (.*);

 always_comb begin
   match_o=(compare_en_i && data_compare_i==data_o && written_o == 1'b1)?1'b1:'0;
 end

endmodule
