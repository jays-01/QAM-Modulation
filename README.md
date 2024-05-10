# Modulator Verilog Module

This repository contains a Verilog module for a modulator designed for digital signal processing applications. The modulator is implemented in Verilog hardware description language (HDL) and can be synthesized and implemented on FPGA platforms.

## Contents

- [Introduction](#introduction)
- [Features](#features)
- [Usage](#usage)
- [File Structure](#file-structure)
- [License](#license)

## Introduction

The modulator module is designed to perform modulation of digital data inputs into a complex waveform suitable for transmission over a communication channel. It utilizes a carrier wave generator to produce sine and cosine waveforms, and a QAM16 mapper to map input digital data to the complex plane.

## Features

- Generates QAM (Quadrature Amplitude Modulation) symbols based on input digital data.
- Supports configurable data width for real and imaginary parts.
- Utilizes a carrier wave generator module to produce sine and cosine waves.
- Compatible with FPGA synthesis tools.

## Usage

To use the modulator module in your Verilog design, follow these steps:

1. Copy the `modulator.sv` file into your Verilog project directory.
2. Instantiate the `modulator` module in your Verilog code, providing appropriate parameters and connecting input and output signals.
3. Ensure that you also include the necessary modules (`carrier_wave_generator` and `qam16_mapper`) in your project.

Example instantiation in Verilog:

```verilog
modulator modulator_instance (
    .clk(clk),
    .reset(reset),
    .data_in(data_in),
    .qam_symbol(qam_symbol)
);

```

## File Structure

- `modulator.sv` : Verilog source code for the modulator module.
- `carrier_wave_generator.sv`:  Verilog source code for the carrier wave generator module.
- `qam16_mapper.sv` : Verilog source code for the QAM16 mapper module.

## License

This project is licensed under the MIT License.

