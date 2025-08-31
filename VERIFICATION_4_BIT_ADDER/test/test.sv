


class test extends uvm_test;

	`uvm_component_utils(test)
	
	function new(string name="test",uvm_component parent);
		super.new(name,parent);
	endfunction
	
	int no_of_trans=100;
	int no_of_write_agent=1;
	int no_of_read_agent=1;
	bit has_sb=1;
	bit has_vir_seqr=1;
	
	write_config write_cfg[];
	read_config read_cfg[];
	
	env_config env_cfg;
	
	environment env;
	
	virtual_sequence vseq;
	
	virtual function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		
		env_cfg=env_config::type_id::create("env_cfg");
		
		env_cfg.no_of_trans=no_of_trans;
		env_cfg.no_of_write_agent=no_of_write_agent;
		env_cfg.no_of_read_agent=no_of_read_agent;
		env_cfg.has_sb=has_sb;
		env_cfg.has_vir_seqr=has_vir_seqr;
		
		write_cfg=new[no_of_write_agent];
		read_cfg=new[no_of_read_agent];
		
		env_cfg.write_cfg=new[no_of_write_agent];
		env_cfg.read_cfg=new[no_of_read_agent];
		
		foreach(write_cfg[i])
		begin
			write_cfg[i]=write_config::type_id::create($sformatf("write_cfg[%0d]",i));
			env_cfg.write_cfg[i]=write_cfg[i];
			
			if(!uvm_config_db#(virtual fbfa)::get(this,"","fbfa",write_cfg[i].vif))
				`uvm_fatal("TEST","INTERFACE CONFIG FAILED INSIDE TEST CLASS");
			
			if(i==0)
			begin
				write_cfg[i].is_active=UVM_ACTIVE;
				uvm_config_db#(write_config)::set(this,$sformatf("*write_agt[%0d]*",i),"write_config",write_cfg[i]);
			end
			
			else
			begin
				write_cfg[i].is_active=UVM_PASSIVE;
				uvm_config_db#(write_config)::set(this,$sformatf("*write_agt[%0d]*",i),"write_config",write_cfg[i]);
			end
		end
		
		foreach(read_cfg[i])
		begin
			read_cfg[i]=read_config::type_id::create($sformatf("read_cfg[%0d]",i));
			env_cfg.read_cfg[i]=read_cfg[i];
			
			if(!uvm_config_db#(virtual fbfa)::get(this,"","fbfa",read_cfg[i].vif))
				`uvm_fatal("TEST","INTERFACE CONFIG FAILED INSIDE TEST CLASS");
			
			if(i==0)
			begin
				read_cfg[i].is_active=UVM_PASSIVE;
				uvm_config_db#(read_config)::set(this,$sformatf("*read_agt[%0d]*",i),"read_config",read_cfg[i]);
			end
			
			else
			begin
				read_cfg[i].is_active=UVM_ACTIVE;
				uvm_config_db#(read_config)::set(this,$sformatf("*read_agt[%0d]*",i),"read_config",read_cfg[i]);
			end
		end
		
		uvm_config_db#(env_config)::set(this,"*","env_config",env_cfg);
		
		env=environment::type_id::create("env",this);
		vseq=virtual_sequence::type_id::create("vseq");
		
	endfunction
	
	virtual function void end_of_elaboration_phase(uvm_phase phase);
		uvm_top.print_topology();
	endfunction
	
	virtual task run_phase(uvm_phase phase);
	
		phase.raise_objection(this);
		vseq.start(env.vseqr);
		phase.drop_objection(this);
		
	endtask
	
endclass
