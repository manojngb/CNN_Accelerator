// multplier

module Mult (
	clk,
	rst,
	input_A,
	input_B,
	output_C
	);
	
	always @ (posedge clk or posedge rst) begin
		if (rst) begin
			output_C <= 0;
		end else begin
			output_C <= input_A * input_B;
		end
	end
	
endmodule
			