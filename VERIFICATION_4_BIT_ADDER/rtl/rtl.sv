


///////////////////////////////////////////////////////////////
/*
module four_bit_full_adder (a,b,cin,sum,cout);

    input [3:0]a;
    input [3:0]b;
    input cin;
    output [3:0]sum;
    output cout;
	
    assign {cout,sum}=a+b+cin;

endmodule
*/
//////////////////////////////////////////////////////////////////


//////////////////////////////////////////////////////////////////

module four_bit_full_adder (a,b,cin,sum,cout);
  input [3:0]a;
  input [3:0]b;
  input cin;
  output [3:0]sum;
  output cout;

  wire c1, c2, c3;

  assign sum[0] = (a[0]^b[0]^cin);
  assign c1 = ((a[0]&b[0])|(a[0]&cin)|(b[0]&cin));

  assign sum[1] = (a[1]^b[1]^c1);
  assign c2 = ((a[1]&b[1])|(a[1]&c1)|(b[1]&c1));

  assign sum[2] = (a[2]^b[2]^c2);
  assign c3 = ((a[2]&b[2])|(a[2]&c2)|(b[2]&c2));

  assign sum[3] = (a[3]^b[3]^c3);
  assign cout = ((a[3]&b[3])|(a[3]&c3)|(b[3]&c3));

endmodule

