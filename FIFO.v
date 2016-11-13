//FIFO Module

module FIFO (
	clk,
	rst,
	write_sel,
	read_sel,
	data_in,
	read_en,
	write_en,
	data_out,
	full,
	empty
	);
	
	//given data stream where width is
	parameter DATA_W = 8;
	//and address width is
	parameter ADDR_W = 8;
	//thus depth is
	parameter RAM_DEPTH = (1 << ADDR_W);
	
	input clk, rst, write_sel, read_sel, write_en, read_en;
	input [DATA_W - 1: 0] data_in;
	output full;
	output empty;
	output [DATA_W - 1: 0] data_out;
	
	
	reg [ADDR_W-1:0] w_pt;
	reg [ADDR_W-1:0] r_pt;
	reg [ADDR_W:0] status;
	reg [DATA_W-1:0] data_out;
	reg [DATA_W-1:0] data_ram;
	
	assign full = (status == (RAM_DEPTH-1));
	assign empty = (status == 0);
	
	always @ (posedge clk or posedge rst)
	begin: WRITE_PTR
		if (rst) begin
			w_pt <= 0;
		end else if (write_sel && write_en) begin
			w_pt <= w_pt + 1;
		end
	end
	
	always @ (posedge clk or posedge rst)
	begin: READ_PTR
		if (rst) begin
			r_pt <= 0;
		end else if (read_sel && read_en) begin
			r_pt <= r_pt + 1;
		end
	end
	
	always @ (posedge clk or posedge rst)
	begin: READ_DATA
		if (rst) begin
			data_out <= 0;
		end else if (read_sel && read_en) begin
			data_out <= data_ram;
		end
	end
	
	always @ (posedge clk or posedge rst)
	begin: STATUS_CNT
		if (rst) begin
			status <= 0;
			//Read but don't write
			end else if ((read_en && read_sel) && !(write_sel && write_en) && (status != 0)) begin
				status <= status - 1;
			//Write but don't read_en
			end else if (!(read_en && read_sel) && (write_sel && write_en) && (status != RAM_DEPTH)) begin
				status <= status + 1;
		end
	end

//add code here for the module that inputs data, need:
	// input address, input data, wr chip select, write enable, output enable, 
	//output address, output data, rd chip select, read en, output enable
	//instantiate the module here:
	// module_name (
	// .addr (), 
	// etc
	//);
	
end module