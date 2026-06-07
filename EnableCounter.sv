

module EnableCounter(
							input logic clock,
							input logic reset_n,
							output logic enable_n
							);
			
logic alternate;
			
always_ff @(posedge clock or negedge reset_n) begin

	if (!reset_n) begin
		alternate <= 0;
		enable_n <= 1;
	end
	else if (alternate == 0) begin
		enable_n <= 0;
		alternate <= 1;
	end
	else if (alternate == 1) begin
		enable_n <= 1;
		alternate <= 0;
	end else begin
		enable_n <= 1;
		alternate <= 0;
	end

end					
							
endmodule