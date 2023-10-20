//`include "transactor.sv"
class receiver;

virtual fifo_if vif;
mailbox rcvr2sb;

//// constructor method ////
  function new(virtual fifo_if vif,mailbox rcvr2sb);
   this.vif   = vif ;
   if(rcvr2sb == null)
   begin
     $display(" **ERROR**: rcvr2sb is null");
     $finish;
   end
   else
   this.rcvr2sb = rcvr2sb;
endfunction : new

task start();
  $display("receiver module started");
  
  fork

  //trans = new();
  forever begin
    transactor trans;
    trans=new();
    @(posedge vif.MONITOR.clk);
    wait(vif.MONITOR.monitor.rd_en||vif.MONITOR.monitor.wr_en)
    @(posedge vif.MONITOR.clk);
    if(vif.MONITOR.monitor.wr_en)
    begin
      trans.wr_en =vif.MONITOR.monitor.wr_en;
      trans.rd_en =vif.MONITOR.monitor.rd_en;
      trans.wdata = vif.MONITOR.monitor.wdata;
      trans.full =vif.MONITOR.monitor.full;
      trans.empty =vif.MONITOR.monitor.empty;
       end
    else begin
      trans.rd_en =vif.MONITOR.monitor.rd_en;
      trans.wr_en =vif.MONITOR.monitor.wr_en;
      trans.rdata = vif.MONITOR.monitor.rdata;
      trans.full =vif.MONITOR.monitor.full;
      trans.empty =vif.MONITOR.monitor.empty;
    end
    rcvr2sb.put(trans);
  end
  $display("end of receiver block");
  join_none
endtask : start

endclass
