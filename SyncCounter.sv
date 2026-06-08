module SyncCounter(
						 input logic clock,
						 input logic enable_n,
						 input logic reset_n,
						 output logic hdisplay,
						 output logic vdisplay,
						 output logic vsync,
						 output logic hsync,
						 output logic [9:0] h_display_count,
						 output logic [9:0] v_display_count
						 );
						 
// hdisplay and vdisplay are high during their respective display intervals and low everywhere else

logic vsync_enable_n;

HSyncCounter hsync_counter(
									.clock(clock),
									.enable_n(enable_n),		// have the counter always enabled
									.reset_n(reset_n),
									.out(hsync),
									.done_n(vsync_enable_n),
									.out_display(hdisplay),
									.out_count(h_display_count)
									);

VSyncCounter vsync_counter(
									.clock(clock),
									.enable_n(vsync_enable_n),		// have the counter enable after a line is finished
									.reset_n(reset_n),
									.out(vsync),
									.out_display(vdisplay),
									.out_count(v_display_count)
									);



endmodule