


class scoreboard  extends uvm_scoreboard;

	`uvm_component_utils(scoreboard)
	
	uvm_tlm_analysis_fifo#(trans) wrm2sb;
	uvm_tlm_analysis_fifo#(trans) rdm2sb;
	
	trans wm;
	trans rm;
	trans h;

	covergroup cg;

		a : coverpoint h.a {
					bins zero = {0};
					bins one = {1};
					bins two = {2};
					bins three = {3};
					bins four = {4};
					bins five = {5};
					bins six = {6};
					bins seven = {7};
					bins eight = {8};
					bins nine = {9};
					bins ten = {10};
					bins eleven = {11};
					bins twelve = {12};
					bins thirteen = {13};
					bins fourteen = {14};
					bins fifteen = {15};
				   }

		b : coverpoint h.b {
					bins zero = {0};
					bins one = {1};
					bins two = {2};
					bins three = {3};
					bins four = {4};
					bins five = {5};
					bins six = {6};
					bins seven = {7};
					bins eight = {8};
					bins nine = {9};
					bins ten = {10};
					bins eleven = {11};
					bins twelve = {12};
					bins thirteen = {13};
					bins fourteen = {14};
					bins fifteen = {15};
				   }

	endgroup

	function new(string name="scoreboard",uvm_component parent);
		super.new(name,parent);
		cg=new();
	endfunction
	
	virtual function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		
		wrm2sb = new("wrm2sb",this);
		rdm2sb = new("rdm2sb",this);
		
	endfunction

	virtual task run_phase(uvm_phase phase);
	
		forever 
		begin
			wrm2sb.get(wm);
			h=wm;
			cg.sample();
			rdm2sb.get(rm);
			`uvm_info("SCOREBOARD","DATAS RECIEVED FROM READ MONITOR",UVM_NONE);
			rm.print();
			dummy(wm);
			`uvm_info("SCOREBOARD","DATAS RECIEVED FROM REFERENCE MODEL",UVM_NONE);
			wm.print();
			task_to_check(wm);
		end
		
	endtask
	
	task dummy(trans h1);
	
		{h1.cout,h1.sum}=h1.a+h1.b+h1.cin;
		
	endtask
	
	task task_to_check(trans h2);
	
		$display("sum from ref model = %0d         sum from read monitor = %0d",h2.sum,rm.sum);
		$display("cout from ref model = %0d         cout from read monitor = %0d",h2.cout,rm.cout);
		$display("");
	
		if((h2.sum == rm.sum) && (h2.cout == rm.cout))
		begin
			$display("##########################################################################");
			$display("");
			$display("#####################          SUCCESS           #########################");
			$display("");
			$display("##########################################################################");
		end
		
		else 
		begin
			$display("##########################################################################");
			$display("");
			$display("#####################          FAILURE           #########################");
			$display("");
			$display("##########################################################################");
		end
		
	endtask
		
endclass
