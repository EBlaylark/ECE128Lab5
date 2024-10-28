`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/15/2024 01:56:00 PM
// Design Name: 
// Module Name: display_driver_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module display_driver_tb;

    // Inputs
    reg clk;
    reg [15:0] bcd_in;

    // Outputs
    wire [3:0] sseg_a_o;
    wire [6:0] sseg_c_o;

    // Instantiate the Unit Under Test (UUT)
    display_driver uut (
        .clk(clk), 
        .bcd_in(bcd_in), 
        .sseg_a_o(sseg_a_o), 
        .sseg_c_o(sseg_c_o)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // 100MHz clock with 10ns period
    end

    // Test sequence
    initial begin
        // Initialize Inputs
        bcd_in = 16'h0000;

        // Wait for global reset to finish
        #100;

        // Apply test cases
        bcd_in = 16'h1234; 
        #1280;

        bcd_in = 16'h5678; // Test BCD input 5678
        #1280;

        bcd_in = 16'h9999; // Test BCD input 9999
        #1280;

        bcd_in = 16'h0000; // Test BCD input 0000
        #1280;

        // Add additional test cases as needed
        #1280;

        // End simulation
        $stop;
    end

endmodule