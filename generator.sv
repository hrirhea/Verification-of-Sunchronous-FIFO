//Generator generates signals and declares the transaction class handles
//Randomise transactions
//`include "transactor.sv"
class generator;
  
  rand transactor trans;
  mailbox gen2driv;
  int repeat_count;
  int count;
  
  function new(mailbox gen2driv);
    this.gen2driv = gen2driv;
    $display("allocated memory for generator ");
  endfunction
  
  task main();
    repeat(repeat_count) 
      begin
      trans=new();
        if(!trans.randomize())   
          $fatal("packet is not randomised");
        else
          
          $display(" %d  :randomization is successfull",++count);
      
      gen2driv.put(trans);
    end
  endtask:main
endclass
  
