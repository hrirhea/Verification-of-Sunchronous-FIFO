//`include "transactor.sv"
class driver;
  
  virtual fifo_if vif_ff;
  
  mailbox gen2driv;
  mailbox driv2sb;
  int no_of_transactions;
  
  function new (virtual fifo_if vif_ff,mailbox gen2driv);
    
    this.vif_ff = vif_ff;
    this.gen2driv = gen2driv;
    //this.driv2sb = driv2sb;
  endfunction
    
  task reset();
    $display(" entered into reset mode ");
      vif_ff.DRIVER.driver_cb.rst<=1;
  //    vif_ff.DRIVER.driver_cb.rd_en<=0;
    //  vif_ff.DRIVER.driver_cb.wdata<=0;
    repeat(4)
    @(posedge vif_ff.DRIVER.clk)
      
      vif_ff.DRIVER.driver_cb.rst<=0;
    
    //vif_ff.rst<=1;
    //repeat(3)@(posedge vif_ff.clk);
    //vif_ff.rst<=0;
    $display(" leaving from reset mode ");
    endtask :reset
    
  task main(); 
    $display(" entered into transaction mode");
    fork :main
     forever begin
     transactor trans;
       trans=new();
      //vif_ff.DRIVER.driver_cb.wr_en<=0;
      //vif_ff.DRIVER.driver_cb.rd_en<=0;
      gen2driv.get(trans);
      @(posedge vif_ff.DRIVER.clk)
       if(trans.wr_en||trans.rd_en) begin
      if(trans.wr_en) begin
        vif_ff.DRIVER.driver_cb.wr_en<=trans.wr_en;
        vif_ff.DRIVER.driver_cb.rd_en<=trans.rd_en;
        vif_ff.DRIVER.driver_cb.wdata<=trans.wdata;
        $display("\wr_en=%h \wdata=%h",trans.wr_en,trans.wdata);
        @(posedge vif_ff.DRIVER.clk);
      end
       
       else begin
         vif_ff.DRIVER.driver_cb.wr_en<=trans.wr_en;
         vif_ff.DRIVER.driver_cb.rd_en<=trans.rd_en;
         trans.rdata =vif_ff.MONITOR.monitor.rdata;
         $display("\rd_en=%h \rdata=%h",trans.rd_en,vif_ff.MONITOR.monitor.rdata);
         
      end
       end
       //driv2sb.put(gen2driv.get(trans));
       //trans=new();
       
       no_of_transactions++;
       $display("no.of.transactions=%d",no_of_transactions);
     end
    join_none :main
    endtask
      
endclass
      
    
    
