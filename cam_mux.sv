/*==============================================
# Module Name        : cam_mux
# Author             : Sen Lin
# E-mail             : sl3773@columbia.edu
# Created Date       : 09/13/2014
# Last Modified Date : 10/09/2014
==============================================*/

module cam_mux
#(
  DATA_WIDTH = 32,
  ADDR_WIDTH = 5,
  DEPTH      = (1<<ADDR_WIDTH),
  SIZE       = (DATA_WIDTH*DEPTH)
 )

(
 input       [ADDR_WIDTH-1:0] rd_addr_i,
 input       [SIZE-1:0]       data_i,
 input       [DEPTH-1:0]      written_i,
 input                        read_en_i,
 output logic                 read_valid_o,
 output logic[DATA_WIDTH-1:0] read_value_o
);

always_comb begin
  case(rd_addr_i)
    5'd0 : read_valid_o = read_en_i & written_i[0];
    5'd1 : read_valid_o = read_en_i & written_i[1];
    5'd2 : read_valid_o = read_en_i & written_i[2];
    5'd3 : read_valid_o = read_en_i & written_i[3];
    5'd4 : read_valid_o = read_en_i & written_i[4];
    5'd5 : read_valid_o = read_en_i & written_i[5];
    5'd6 : read_valid_o = read_en_i & written_i[6];
    5'd7 : read_valid_o = read_en_i & written_i[7];
    5'd8 : read_valid_o = read_en_i & written_i[8];
    5'd9 : read_valid_o = read_en_i & written_i[9];
    5'd10: read_valid_o = read_en_i & written_i[10];
    5'd11: read_valid_o = read_en_i & written_i[11];
    5'd12: read_valid_o = read_en_i & written_i[12];
    5'd13: read_valid_o = read_en_i & written_i[13];
    5'd14: read_valid_o = read_en_i & written_i[14];
    5'd15: read_valid_o = read_en_i & written_i[15];
    5'd16: read_valid_o = read_en_i & written_i[16];
    5'd17: read_valid_o = read_en_i & written_i[17];
    5'd18: read_valid_o = read_en_i & written_i[18];
    5'd19: read_valid_o = read_en_i & written_i[19];
    5'd20: read_valid_o = read_en_i & written_i[20];
    5'd21: read_valid_o = read_en_i & written_i[21];
    5'd22: read_valid_o = read_en_i & written_i[22];
    5'd23: read_valid_o = read_en_i & written_i[23];
    5'd24: read_valid_o = read_en_i & written_i[24];
    5'd25: read_valid_o = read_en_i & written_i[25];
    5'd26: read_valid_o = read_en_i & written_i[26];
    5'd27: read_valid_o = read_en_i & written_i[27];
    5'd28: read_valid_o = read_en_i & written_i[28];
    5'd29: read_valid_o = read_en_i & written_i[29];
    5'd30: read_valid_o = read_en_i & written_i[30];
    5'd31: read_valid_o = read_en_i & written_i[31];
  endcase
end

always_comb begin
  case(rd_addr_i)
    5'd0 : read_value_o = data_i[DATA_WIDTH-1:0];               
    5'd1 : read_value_o = data_i[DATA_WIDTH*2-1 :DATA_WIDTH*1 ];
    5'd2 : read_value_o = data_i[DATA_WIDTH*3-1 :DATA_WIDTH*2 ];
    5'd3 : read_value_o = data_i[DATA_WIDTH*4-1 :DATA_WIDTH*3 ];
    5'd4 : read_value_o = data_i[DATA_WIDTH*5-1 :DATA_WIDTH*4 ];
    5'd5 : read_value_o = data_i[DATA_WIDTH*6-1 :DATA_WIDTH*5 ];
    5'd6 : read_value_o = data_i[DATA_WIDTH*7-1 :DATA_WIDTH*6 ];
    5'd7 : read_value_o = data_i[DATA_WIDTH*8-1 :DATA_WIDTH*7 ];
    5'd8 : read_value_o = data_i[DATA_WIDTH*9-1 :DATA_WIDTH*8 ];
    5'd9 : read_value_o = data_i[DATA_WIDTH*10-1:DATA_WIDTH*9 ];
    5'd10: read_value_o = data_i[DATA_WIDTH*11-1:DATA_WIDTH*10];
    5'd11: read_value_o = data_i[DATA_WIDTH*12-1:DATA_WIDTH*11];
    5'd12: read_value_o = data_i[DATA_WIDTH*13-1:DATA_WIDTH*12];
    5'd13: read_value_o = data_i[DATA_WIDTH*14-1:DATA_WIDTH*13];
    5'd14: read_value_o = data_i[DATA_WIDTH*15-1:DATA_WIDTH*14];
    5'd15: read_value_o = data_i[DATA_WIDTH*16-1:DATA_WIDTH*15];
    5'd16: read_value_o = data_i[DATA_WIDTH*17-1:DATA_WIDTH*16];
    5'd17: read_value_o = data_i[DATA_WIDTH*18-1:DATA_WIDTH*17];
    5'd18: read_value_o = data_i[DATA_WIDTH*19-1:DATA_WIDTH*18];
    5'd19: read_value_o = data_i[DATA_WIDTH*20-1:DATA_WIDTH*19];
    5'd20: read_value_o = data_i[DATA_WIDTH*21-1:DATA_WIDTH*20];
    5'd21: read_value_o = data_i[DATA_WIDTH*22-1:DATA_WIDTH*21];
    5'd22: read_value_o = data_i[DATA_WIDTH*23-1:DATA_WIDTH*22];
    5'd23: read_value_o = data_i[DATA_WIDTH*24-1:DATA_WIDTH*23];
    5'd24: read_value_o = data_i[DATA_WIDTH*25-1:DATA_WIDTH*24];
    5'd25: read_value_o = data_i[DATA_WIDTH*26-1:DATA_WIDTH*25];
    5'd26: read_value_o = data_i[DATA_WIDTH*27-1:DATA_WIDTH*26];
    5'd27: read_value_o = data_i[DATA_WIDTH*28-1:DATA_WIDTH*27];
    5'd28: read_value_o = data_i[DATA_WIDTH*29-1:DATA_WIDTH*28];
    5'd29: read_value_o = data_i[DATA_WIDTH*30-1:DATA_WIDTH*29];
    5'd30: read_value_o = data_i[DATA_WIDTH*31-1:DATA_WIDTH*30];
    5'd31: read_value_o = data_i[DATA_WIDTH*32-1:DATA_WIDTH*31];
  endcase
end

endmodule
