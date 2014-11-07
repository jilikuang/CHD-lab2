/*==============================================
# Module Name        : cam_encoder
# Author             : Sen Lin
# E-mail             : sl3773@columbia.edu
# Created Date       : 10/09/2014
# Last Modified Date : 10/09/2014
==============================================*/

module cam_encoder
#(
  ADDR_WIDTH = 5,
  DEPTH      = (1<<ADDR_WIDTH)
 )

(
 input       [DEPTH-1:0]      match_i,
 output logic[ADDR_WIDTH-1:0] search_index_o,
 output logic                 search_valid_o
);


always_comb begin
  search_valid_o = |match_i;
end


always_comb begin
  casex(match_i)
    32'b0000_0000_0000_0000_0000_0000_0000_0001: search_index_o = 5'd0;
    32'b0000_0000_0000_0000_0000_0000_0000_001x: search_index_o = 5'd1;
    32'b0000_0000_0000_0000_0000_0000_0000_01xx: search_index_o = 5'd2;
    32'b0000_0000_0000_0000_0000_0000_0000_1xxx: search_index_o = 5'd3;
    32'b0000_0000_0000_0000_0000_0000_0001_xxxx: search_index_o = 5'd4;
    32'b0000_0000_0000_0000_0000_0000_001x_xxxx: search_index_o = 5'd5;
    32'b0000_0000_0000_0000_0000_0000_01xx_xxxx: search_index_o = 5'd6;
    32'b0000_0000_0000_0000_0000_0000_1xxx_xxxx: search_index_o = 5'd7;
    32'b0000_0000_0000_0000_0000_0001_xxxx_xxxx: search_index_o = 5'd8;
    32'b0000_0000_0000_0000_0000_001x_xxxx_xxxx: search_index_o = 5'd9;
    32'b0000_0000_0000_0000_0000_01xx_xxxx_xxxx: search_index_o = 5'd10;
    32'b0000_0000_0000_0000_0000_1xxx_xxxx_xxxx: search_index_o = 5'd11;
    32'b0000_0000_0000_0000_0001_xxxx_xxxx_xxxx: search_index_o = 5'd12;
    32'b0000_0000_0000_0000_001x_xxxx_xxxx_xxxx: search_index_o = 5'd13;
    32'b0000_0000_0000_0000_01xx_xxxx_xxxx_xxxx: search_index_o = 5'd14;
    32'b0000_0000_0000_0000_1xxx_xxxx_xxxx_xxxx: search_index_o = 5'd15;
    32'b0000_0000_0000_0001_xxxx_xxxx_xxxx_xxxx: search_index_o = 5'd16;
    32'b0000_0000_0000_001x_xxxx_xxxx_xxxx_xxxx: search_index_o = 5'd17;
    32'b0000_0000_0000_01xx_xxxx_xxxx_xxxx_xxxx: search_index_o = 5'd18;
    32'b0000_0000_0000_1xxx_xxxx_xxxx_xxxx_xxxx: search_index_o = 5'd19;
    32'b0000_0000_0001_xxxx_xxxx_xxxx_xxxx_xxxx: search_index_o = 5'd20;
    32'b0000_0000_001x_xxxx_xxxx_xxxx_xxxx_xxxx: search_index_o = 5'd21;
    32'b0000_0000_01xx_xxxx_xxxx_xxxx_xxxx_xxxx: search_index_o = 5'd22;
    32'b0000_0000_1xxx_xxxx_xxxx_xxxx_xxxx_xxxx: search_index_o = 5'd23;
    32'b0000_0001_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx: search_index_o = 5'd24;
    32'b0000_001x_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx: search_index_o = 5'd25;
    32'b0000_01xx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx: search_index_o = 5'd26;
    32'b0000_1xxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx: search_index_o = 5'd27;
    32'b0001_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx: search_index_o = 5'd28;
    32'b001x_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx: search_index_o = 5'd29;
    32'b01xx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx: search_index_o = 5'd30;
    32'b1xxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx: search_index_o = 5'd31;
  default: search_index_o = 5'd0;
  endcase
end

endmodule
