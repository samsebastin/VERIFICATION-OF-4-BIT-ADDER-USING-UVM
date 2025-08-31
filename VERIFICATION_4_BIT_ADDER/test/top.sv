


module top;

	import uvm_pkg::*;

	import adder_pkg::*;
	
	fbfa vif();
	
	four_bit_full_adder dut (
				.a(vif.a)
				,.b(vif.b)
				,.cin(vif.cin)
				,.sum(vif.sum)
				,.cout(vif.cout)
				);

initial
begin
	uvm_config_db#(virtual fbfa)::set(null,"*","fbfa",vif);
	run_test("test");
end

endmodule


