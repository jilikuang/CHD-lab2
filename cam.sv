/*==============================================
# Module Name        : cam
# Author             : Sen Lin
# E-mail             : sl3773@columbia.edu
# Created Date       : 09/13/2014
# Last Modified Date : 09/13/2014
==============================================*/

module cam 
#(
  parameter ADDR_WIDTH=5,
  parameter DATA_WIDTH=32,
  parameter DEPTH     =(1<<ADDR_WIDTH),
  parameter SIZE      =(DATA_WIDTH*DEPTH)
 )

(
   ifc.dut cam_if
);


//Read_decoder
 wire        [DEPTH-1:0]      rd_en_o;
 cam_decoder #(.DATA_WIDTH(DATA_WIDTH),
               .ADDR_WIDTH(ADDR_WIDTH))
 cam_read_decoder(
              .en_i(cam_if.r),
              .addr_i(cam_if.r_idx),
              .en_o(rd_en_o)
             );

//Write_decoder
 wire        [DEPTH-1:0]      wr_en_o;
 cam_decoder #(.DATA_WIDTH(DATA_WIDTH),
               .ADDR_WIDTH(ADDR_WIDTH))
 cam_write_decoder(
              .en_i(cam_if.w),
              .addr_i(cam_if.w_idx),
              .en_o(wr_en_o)
             );

 //Memory
 wire        [SIZE-1:0]       data_o;
 wire        [DEPTH-1:0]      match_o;
 wire        [DEPTH-1:0]      written_o;

 generate
   for(genvar iter=0;iter<DEPTH;iter++) begin
     rws_ff #(.DATA_WIDTH(DATA_WIDTH))
     my_rws_ff(
              .clk(cam_if.clk),
              .rst_n(cam_if.rst_n),
              .wr_en_i(wr_en_o[iter]),
              .data_i(cam_if.w_data),
              .data_compare_i(cam_if.s_data),
              .compare_en_i(cam_if.s),
              .data_o(data_o[(iter+1)*DATA_WIDTH-1:iter*DATA_WIDTH]),
              .match_o(match_o[iter]),
              .written_o(written_o[iter])
             );
   end
 endgenerate

 //mux
 cam_mux #(.DATA_WIDTH(DATA_WIDTH),
           .ADDR_WIDTH(ADDR_WIDTH))
 my_cam_mux(.rd_addr_i(cam_if.r_idx),
            .data_i(data_o),
            .written_i(written_o),
            .read_en_i(cam_if.r),
            .read_valid_o(cam_if.r_vld),
            .read_value_o(cam_if.r_data)
           );

 //encoder
 cam_encoder #(.ADDR_WIDTH(ADDR_WIDTH))
 my_cam_encoder(.match_i(match_o),
                .search_valid_o(cam_if.s_vld),
                .search_index_o(cam_if.s_idx)
               );
endmodule
