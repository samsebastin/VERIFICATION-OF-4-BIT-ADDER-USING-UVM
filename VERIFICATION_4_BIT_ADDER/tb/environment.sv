


class environment extends uvm_env;

	`uvm_component_utils(environment)
	
	function new(string name="environment",uvm_component parent);
		super.new(name,parent);
	endfunction
	
	write_agent_top write_agt_top;
	read_agent_top read_agt_top;
	scoreboard sb;
	virtual_sequencer vseqr;
	
	env_config ch;
	
	virtual function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		
		if(!uvm_config_db#(env_config)::get(this,"","env_config",ch))
			`uvm_fatal("ENVIRONMENT","CONFIG FAILED INSIDE ENVIRONMENT CLASS");
		
		write_agt_top=write_agent_top::type_id::create("write_agt_top",this);
		read_agt_top=read_agent_top::type_id::create("read_agt_top",this);
		
		if(ch.has_sb)
		begin	
			sb=scoreboard::type_id::create("sb",this);
		end

		if(ch.has_vir_seqr)
		begin
			vseqr=virtual_sequencer::type_id::create("vseqr",this);
		end
		
	endfunction

	virtual function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);

		foreach(vseqr.write_seqr[i])
		begin
			if(ch.write_cfg[i].is_active==UVM_ACTIVE)
			begin
				vseqr.write_seqr[i]=write_agt_top.write_agt[i].write_seqr;
			end
		end

		foreach(write_agt_top.write_agt[i])
		begin
			write_agt_top.write_agt[i].write_mon.wrm2sb.connect(sb.wrm2sb.analysis_export);
		end
		
		foreach(read_agt_top.read_agt[i])
		begin
			read_agt_top.read_agt[i].read_mon.rdm2sb.connect(sb.rdm2sb.analysis_export);
		end
		
	endfunction
	
endclass
