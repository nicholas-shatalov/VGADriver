module VSyncCounter(input logic clock,
						  input logic enable_n,
						  input logic reset_n,
						  output logic out,
						  output logic out_display
						  );
				
				
logic [9:0] count;
logic clear_n;

always_comb begin

	if (count >= 525) begin
		clear_n = 0;
	end else begin
		clear_n = 1;
	end
	
	if(count <= 1) begin
		out = 0;
	end
	else begin
		out = 1;
	end
	
	if (count >= 35 & count < 515) begin
		out_display = 1;
	end
	else begin
		out_display = 0;
	end
	
end
						  


Counter #(.N(10)) counter_inst(
								       .clock(clock),
								       .clear_n(clear_n),
								       .reset_n(reset_n),
								       .enable_n(enable_n),
								       .addBy(1),
								       .count(count)
							          );
								
								
endmodule

