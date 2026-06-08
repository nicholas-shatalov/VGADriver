module VSyncCounter(input logic clock,
						  input logic enable_n,
						  input logic reset_n,
						  output logic out,
						  output logic out_display,
						  output logic [9:0] out_count
						  );
				
				
logic [9:0] display_count;
logic [9:0] count;
assign display_count = (count >= 525) ? 10'd0 : count;
logic clear_n;

always_comb begin
    clear_n = (count >= 525) ? 0 : 1;
    out = (display_count <= 1) ? 0 : 1;
    out_display = (display_count >= 35 && display_count < 515) ? 1 : 0;
	 out_count = out_display ? (display_count - 35) : 10'd0;
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

