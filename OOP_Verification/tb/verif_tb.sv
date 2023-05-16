`timescale 1ns / 1ps

/*
/////////// MAILBOX 1 ///////////

// Packet 
class packet;
  rand bit [7:0] addr;
  rand bit [7:0] data;

  //Displaying randomized values
  function void post_randomize();
    $display("Packet:: Packet Generated");
    $display("Packet:: Addr=%0d,Data=%0d", addr, data);
  endfunction
endclass

//Generator - Generates the transaction packet and send to driver
class generator;
  packet pkt;
  mailbox m_box;
  //constructor, getting mailbox handle
  function new( mailbox m_box );
    this.m_box = m_box;
  endfunction

  task run;
    repeat(2) begin
      pkt = new();
      pkt.randomize(); //generating packet
      m_box.put(pkt);  //putting packet into mailbox
      $display("Generator::Packet Put into Mailbox");
      #5;
    end
  endtask
endclass

// Driver - Gets the packet from generator and display's the packet items
class driver;
  packet pkt;
  mailbox m_box;

  //constructor, getting mailbox handle
  function new( mailbox m_box );
    this.m_box = m_box;
  endfunction

  task run;
    repeat(2) begin
      m_box.get(pkt); //getting packet from mailbox
      $display("Driver::Packet Recived");
      $display("Driver::Addr=%0d,Data=%0d\n",pkt.addr,pkt.data);
    end
  endtask
endclass

module verif_tb();
  generator gen;
  driver    dri;
  mailbox   m_box; //declaring mailbox m_box

  initial begin
    //Creating the mailbox, Passing the same handle to generator and driver, 
    //because same mailbox should be shared in-order to communicate.
    m_box = new(); //creating mailbox

    gen = new(m_box); //creating generator and passing mailbox handle
    dri = new(m_box); //creating driver and passing mailbox handle
    $display("------------------------------------------");
    fork
      gen.run(); //Process-1
      dri.run(); //Process-2
    join
    $display("------------------------------------------");
  end
*/












/////////// MAILBOX 2 ///////////
/*
module verif_tb();
  mailbox mb = new(3);    // mailbox #(string) mb = new(3);
  
  task process_A();
    int value;
    repeat(10) begin
      value = $urandom_range(1, 50);
      mb.put(value);
      $display("Put data = %0d", value);
    end
    $display("----------------------");
  endtask

  task process_B();
    int value;
    repeat(10) begin
      mb.get(value);
      $display("Retrieved data = %0d", value);
    end
  endtask
  
  initial begin
    fork
      $display("START");
      process_A();
      process_B();
    join
    $display("END");
  end
*/



/////////// MAILBOX 3 ///////////
module mailbox_example();
  mailbox mb = new(3);
  
  task process_A();
    int value;
    repeat(5) begin
      value = $urandom_range(1, 50);
      if(mb.try_put(value))
        $display("successfully try_put data = %0d", value);
      else begin
        $display("failed while try_put data = %0d", value);
        $display("Number of messages in the mailbox = %0d", mb.num());
      end
    end
    $display("---------------------------------------");
  endtask

  task process_B();
    int value;
    repeat(5) begin
      if(mb.try_get(value))
        $display("Successfully retrieved try_get data = %0d", value);
      else begin
        $display("Failed in try_get data");
        $display("Number of messages in the mailbox = %0d", mb.num());
      end
    end
  endtask
  
  initial begin
    fork
      process_A();
      process_B();
    join
  end














/*
/////////// VIRTUAL ///////////

// without virtual. base class display() method is called when it is not declared as virtual.
// with virtual. child class display() method when it is declared as virtual.

class parent_trans;
  bit [31:0] data;
  int id;
  
  virtual function void display();
     $display("Base: Value of data = %0h and id = %0h", data, id);
  endfunction
endclass

class child_trans extends parent_trans;
  function void display();
    $display("Child: Value of data = %0h and id = %0h", data, id);
  endfunction  
endclass

module verif_tb;
  initial begin
    parent_trans p_tr;
    child_trans c_tr;
    c_tr = new();
    
    p_tr = c_tr;
    p_tr.data = 5;
    p_tr.id = 1;
    p_tr.display();
  end
*/










/*
/////////// CLASS ///////////
class transaction;
  bit [31:0]  data;
  int         id; 
  rand  bit [4:0] num1; // all numbers in the bit depth range
  randc bit [3:0] num2; // all numbers in the bit range until all numbers are assigned

  constraint num1_range { num1 > 20; }
  constraint num2_range { if( data < 25 ) num2 == 10;
                          else            num2 == 7 ; }
    
  task static update( bit [31:0] data, int id );
    this.data = data;
    this.id = id;
  endtask
    
  function print();
    $display("Value of data = %0d and id = %0d", data, id);
  endfunction
endclass

class season extends transaction;
  bit [4:0] day;
  bit [3:0] month;
  
  function void print_base();
    super.print();
    $display("Well done");
  endfunction
endclass

module verif_tb();

  initial begin
    transaction tr [1];
    season s1 = new();
    
    s1.data = 5;
    s1.id   = 7;
    s1.day  = 17;
    $display("Value of data = %0d, id = %0d, day = %0d", s1.data, s1.id, s1.day );
    s1.print_base();
    
    
    for( int i = 0; i < $size(tr); i++ ) begin
      tr[i] = new();
    end

    repeat ( 3 ) begin
      tr[0].randomize();
      tr[0].update( tr[0].num1, tr[0].num2 );
      tr[0].print();
    end

    repeat ( 3 ) begin
      tr[1].randomize();
      tr[1].update( tr[1].num1, tr[1].num2 );
      tr[1].print();
    end

  end
*/













/*
/////////// FUNCTION ///////////
  int num_func1, num_func2;

  function int sum_func(input int a, b); //                               1 func
    //sum_func = a + b;
    return a + b;   
  endfunction

  function automatic int factorial ( input int a ); begin //              2 func
    if (a > 1) begin
      factorial = a * factorial(a - 1);
    end
    else begin
      factorial = 1;
    end
  end
  endfunction

  function void auto_example_func(); //                                        3 func
    automatic int auto_var = 0;
    static int    static_var = 0; // or int
    auto_var++;
    static_var++;
    $display("Automatic variable = %0d", auto_var);
    $display("Static variable = %0d",    static_var);
  endfunction

  initial begin
    // func 1 
    $display("FUNK 1");
    num_func1 = sum_func( 7, 5 );
    $display("Value of func1 = %0d", num_func1);

    //func 2
    $display("FUNK 2");
    num_func2 = factorial( 4 );
    $display("Value of func2 = %0d", num_func2);

    //func 3
    $display("FUNK 3");
    repeat ( 5 ) begin
      auto_example_func(); 
    end
  end













/////////// TASK ///////////


  int num_task1;

  task sum_task( input int a,b, output int c ); //                          1 task
    c = a + b;   
  endtask

  task example ( input time delay );  //                                    2 task
    if (delay == 0) begin
      $display("exit from task");
      return;
    end
    #delay
    $display("Simulation time = %0t ns", $time);
  endtask


	task auto_example_task( input time delay ); //                                3 task
    // Initialize the variables
    logic           static_var  = 1'b0;
    automatic logic auto_var    = 1'b0;
    // Display the values at start of task
    $display("Entering task at %0tns",    $time);
    $display("Automatic variable = %0d",  auto_var);
    $display("Static variable = %0d",     static_var);
    // Wait the given time and invert the signals
    #delay
    static_var  = ~static_var;
    auto_var    = ~auto_var;
    // Display the values at end of task
    $display("Task completed at %0tns",   $time);
    $display("Automatic variable = %0d",  auto_var);
    $display("Static variable = %0d",     static_var);
  endtask


  initial begin
    // task 1
    $display("TASK 1");
    sum_task( 10, 5, num_task1 );
    $display("\tValue of task1 = %0d", num_task1);

    // task 2
    $display("TASK 2");
    example(10ns);
    example(0ns);
    example(30ns);

    // task 3
    $display("TASK 3");
    auto_example_task(0ns);
    auto_example_task(10ns);  
  end
*/

  //rand  int [4:0] num1; // all numbers in the bit depth range
  //randc int [4:0] num2; // all numbers in the bit range until all numbers are assigned

endmodule
