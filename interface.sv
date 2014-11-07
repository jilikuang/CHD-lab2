/**
 * The interface between CAM and the testbench
 * Author: Jie-Gang Kuang
 */
`timescale 1ns/1ns

interface ifc #(
               parameter ADDR_WIDTH = 5,
               parameter DATA_WIDTH = 32)
(input bit clk);

   logic                  rst_n;
   logic                  r;
   logic [ADDR_WIDTH-1:0] r_idx;
   logic                  w;
   logic [ADDR_WIDTH-1:0] w_idx;
   logic [DATA_WIDTH-1:0] w_data;
   logic                  s;
   logic [DATA_WIDTH-1:0] s_data;

   logic                  r_vld;
   logic [DATA_WIDTH-1:0] r_data;
   logic                  s_vld;
   logic [ADDR_WIDTH-1:0] s_idx;

   // note that the outputs and inputs are reversed from the dut
   clocking cb @(posedge clk);
      output r, r_idx, w, w_idx, w_data, s, s_data;
      input  r_vld, r_data, s_vld, s_idx;
   endclocking

   modport bench (output rst_n, clocking cb);

   modport dut (
      input  clk, rst_n, r, r_idx, w, w_idx, w_data, s, s_data,
      output r_vld, r_data, s_vld, s_idx
	);
endinterface
