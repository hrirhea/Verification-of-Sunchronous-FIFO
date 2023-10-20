`include "transactor.sv"
`include "generator.sv"
`include "driver.sv"
`include "receiver.sv"
`include "scoreboard.sv"
class environment;
  
 generator gen;
  driver driv;
  receiver rcv;
  scoreboard sb;
  
  mailbox gen2driv;
 // mailbox driv2sb;
  mailbox rcv2sb;
  
  event gen_ended;
  
  virtual fifo_if vif_ff;
  
  function new(virtual fifo_if vif_ff);
    this.vif_ff = vif_ff;
    $display("environment created");
    endfunction
  task build();
    $display("entered into the build phase");
       gen2driv = new();
   // driv2sb = new();
    rcv2sb = new();
       
     gen = new(gen2driv);
    driv = new(vif_ff,gen2driv);
    rcv  = new(vif_ff,rcv2sb);
    sb = new(gen2driv,rcv2sb);
  endtask
  
  task pre_test();
    driv.reset();
  endtask
  
  task test();
    fork
    gen.main();
    driv.main();
    rcv.start();
    sb.start();
    join
  endtask
  
  task post_test();
   //wait(gen_ended.triggered);
    wait(gen.repeat_count == driv.no_of_transactions);
  endtask
  
  task run();
    //build();
    pre_test();
    test();
    //post_test();
    $finish();
  endtask
  
  
endclass
  
  
