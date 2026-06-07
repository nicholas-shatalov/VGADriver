/*
 * ECE 272 Lab 6 Testbench
 *
 * Author(s): Quinn Yockey
 * Last Modified: 24 November 2025
 */

// Horizontal timing
`define H_PULSE_WIDTH (96)
`define H_BACK_PORCH  (48)
`define H_DISPLAY_LEN (640)
`define H_FRONT_PORCH (16)

// Vertical timing
`define V_PULSE_WIDTH (2)
`define V_BACK_PORCH  (33)
`define V_DISPLAY_LEN (480)
`define V_FRONT_PORCH (10)

// Module output state
`define COLOR_ON      (1'b1)
`define COLOR_OFF     (1'b0)

/*
 * NOTE: To use a constant in code, prefix it with a backtick (`).
 *
 * Example: validatePixel(`COLOR_ON);
 */

module VgaTestbench();

    /* Declare internal logic */

    /*
     * TODO Change signal names to match your design.  Use Ctrl+H to search and
     * replace in Quartus editor
     */

    // Module inputs
    logic clock;
    logic reset_n;
    logic [1:0] red_control;
    logic [1:0] green_control;
    logic [1:0] blue_control;

    // Module outputs
    logic hsync;
    logic vsync;
    logic [3:0] red_display;
    logic [3:0] green_display;
    logic [3:0] blue_display;

    /*
     * Select input color.  Use full intensity red, green, and blue to display
     * white.
     */
    assign red_control   = 2'b11;
    assign green_control = 2'b11;
    assign blue_control  = 2'b11;

    /*
     * Define a clock to oscillate with a period of 2 ps.
     *
     * NOTE: This represents the 50 MHz clock.  The 25 MHz VGA clock will have
     * a period of 4 ps.
     */
    always begin
        clock = 1'b0;
        #1;
        clock = 1'b1;
        #1;
    end

    /* Create instance of VgaDriver device under test. */
    /* TODO */

	 VGADriver dut(
	 .clock(clock),
	 .reset_n(reset_n),
	 .red_control(red_control),
	 .green_control(green_control),
	 .blue_control(blue_control),
	 .hsync(hsync),
	 .vsync(vsync),
	 .red_display(red_display),
	 .green_display(green_display),
	 .blue_display(blue_display)
	 );
	 
    /*
     * Assert that the `hsync` signal is low.  Print an error message otherwise.
     */
    task assertHsyncLow();
        if (hsync !== 1'b0) begin
            $display("%0t ps: hsync expected low", $time);
        end
    endtask

    /*
     * Assert that the `hsync` signal is high.  Print an error message
     * otherwise.
     */
    task assertHsyncHigh();
        if (hsync !== 1'b1) begin
            $display("%0t ps: hsync expected high", $time);
        end
    endtask

    /*
     * Assert that the `vsync` signal is low.  Print an error message otherwise.
     */
    task assertVsyncLow();
        if (vsync !== 1'b0) begin
            $display("%0t ps: vsync expected low", $time);
        end
    endtask

    /*
     * Assert that the `vsync` signal is high.  Print an error message
     * otherwise.
     */
    task assertVsyncHigh();
        if (vsync !== 1'b1) begin
            $display("%0t ps: vsync expected high", $time);
        end
    endtask

    /*
     * Assert that the VGA driver module is outputing color to the screen (i.e.
     * in the display interval).  Print an error message otherwise.
     */
    task assertColorOn();
        /* TODO */
		  if(red_display !== 4'b1111) begin
				$display("%0t ps: red expected all ON", $time);
		  end
		  if(green_display !== 4'b1111) begin
				$display("%0t ps: green expected all ON", $time);
		  end
		  if(blue_display !== 4'b1111) begin
				$display("%0t ps: blue expected all ON", $time);
		  end
    endtask

    /*
     * Assert that the VGA driver module is not outputing color to the screen
     * (i.e. in the blanking interval).  Print an error message otherwise.
     */
    task assertColorOff();
        /* TODO */		  
		  if(red_display !== 4'b0000) begin
				$display("%0t ps: red expected all OFF", $time);
		  end
		  if(green_display !== 4'b0000) begin
				$display("%0t ps: green expected all OFF", $time);
		  end
		  if(blue_display !== 4'b0000) begin
				$display("%0t ps: blue expected all OFF", $time);
		  end
    endtask

    /*
     * Perform a reset of the VGA Driver.
     */
    task reset();
        reset_n = 1'b0;
        #10;
        reset_n = 1'b1;
    endtask

    /*
     * Simulate one pixel and verify that color outputs of the module match what
     * is expected.
     *
     * colorState: `COLOR_ON if the simulated pixel should output color (i.e.
     *             during a display interval). `COLOR_OFF if no color should be
     *             outputted (i.e. during a blanking interval).
     */
    task validatePixel(input bit colorState);

        if (colorState) begin
            assertColorOn();
        end
        else begin
            assertColorOff(); 
        end

        // Delay for one period of the 25 MHz clock to advance to the next pixel
        #4;

    endtask

    /*
     * Simulate an entire horizontal line (800 pixels).  Assert correct
     * behavior of `hysnc` as well as the `red_display`, `green_display`, and
     * `blue_display` signals.
     *
     * colorState: `COLOR_ON if the simulated line should output color (i.e.
     *             during a display interval). `COLOR_OFF if no color should be
     *             outputted (i.e. during a blanking interval).
     */
    task validateLine(input bit colorState);

        for (int i = 0; i < `H_PULSE_WIDTH; ++i) begin
            assertHsyncLow();
			validatePixel(`COLOR_OFF);
        end

        for (int i = 0; i < `H_BACK_PORCH; ++i) begin
            /* TODO */
				assertHsyncHigh();
				validatePixel(`COLOR_OFF);
        end

        for (int i = 0; i < `H_DISPLAY_LEN; ++i) begin
            /* TODO */
				assertHsyncHigh();
				validatePixel(colorState);
        end

        for (int i = 0; i < `H_FRONT_PORCH; ++i) begin
            /* TODO */
				assertHsyncHigh();
				validatePixel(`COLOR_OFF);
        end

    endtask

    /*
     * Simulate an entire frame (525 lines).  Assert correct behavior of
     * `vysnc` as well as the `red_display`, `green_display`, and `blue_display`
     * signals.
     */
    task validateFrame();

        for (int i = 0; i < `V_PULSE_WIDTH; ++i) begin
            assertVsyncLow();
				validateLine(`COLOR_OFF);
        end

        for (int i = 0; i < `V_BACK_PORCH; ++i) begin
            /* TODO */
				assertVsyncHigh();
				validateLine(`COLOR_OFF);
        end

        for (int i = 0; i < `V_DISPLAY_LEN; ++i) begin
            /* TODO */
				assertVsyncHigh();
				validateLine(`COLOR_ON);
        end

        for (int i = 0; i < `V_FRONT_PORCH; ++i) begin
            /* TODO */
				assertVsyncHigh();
				validateLine(`COLOR_OFF);
        end

    endtask

    /*
     * Test the VGA driver by performing a reset and then testing module outputs
     * for two full frames.
     */
    initial begin
        $display("=== Start of Simulation ===");

        reset();
        validateFrame();
        validateFrame();

        $display("=== End of Simulation ===");
        $stop();
    end

endmodule

