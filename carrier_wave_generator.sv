module carrier_wave_generator #(
    parameter WAVE_WIDTH = 16,  // Width of the output data (signed)
    parameter WAVE_WIDTH_F = 14, // Fractional part width of the output data (signed)
    parameter ADDRESS_WIDTH = 10,  // Width of the address counter [log(LUT_DEPTH) to the base 2]
    parameter LUT_DEPTH = 100      // Depth of the sine and cosine lookup tables
)(
    input wire clk,                 // Clock signal
    input reset,                   // Reset signal (active high)
    output reg signed [WAVE_WIDTH-1:0] sine_wave, // Output sine wave (signed)
    output reg signed [WAVE_WIDTH-1:0] cosine_wave  // Output cosine wave (signed)
);

// Internal signal
reg [ADDRESS_WIDTH-1:0] addr_counter;  // Address counter for the lookup tables

// Lookup tables (pre-calculated sine and cosine values)
reg signed [WAVE_WIDTH-1:0] sine_lut [0:LUT_DEPTH-1];  // Signed sine lookup table
reg signed [WAVE_WIDTH-1:0] cosine_lut [0:LUT_DEPTH-1]; // Signed cosine lookup table

// **Initialization of Lookup Tables (Not synthesizable)**
initial begin
    $readmemb("sine_lut.txt", sine_lut); // Initialize sine lookup table from file
    $readmemb("cosine_lut.txt", cosine_lut); // Initialize cosine lookup table from file
end

// Address counter update logic
always @(posedge clk) begin
    if ((addr_counter == LUT_DEPTH-1) || (addr_counter > LUT_DEPTH-1) || reset) begin
        addr_counter <= 'd0;  // Reset address counter on reset or reaching LUT end
    end
    else if (~reset) begin
        addr_counter <= addr_counter + 'd1;  // Increment address counter
    end
end

// Output assignments
assign sine_wave = reset ? 'd0 : sine_lut[addr_counter]; // Output sine value based on address
assign cosine_wave = reset ? 'd0 : cosine_lut[addr_counter]; // Output cosine value based on address

endmodule
