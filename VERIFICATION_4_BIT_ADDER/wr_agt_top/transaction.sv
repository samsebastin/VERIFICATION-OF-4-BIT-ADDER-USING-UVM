


class trans extends uvm_sequence_item;

	`uvm_object_utils(trans)
	
	function new(string name="trans");
		super.new(name);
	endfunction
	
	randc bit[3:0]a;
	randc bit[3:0]b;
	
	bit cin;
	
	bit [3:0]sum;
	bit cout;
	
	virtual function void do_print(uvm_printer printer);
		super.do_print(printer);
		printer.print_field("a",this.a,$bits(a),UVM_DEC);
		printer.print_field("b",this.b,$bits(b),UVM_DEC);
		printer.print_field("cin",this.cin,$bits(cin),UVM_DEC);
		printer.print_field("sum",this.sum,$bits(sum),UVM_DEC);
		printer.print_field("cout",this.cout,$bits(cout),UVM_DEC);
	endfunction
	
endclass
