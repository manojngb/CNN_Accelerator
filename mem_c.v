// mem_C
// This module is definitely needed for address management purposes, 
// 	otherwise, it is just a buffer

module Mem_C (
	clk,
	rst,
	add_result,
	output_data
	);
	
	always @ (posedge clk or posedge rst) begin
		if (rst) begin
			output_data <= 0;
		end else begin
			output_data <= add_result;
		end
	end
	
endmodule