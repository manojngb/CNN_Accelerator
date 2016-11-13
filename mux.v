//MUX

module Mux (
	data_1,
	data_2,
	select,
	data_out);
	
	if (select) begin
		data_out <= data_2;
	end else begin 
		data_out <=	data_1;
	end
	
endmodule;