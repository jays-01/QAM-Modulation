module qam16_mapper #(
    parameter QAM_WIDTH = 4,  // Width of the input data (number of bits)
    parameter DATA_WIDTH_RE = 4,  // Width of the real output data (signed)
    parameter DATA_WIDTH_IM = 4   // Width of the imaginary output data (signed)
)(
    input  [QAM_WIDTH-1:0] bits_in,  // Input data bits
    output reg [DATA_WIDTH_RE:0] bits_out_re,  // Real part of the QAM symbol (signed)
    output reg [DATA_WIDTH_IM:0] bits_out_im  // Imaginary part of the QAM symbol (signed)
);

  // Combinational logic for mapping data to real and imaginary parts
  always @(*) begin
    case (bits_in[3:2])  // Decode most significant 2 bits
        2'b00 : bits_out_re = 4'b1101;  //  -3
        2'b01 : bits_out_re = 4'b1111;  //  -1
        2'b11 : bits_out_re = 4'b0001;  //  +1
        2'b10 : bits_out_re = 4'b0011;  //  +3
        default : bits_out_re = 4'b0000;  // Default case (shouldn't happen)
    endcase

    case (bits_in[1:0])  // Decode least significant 2 bits
        2'b00 : bits_out_im = 4'b1101;  //  -3
        2'b01 : bits_out_im = 4'b1111;  //  -1
        2'b11 : bits_out_im = 4'b0001;  //  +1
        2'b10 : bits_out_im = 4'b0011;  //  +3
        default : bits_out_im = 4'b0000;  // Default case (shouldn't happen)
    endcase
  end
   
endmodule
