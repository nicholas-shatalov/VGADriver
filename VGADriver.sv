module VGADriver(
					  input logic clock,
					  input logic reset_n,
					  input logic [1:0] red_control,
					  input logic [1:0] green_control,
					  input logic [1:0] blue_control,
					  output logic hsync,
					  output logic vsync,
					  output logic [3:0] red_display,
					  output logic [3:0] green_display,
					  output logic [3:0] blue_display
					  );

logic enable_n;

logic [3:0] red_decoded;
logic [3:0] green_decoded;
logic [3:0] blue_decoded;

logic hdisplay;
logic vdisplay;

logic mux_input;
assign mux_input = hdisplay & vdisplay;		
		
EnableCounter enable_counter(
									  .clock(clock),
									  .reset_n(reset_n),
									  .enable_n(enable_n)
									  );
									  
SyncCounter sync_counter(
								 .clock(clock),		
								 .enable_n(enable_n),
								 .reset_n(reset_n),
								 .hdisplay(hdisplay),
								 .vdisplay(vdisplay),
								 .hsync(hsync),
								 .vsync(vsync)
								 );
								 
Decoder2_4 decoder_red(
							  .a(red_control),
							  .y(red_decoded)
							  );
							  
Decoder2_4 decoder_green(
							  .a(green_control),
							  .y(green_decoded)
							  );
							  
Decoder2_4 decoder_blue(
							  .a(blue_control),
							  .y(blue_decoded)
							  );
							  
							  
Mux_4 mux_red(
				  .d1(red_decoded),
				  .d0(0),
				  .s(mux_input),
				  .y(red_display)
				  );
				  
Mux_4 mux_green(
				  .d1(green_decoded),
				  .d0(0),
				  .s(mux_input),
				  .y(green_display)
				  );
				  
Mux_4 mux_blue(
				  .d1(blue_decoded),
				  .d0(0),
				  .s(mux_input),
				  .y(blue_display)
				  );
					  
					  
					  
endmodule
