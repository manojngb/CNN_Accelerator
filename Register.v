// Registers

module Register(
	clk,
	rst,
	data_in,
	addr_in,
	in_enable,
	data_out,
	addr_out,
	out_enable
	);
	
	parameter DATA_SIZE;
	parameter ADDR_SIZE;
	
	reg [DATA_SIZE-1:0]  reg_in;
	
	output []
	
	always @ (posedge clk or posedge rst) begin
		if (rst) begin
			in_enable <= 0;
			out_enable <= 0;
			data_out <= 0;
		end else if (in_enable) begin
			reg_in <= data_in;
			data_out<= reg_in;
		//end else begin
			//need to come up with third cdn to avoid latch creation
		end
		
	endmodule
			
			
			