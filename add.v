// adder

module Add (
	clk,
	rst,
	mult_out,
	prev_result,
	output_data
	);
	
	always @ (posedge clk or posedge rst) begin
		if (rst) begin
			output_data <= 0;
		end else begin
			output_data <= mult_out + prev_result;
		end
	end
	
endmodule