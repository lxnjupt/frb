`timescale 1ns / 1ps
module top(
input 			rst, //active high
input			clk,
input 	[3:0]		toggle_change,
output 			data_o
);

parameter  SUB_MODULE = 2000;

reg	[SUB_MODULE:0]	 toggle_control;
wire	[SUB_MODULE:0]   data_out;
reg	[15:0]           counter;
wire 	          	 data_o;

always @ (posedge clk)
    counter <=counter + 1'b1;
    
    
always @ (posedge clk)
    case (toggle_change)
	4'b0000: toggle_control   <={toggle_control[SUB_MODULE-1:0],counter[0]};
        4'b0001: toggle_control   <={toggle_control[SUB_MODULE-1:0],counter[1]};
        4'b0010: toggle_control   <={toggle_control[SUB_MODULE-1:0],counter[2]};
        4'b0011: toggle_control   <={toggle_control[SUB_MODULE-1:0],counter[3]};
        4'b0100: toggle_control   <={toggle_control[SUB_MODULE-1:0],counter[4]};
        4'b0101: toggle_control   <={toggle_control[SUB_MODULE-1:0],counter[5]};
        4'b0110: toggle_control   <={toggle_control[SUB_MODULE-1:0],counter[6]};
        4'b0111: toggle_control   <={toggle_control[SUB_MODULE-1:0],counter[7]};
        4'b1000: toggle_control   <={toggle_control[SUB_MODULE-1:0],counter[8]};
        4'b1001: toggle_control   <={toggle_control[SUB_MODULE-1:0],counter[9]};
        4'b1010: toggle_control   <={toggle_control[SUB_MODULE-1:0],counter[10]};
        4'b1011: toggle_control   <={toggle_control[SUB_MODULE-1:0],counter[11]};
        4'b1100: toggle_control   <={toggle_control[SUB_MODULE-1:0],counter[12]};
        4'b1101: toggle_control   <={toggle_control[SUB_MODULE-1:0],counter[13]};
        4'b1110: toggle_control   <={toggle_control[SUB_MODULE-1:0],counter[14]};
        4'b1111: toggle_control   <={toggle_control[SUB_MODULE-1:0],counter[15]};
        default:toggle_control  <={toggle_control[SUB_MODULE-1:0],counter[15]};
     endcase

test_unit U_test_unit [SUB_MODULE:0] (
.rst		(rst		    ),
.clk            (clk                ),
.toggle_change  (toggle_control     ),
.data_o         (data_out           ));

assign data_o=^data_out[SUB_MODULE : 0];


endmodule
