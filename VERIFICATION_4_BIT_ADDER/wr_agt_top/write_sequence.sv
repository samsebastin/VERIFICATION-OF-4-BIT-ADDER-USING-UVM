


class write_sequence extends uvm_sequence#(trans);

	`uvm_object_utils(write_sequence)
	
	function new(string name="write_sequence");
		super.new(name);
	endfunction
	
	env_config ch;
	
	virtual task body();
	
		if(!uvm_config_db#(env_config)::get(null,get_full_name(),"env_config",ch))
			`uvm_fatal("WRITE SEQUENCE","CONFIG FAILED INSIDE WRITE SEQUENCE CLASS");
			
		repeat(ch.no_of_trans)
		begin
			req=trans::type_id::create("req");
			start_item(req);
			assert(req.randomize());
			finish_item(req);
		end
		
	endtask
	
endclass
