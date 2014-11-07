/*==============================================
# Program Name       : bench
# Author             : Sen Lin & Jie-Gang Kuang
# Created Date       : 10/05/2014
# Last Modified Date : 10/13/2014
==============================================*/
`timescale 1ns/1ns

class configuration;
   bit dbg_msg;
   int cfg_seed;
   int cycles;

   rand int input_seed;

   rand int d_rst; // Density of reset
   rand int d_r;   // Density of read
   rand int d_w;   // Density of write
   rand int d_s;   // Density of search

   rand bit [4:0] m_idx_r;   // Mask of read index
   rand bit [4:0] m_idx_w;   // Mask of write index

   rand bit [31:0] m_data_w; // Mask of write data
   rand bit [31:0] m_data_s; // Mask of search data

   bit auto_config;  // Usage unknown. Need to check

   real d_rst_real;
   real d_r_real;
   real d_w_real;
   real d_s_real;

   constraint range {
      d_rst <= cycles; d_rst >= 0;
      d_r <= cycles; d_r >= 0;
      d_w <= cycles; d_w >= 0;
      d_s <= cycles; d_s >= 0;
   }

   function new(string config_file);
      string cmd;
      string opt;
      int file, r;

      // Set default value first
      dbg_msg = 0;
      cfg_seed = 1;
      input_seed = 1;
      cycles = 10000;
      d_rst_real = 0.002;
      d_r_real = 0.8;
      d_w_real = 0.8;
      d_s_real = 0.8;
      m_idx_r = 5'h1f;
      m_idx_w = 5'h1f;
      m_data_w = 32'hffffffff;
      m_data_s = 32'hffffffff;
      auto_config = 0;

      // Read from config file to adjust
      file = $fopen(config_file, "r");
      if (file) begin
         $display("Read config from %s", config_file);
         while (!$feof(file)) begin
            r = $fscanf(file, "%s %s", cmd, opt);
            case (cmd)
               "dbg_msg": dbg_msg = opt.atoi();
               "cfg_seed": cfg_seed = opt.atoi();
               "input_seed": input_seed = opt.atoi();
               "max_cycles": cycles = opt.atoi();
               "density_reset": d_rst_real = opt.atoreal();
               "density_read": d_r_real = opt.atoreal();
               "density_write": d_w_real = opt.atoreal();
               "density_search": d_s_real = opt.atoreal();
               "index_mask_read": m_idx_r = opt.atohex();
               "index_mask_write": m_idx_w = opt.atohex();
               "data_mask_write": m_data_w = opt.atohex();
               "data_mask_search": m_data_s = opt.atohex();
               "auto_configure": auto_config = opt.atoi();
               default:;
            endcase
         end
      end
      $fclose(file);

      d_rst = d_rst_real * cycles;
      d_r = d_r_real * cycles;
      d_w = d_w_real * cycles;
      d_s = d_s_real * cycles;

      if (!auto_config)
         this.rand_mode(0);
      else
         this.srandom(cfg_seed);

   endfunction

   function void print();
      $display("Configuration:");
      $display("dbg_msg: %d", dbg_msg);
      $display("cfg_seed: %d", cfg_seed);
      $display("input_seed: %d", input_seed);
      $display("max_cycles: %d", cycles);
      $display("density_reset: %f", d_rst_real);
      $display("density_read: %f", d_r_real);
      $display("density_write: %f", d_w_real);
      $display("density_search: %f", d_s_real);
      $display("index_mask_read: 0x%h", m_idx_r);
      $display("index_mask_write: 0x%h", m_idx_w);
      $display("data_mask_write: 0x%h", m_data_w);
      $display("data_mask_search: 0x%h", m_data_s);
      $display("auto_configure: %d", auto_config);
   endfunction

endclass

class transaction;
   rand bit rst_n;
   rand bit r;
   rand bit [4:0] r_idx;
   rand bit w;
   rand bit [4:0] w_idx;
   rand bit [31:0] w_data;
   rand bit s;
   rand bit [31:0] s_data;

   static int cyc;

   static int d_rst;
   static int d_r;
   static int d_w;
   static int d_s;

   static bit [4:0] m_idx_r;
   static bit [4:0] m_idx_w;
   static bit [31:0] m_data_w;
   static bit [31:0] m_data_s;

   static bit [4:0] written_idx[$] = {};
   static bit [31:0] written_data[$] = {};

   constraint rst_dist {
      if (d_rst == 0)
         rst_n == 1;
      else if (d_rst == cyc)
         rst_n == 0;
      else
         rst_n dist { 0 := d_rst, 1 := cyc-d_rst };
   }

   constraint r_dist {
      if (d_r == 0)
         r == 0;
      else if (d_r == cyc)
         r == 1;
      else
         r dist { 1 := d_r, 0 := cyc-d_r };
   }

   constraint w_dist {
      if (d_w == 0)
         w == 0;
      else if (d_w == cyc)
         w == 1;
      else
         w dist { 1 := d_w, 0 := cyc-d_w };
   }

   constraint s_dist {
      if (d_s == 0)
         s == 0;
      else if (d_s == cyc)
         s == 1;
      else
         s dist { 1 := d_s, 0 := cyc-d_s };
   }

   function void post_randomize();
      r_idx &= m_idx_r;
      w_idx &= m_idx_w;
      w_data &= m_data_w;
      s_data &= m_data_s;
   endfunction

   function void set_config(ref configuration cfg);
      this.srandom(cfg.input_seed);

      cyc = cfg.cycles;

      d_rst = cfg.d_rst;
      d_r = cfg.d_r;
      d_w = cfg.d_w;
      d_s = cfg.d_s;

      m_idx_r = cfg.m_idx_r;
      m_idx_w = cfg.m_idx_w;
      m_data_w = cfg.m_data_w;
      m_data_s = cfg.m_data_s;
   endfunction

   function void print_setting();
      $display("Transaction setting:");
      $display("cycles: %d", cyc);
      $display("d_rst: %d", d_rst);
      $display("d_r: %d", d_r);
      $display("d_w: %d", d_w);
      $display("d_s: %d", d_s);
      $display("m_idx_r: 0x%h", m_idx_r);
      $display("m_idx_w: 0x%h", m_idx_w);
      $display("m_data_w: 0x%h", m_data_w);
      $display("m_data_s: 0x%h", m_data_s);
   endfunction

   function void print_output();
      $display("Random result:");
      $display("rst_n\tr\tr_idx\tw\tw_idx\tw_data\t\ts\ts_data");
      $display("%d\t%d\t0x%h\t%d\t0x%h\t0x%h\t%d\t0x%h",
               rst_n, r, r_idx, w, w_idx, w_data, s, s_data);
   endfunction

endclass

class tb_cam;
   logic [31:0] r_vld;
   logic [31:0][31:0] mem;
   logic [31:0] s_vld;
   logic [4:0] s_idx;

   function void reset(bit rst);
      if (!rst) begin
         r_vld = 0;
         s_idx = 0;
         s_vld = 0;
         for (int i=0; i<32; i++) begin
            mem[i] = 0;
         end
      end
   endfunction

   function void write(bit rst_n, bit w, bit[4:0] w_idx, bit[31:0] w_data);
      if (rst_n && w) begin
         r_vld[w_idx] = 1'b1;
         mem[w_idx] = w_data;
      end
   endfunction

   function void search(bit s, bit[31:0] s_data);
      if (s) begin
         s_idx = 0;
         s_vld = 0;
         for (int i=0; i<32; i++) begin
            if (mem[i] == s_data && r_vld[i] == 1) begin
               s_idx = i;
               s_vld[i] = 1;
               break;
            end
         end
      end else begin
         s_idx = 0;
         s_vld = 0;
      end
   endfunction

   function int check_reset(bit rst, bit r_vld, bit s_vld);
      int pass = 0;
         if (!rst) begin
            if (r_vld == 0 && s_vld == 0) begin
               pass =1;
               $display("%t: %s", $realtime, "Check Reset: Set Reset: Pass !\n");
            end else begin
               $display("%t: %s", $realtime, "Check Reset: Set Reset: Fail !\n");
               $display("%d %d", r_vld, s_vld);
         end
      end else begin
         pass = 1;
         $display("%t: %s", $realtime, "Check Reset: Not Set Reset: Pass !\n");
      end
      return pass;
   endfunction

   function int check_read(bit r, bit [4:0] idx, bit vld, bit [31:0] data);
      int pass = 0;
      if (r && (r_vld[idx] || vld)) begin
         if ((vld == r_vld[idx]) && (data == mem[idx])) begin
            pass = 1;
            $display("%t: %s", $realtime, "Check Read: Read Valid Data: Pass !\n");
         end else begin
            $display("%t: %s", $realtime, "Check Read: Read Valid Data: Fail !\n");
         end
      end else if (vld == 0) begin
         pass = 1;
         $display("%t: %s", $realtime, "Check Read: Read Invalid Data: Pass !\n");
      end
      return pass;
   endfunction

   function int check_search(bit s, bit [31:0] data, bit vld, bit[4:0] idx);
      int pass = 0;
      if (s && (s_vld[idx] || vld)) begin
         if (vld == s_vld[idx] && idx == s_idx) begin
            pass = 1;
            $display("%t: %s", $realtime, "Check Search: Find Data: Pass !\n");
         end else begin
            pass = 0;
            $display("%t: %s", $realtime, "Check Search: Find Data: Fail !\n");
         end
      end else begin
         pass = 1;
         $display("%t: %s", $realtime, "Check Search: Cannot Find Data: Pass !\n");
      end
      return pass;
   endfunction

endclass

program tb (ifc.bench ds);
   configuration cfg;
   transaction igen;
   tb_cam mycam;

   initial begin
      cfg = new("config");
      cfg.randomize();
      if (cfg.dbg_msg) cfg.print();

      mycam = new();

      igen = new();
      igen.set_config(cfg);
      if (cfg.dbg_msg) igen.print_setting();

      // Reset and warm up
      ds.rst_n = 1;
      @(ds.cb);
      ds.rst_n = 0;
      mycam.reset(0);
      @(ds.cb);
      ds.rst_n = 1;
      @(ds.cb);

      repeat (cfg.cycles) begin
         assert(igen.randomize());
         if (cfg.dbg_msg) igen.print_output();

         // drive inputs for next cycle
         $display("%t: %s\n", $realtime, "Driving New Values");
         ds.rst_n <= igen.rst_n;  // Need to check how to test reset
         ds.cb.r <= igen.r;
         ds.cb.r_idx <= igen.r_idx;
         ds.cb.w <= igen.w;
         ds.cb.w_idx <= igen.w_idx;
         ds.cb.w_data <= igen.w_data;
         ds.cb.s <= igen.s;
         ds.cb.s_data <= igen.s_data;
         mycam.reset(igen.rst_n);
         mycam.search(igen.s, igen.s_data);

         @(ds.cb);

         // Check each function
         assert(mycam.check_reset(igen.rst_n, ds.cb.r_vld, ds.cb.s_vld))
            else $fatal("Reset failed");
         assert(mycam.check_read(igen.r, igen.r_idx, ds.cb.r_vld, ds.cb.r_data))
            else $fatal("Read failed");
         assert(mycam.check_search(igen.s, igen.s_data, ds.cb.s_vld, ds.cb.s_idx))
            else $fatal("Search failed");

         // Place write here to have correct timing
         mycam.write(igen.rst_n, igen.w, igen.w_idx, igen.w_data);
      end
   end

endprogram
