module AddressConverter(
	input logic [9:0] hsync_count,
	input logic [9:0] vsync_count,
	output logic [18:0] pixeladdress
);

always_comb begin
    if (hsync_count < 256 && vsync_count < 256)
        pixeladdress = (vsync_count * 256) + hsync_count;
    else
        pixeladdress = 19'd0;  // outside image bounds, address 0
end
endmodule