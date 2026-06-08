module bigMux(
	input logic [15:0]d0, d1,
	input logic s,
	output logic [15:0] y
);

	Mux_4 mux_top  (.d0(d0[15:12]), .d1(d1[15:12]), .s(s), .y(y[15:12]));
	Mux_4 mux_red	(.d0(d0[11:8]),  .d1(d1[11:8]),  .s(s), .y(y[11:8]));
	Mux_4 mux_green(.d0(d0[7:4]),  .d1(d1[7:4]),  .s(s), .y(y[7:4]));
	Mux_4 mux_blue (.d0(d0[3:0]),  .d1(d1[3:0]),  .s(s), .y(y[3:0]));

endmodule