`timescale 1ns / 1ps
module test_unit(
input 		rst,
input		clk,
input 		toggle_change,
output	reg 	data_o
    );

reg	[3:0]	counter;
reg	[31:0]	data_shift;
(* shreg_extract = "no" *) reg	[319:0]	data_pipe ;
reg	[31:0]	data_ram [511:0];
reg	[8:0]	addr;
reg	[31:0]	rd_data;

		
always @ (posedge clk or posedge rst)
	if (rst)
		data_shift	<=0;
	else
		data_shift	<={data_shift[30:0],toggle_change};

//generated logic for LUT and FF consumption
always @ (posedge clk)
    begin
        data_pipe[31 :0  ]      <= data_shift;
        data_pipe[63 :32 ]      <= data_pipe[31 :0  ] ^ data_shift;
        data_pipe[95 :64 ]      <= data_pipe[63 :32 ] ^ data_pipe[31 :0  ];
	data_pipe[127:96 ]      <= data_pipe[95 :64 ] ^ data_pipe[63 :32 ];
	data_pipe[159:128]      <= data_pipe[127:96 ] ^ data_pipe[95 :64 ];
	data_pipe[191:160]      <= data_pipe[159:128] ^ data_pipe[127:96 ];
	data_pipe[223:192]      <= data_pipe[191:160] ^ data_pipe[159:128];
	data_pipe[255:224]      <= data_pipe[223:192] ^ data_pipe[191:160];
	data_pipe[287:256]      <= data_pipe[255:224] ^ data_pipe[223:192];
	data_pipe[319:288]      <= data_pipe[287:256] ^ data_pipe[255:224];
	end	


always @ (posedge clk or posedge rst)
	if (rst)
		addr	<=0;
	else
		addr	<=addr + 1'b1;
		
//generated BRAM consumption
always @ (posedge clk )
	begin
//	data_ram[addr]	<=data_pipe[511:480];
//      12x32 register
//      data_ram[addr]	<=data_pipe[383:352];
//      10x32 register
        data_ram[addr]	<=data_pipe[319:288];

	rd_data		<=data_ram[addr];
	end

always @ (posedge clk or posedge rst)
	if (rst)
		data_o	<=0;
	else
		data_o	<=^rd_data;
		
		

endmodule
