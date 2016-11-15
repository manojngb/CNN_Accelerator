module sig_altmult_add
(
	
	input signed [15:0] dataa, datab, datac, datad,
	input 		clock, aclr,
	output reg 	[32:0] result
);

	reg signed	[15:0] dataa_reg, datab_reg, datac_reg, datad_reg;
	reg signed	[31:0] mult0_result, mult1_result;

	always @ (posedge clock or posedge aclr) begin
    	if (aclr) begin
			dataa_reg <= {16{1'b0}};
			datab_reg <= {16{1'b0}};
			datac_reg <= {16{1'b0}};
			datad_reg <= {16{1'b0}};
			mult0_result <= {32{1'b0}};
			mult1_result <= {32{1'b0}};
			result <= {33{1'b0}};
		end
		else begin
			dataa_reg <= dataa;
			datab_reg <= datab;
			datac_reg <= datac;
			datad_reg <= datad;
			mult0_result <= dataa_reg * datab_reg;
			mult1_result <= datac_reg * datad_reg;
			result <= mult0_result + mult1_result;
		end
	end
endmodule
