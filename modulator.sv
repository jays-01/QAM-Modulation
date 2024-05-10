module modulator #(
    parameter DATA_WIDTH_RE = 4,  // Width of real data input
    parameter DATA_WIDTH_IM = 4,  // Width of imaginary data input
    parameter QAM_WIDTH = 4,      // Number of bits for QAM symbol
    parameter WAVE_WIDTH = 16,     // Width of sine and cosine waves
    parameter OUT_DATA_WIDTH = QAM_WIDTH + WAVE_WIDTH + 1  // Output width
)(
    input clk,                     // Clock signal
    input reset,                   // Reset signal
    input [QAM_WIDTH-1:0] data_in,   // Input data for QAM symbol
    output reg [OUT_DATA_WIDTH-1:0] qam_symbol   // Output QAM symbol
);

    // **Internal signal declarations**

    reg signed [DATA_WIDTH_IM-1:0] sin_amp;  // Signed amplitude for sine wave
    reg signed [DATA_WIDTH_RE-1:0] cos_amp;  // Signed amplitude for cosine wave
    reg signed [WAVE_WIDTH-1:0] sine_wave;  // Sine wave data
    reg signed [WAVE_WIDTH-1:0] cosine_wave; // Cosine wave data
    reg signed [WAVE_WIDTH+QAM_WIDTH-1:0] sine_temp; // Temporary variable for sine product
    reg signed [WAVE_WIDTH+QAM_WIDTH-1:0] cos_temp; // Temporary variable for cosine product

    // Instantiate carrier wave generator

    carrier_wave_generator carrier_waves (
        .clk(clk),
        .reset(reset),
        .sine_wave(sine_wave),
        .cosine_wave(cosine_wave)
    );

    // Instantiate QAM16 mapper

    qam16_mapper mapper (.bits_in(data_in),
                         .bits_out_re(cos_amp),
                         .bits_out_im(sin_amp));

    // **Calculate QAM symbol components**

    assign cos_temp = cos_amp * cosine_wave;  // Multiply cosine amplitude with cosine wave
    assign sine_temp = sine_wave * sin_amp;    // Multiply sine amplitude with sine wave

    // **Combine components and assign to output**

    assign qam_symbol = cos_temp + sine_temp;  // Combine cosine and sine products for QAM symbol

endmodule
