class scoreboard;

mailbox gen2driv;
mailbox rcv2sb;
//coverage cov = new();

  function new(mailbox gen2driv,mailbox rcv2sb);
  this.gen2driv= gen2driv;
  this.rcv2sb = rcv2sb;
endfunction:new


task start();
  transactor trans_rcv,trans_exp;
 
  trans_rcv = new();
  trans_exp = new();
  fork 
  forever
  begin
    rcv2sb.get(trans_rcv);
    $display(" 0 : Scoreboard : Scoreboard received a packet from receiver ",$time);
    gen2driv.get(trans_exp);
    if(trans_rcv.compare(trans_exp))
     
       $display(" 0 : Scoreboard :Packet Matched ",$time);
    //cov.sample(pkt_exp);
      //error++;
  end
  join_none
endtask : start

endclass
    no_trans++;
   end
  endtask
endclass
