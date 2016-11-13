// main PE unit

module PE (
	clk,
	rst,
	input_A,
	input_B,
	output_A,
	output_B,
	input_C,
	output_C,
	input_en,
	output_en
);

//define regs and in/outs here
parameter SIZE;
wire [SIZE] RA_out;
wire [SIZE] RB_out;
wire [SIZE] C_inter;
wire [SIZE] add_out;
wire [SIZE] memC_out;
wire [SIZE] fifoC_in;

//control logic (local FSM)

	always @ (posedge clk or posedge rst) begin
		if (rst) begin
			input_en <= 0;
			output_en <= 0;
			output_A <= 0;
			output_B <= 0;
			output_C <= 0;
		end else begin
		// TBD
		end
	end
	
	FIFO fifo_A (
	.clk (clk),
	.rst (rst),
	.data_in (input_A),
	.data_out (output_A),
	//***TBD
	//.write_sel (),
	//.read_sel (),
	//.read_en (),
	//.write_en (),
	//.full (),
	//.empty ()
	);
	
	FIFO fifo_B (
	.clk (clk),
	.rst (rst),
	.data_in (input_B),
	.data_out (output_B),
	//***TBD
	//.write_sel (),
	//.read_sel (),
	//.read_en (),
	//.write_en (),
	//.full (),
	//.empty ()
	);
		
	Register RA (
	.clk (clk),
	.rst (rst),
	.data_in (input_A),
	//.addr_in (),
	.in_enable (input_en),
	.data_out (RA_out),
	//.addr_out,
	//.out_enable
	);	
		
	Register RB (
	.clk (clk),
	.rst (rst),
	.data_in (input_B),
	//.addr_in (),
	.in_enable (input_en),
	.data_out (RB_out),
	//.addr_out,
	//.out_enable
	);	

	//Mux mux1 (					//if have multiple A registers
	//.data_1 (RA_out1),
	//.data_2 (RA_out2),
	//.select, //FSM determines
	//.data_out (RA_out));
		
	Mult multiplier (
	.clk (clk),
	.rst (rst),
	.input_A (RA_out),
	.input_B (RB_out),
	.output_C (C_inter)
	);	
	
	Mem_C memoryC (
	.clk (clk),
	.rst (rst),
	.add_result (add_out),
	.output_data (memC_out)
	);
	
	Add adder (
	.clk (clk),
	.rst (rst),
	.mult_out (C_inter),
	.prev_result (memC_out),
	.output_data (add_out)
	);
	
	//FSM controls select signal
	Mux mux2 (					
	.data_1 (add_out),
	.data_2 (input_C),
	.select, //FSM determines
	.data_out (fifoC_in)
	);
	
	FIFO fifo_C (
	.clk (clk),
	.rst (rst),
	.data_in (fifoC_in),
	.data_out (output_C),
	//***TBD
	//.write_sel (),
	//.read_sel (),
	//.read_en (),
	//.write_en (),
	//.full (),
	//.empty ()
	);
	