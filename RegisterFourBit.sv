
module RegisterNBit #(
	parameter N = 4
)(
								input logic clock,
								input logic clear_n,
								input logic reset_n,
								input logic [N-1:0] d,
								output logic [N-1:0] q
);

always @(posedge clock or negedge reset_n) begin
	if (reset_n == 1'b0) begin
		q <= 0;
	end else if (clear_n == 1'b0) begin
		q <= 0;
	end else begin
		q <= d;
	end
end

endmodule