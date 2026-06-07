
module Counter #(
    parameter N = 4 
)(
								input logic clock,
								input logic clear_n,
								input logic reset_n,
								input logic enable_n,
								input logic addBy,
								output logic [N-1:0] count
);

logic reset_n_register;
assign reset_n_register = reset_n;

logic [N:0] count_next;
assign count_next = count + addBy;


RegisterNBit #(.N(N)) register1(.clock(clock),
								  .clear_n(clear_n),
								  .reset_n(reset_n_register), 
								  .d(enable_n ? count : count_next[N-1:0]), 
								  .q(count)	
								  );
						
						  
endmodule
						  