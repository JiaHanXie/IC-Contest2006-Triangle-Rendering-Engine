`include "FSM.v"
`include "Counter.v"
module CTL(
		input					clk,
		input					rst,
		input					nt,
		input			[2:0]	X1,
		input			[2:0]	Y1,
		input			[2:0]	X2,
		input			[2:0]	Y3,
		output	wire			busy,
		output	wire	[2:0]	X_Test,
		output	wire	[2:0]	Y_Test,
		output	wire	[2:0]	enable4mem,
		output	wire			flag
		);
///////////////////////// var ///////////////////////////////
	wire	run;
	wire	finish;
///////////////////////// module ////////////////////////////
	FSM FSM(
		.clk(clk),
		.rst(rst),
		.nt(nt),
		.busy(busy),
		.enable4mem(enable4mem),
		.flag4pe(flag),
		.run(run),
		.finish(finish)
		);

	Counter Counter(
		.clk(clk),
		.rst(rst),
		.X1(X1),
		.X2(X2),
		.Y1(Y1),
		.Y3(Y3),
		.run(run),
		.X_Test(X_Test),
		.Y_Test(Y_Test),
		.finish(finish)
		);

endmodule