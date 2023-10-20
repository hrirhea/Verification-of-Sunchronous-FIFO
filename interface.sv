interface fifo_if(input logic clk);
  logic rd_en;
  logic rst;
  logic wr_en;
  logic [7:0]wdata;
  logic [7:0]rdata;
  logic full,empty;
  
  
  clocking driver_cb@(posedge clk);
    default input #1 output #1;
    output rst;
    output wdata;
    output rd_en;
    output wr_en;
    input full;
    input empty;
    input rdata;
  endclocking
  
  
  clocking monitor@(posedge clk);
    input rst;
    input rd_en;
    input wr_en;
    input wdata;
    input rdata;
    input full,empty;
  endclocking
  
  modport DRIVER (clocking driver_cb,input clk);
    modport MONITOR (clocking monitor,input clk);
    
    endinterface
    
