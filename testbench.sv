module modulator_tb;

  // Parameters (adjust based on your module)
  parameter DATA_WIDTH_RE = 4;
  parameter DATA_WIDTH_IM = 4;
  parameter QAM_WIDTH = 4;
  parameter WAVE_WIDTH = 16;
  parameter OUT_DATA_WIDTH = QAM_WIDTH + WAVE_WIDTH + 1;

  // Inputs
  reg clk;
  reg reset;
  reg [QAM_WIDTH-1:0] data_in;

  // Output
  wire [OUT_DATA_WIDTH-1:0] qam_symbol;

  // DUT instantiation
  modulator DUT (
    .clk(clk),
    .reset(reset),
    .data_in(data_in),
    .qam_symbol(qam_symbol)
  );

  // Clock generation
  always begin
    #5 clk = ~clk;
  end

  // Stimulus generation
  initial begin
    // Reset for 10 clock cycles
    clk = 0;
    reset = 1'b1;
    #10 reset = 1'b0;
    
    // Apply various data inputs (adjust based on your needs)
    for (int i = 0; i < 2**QAM_WIDTH; i = i + 1) begin
      data_in = i;
      #10000;
    end

    // Run simulation for a longer period (adjust as needed)
    #100000;
    $finish;
  end


endmodule
