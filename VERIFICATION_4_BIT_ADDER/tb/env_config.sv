


class env_config extends uvm_object;

	`uvm_object_utils(env_config)
	
	function new(string name="env_config");
		super.new(name);
	endfunction
	
	int no_of_trans;
	int no_of_write_agent;
	int no_of_read_agent;
	bit has_sb;
	bit has_vir_seqr;
	
	write_config write_cfg[];
	read_config read_cfg[];
	
endclass
