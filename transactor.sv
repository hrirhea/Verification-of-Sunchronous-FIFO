class transactor;
  rand bit rd_en;
  rand bit wr_en;
  rand bit [7:0]wdata;
  bit [7:0]rdata;
  bit full;
  bit empty;
  constraint rd_wr_en{ rd_en!= wr_en;}

  virtual function bit compare(transactor trans);
  compare =1'b1;
  if(trans==null)
    compare =0;
  else begin
    if(trans.wr_en!=this.wr_en)
      compare = 0;
    if(trans.rd_en!=this.rd_en)
      compare = 0;
    if(trans.wdata!=this.wdata)
      compare = 0;
    if(trans.rdata!=this.rdata)
      compare = 0;
    if(trans.full!=this.full)
      compare = 0;
    if(trans.empty!=this.empty)
      compare = 0;
  end
  
endfunction
endclass
    
    
    
    
    
    
