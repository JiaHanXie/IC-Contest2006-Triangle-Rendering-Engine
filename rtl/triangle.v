`include "MEM.v"
`include "PE.v"
`include "CTL.v"
module triangle (clk, reset, nt, xi, yi, busy, po, xo, yo);
   input clk, reset, nt;
   input [2:0] xi, yi;
   output wire			busy, po;
   output wire	[2:0] 	xo, yo;
///////////////////////// var ///////////////////////////////
	wire	[2:0]	enable;
	wire	[5:0]	P1;
	wire	[5:0]	P2;
	wire	[5:0]	P3;
	wire			flag;
///////////////////////// module ////////////////////////////
	MEM MEM(
		.clk(clk),
		.rst(reset),
		.Xi(xi),
		.Yi(yi),
		.enable(enable),
		.P1(P1),
		.P2(P2),
		.P3(P3)
		);

	PE PE(
		.P1(P1),
		.P2(P2),
		.P3(P3),
		.X_Test(xo),
		.Y_Test(yo),
		.Flag(flag),
		.po(po)
		);

	CTL CTL(
		.clk(clk),
		.rst(reset),
		.nt(nt),
		.X1(P1[2:0]),
		.Y1(P1[5:3]),
		.X2(P2[2:0]),
		.Y3(P3[5:3]),
		.busy(busy),
		.X_Test(xo),
		.Y_Test(yo),
		.enable4mem(enable),
		.flag(flag)
		);

endmodule