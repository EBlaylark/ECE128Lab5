`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/15/2024 01:55:38 PM
// Design Name: 
// Module Name: display_driver
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


module display_driver(input clk,
 input [15:0] bcd_in,
 output [3:0] sseg_a_o,
 output [6:0] sseg_c_o);

parameter g_s = 5;
parameter gt = 4;

wire [6:0] sseg_o;
reg [3:0] anode = 4'b0001;
reg [3:0] bcd_seg = 4'b0000;
reg [g_s-1:0] g_count = 0;

// Removed clk from seven_seg instantiation
seven_seg uut1(clk, bcd_seg, sseg_o);

    always @(posedge clk)
    begin
    g_count = g_count + 1;
        if(g_count == 0)
            begin
            if(anode == 4'b0001)
                begin
                anode = 4'b1000;
                end   
            else 
                begin
                anode = anode >> 1;
                end
             end
                         
         if(&g_count[g_s-1:gt])
            begin
            case (anode) //case statement
                4'b1000: bcd_seg = bcd_in[15:12]; // Most significant digit
                4'b0100: bcd_seg = bcd_in[11:8];
                4'b0010: bcd_seg = bcd_in[7:4];
                4'b0001: bcd_seg = bcd_in[3:0]; // Least significant digit
                default: bcd_seg = 4'b1111; 
            endcase
         end 
         
         else 
            begin
            bcd_seg = 4'b1111; 
            end 
    end

assign sseg_a_o = ~anode;
assign sseg_c_o = sseg_o;
       
endmodule