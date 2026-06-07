module HSyncCounter(input logic clock,
						  input logic enable_n,
						  input logic reset_n,
						  output logic out,
						  output logic done_n,
						  output logic out_display
						  );
				
				
logic [9:0] display_count;
logic [9:0] count;
assign display_count = (count >= 800) ? 10'd0 : count;
logic clear_n;

always_comb begin
    // clear and done still use raw count to prevent sync issues we had
    clear_n = (count >= 800) ? 0 : 1;
	 done_n = ((count == 10'd799) && (enable_n == 1'b0)) ? 1'b0 : 1'b1;
	 
    // outputs use display_count so we don't have a 2ps desync
    out = (display_count <= 95) ? 0 : 1;
    out_display = (display_count >= 144 && display_count < 784) ? 1 : 0;
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