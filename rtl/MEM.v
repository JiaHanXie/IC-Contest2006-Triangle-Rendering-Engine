module MEM(
		input 				clk,
		input 				rst,
		input		[2:0]	Xi,
		input		[2:0]	Yi,
		input		[2:0]	enable,
		output	reg	[5:0]	P1,
		output	reg	[5:0]	P2,
		output	reg	[5:0]	P3
		);
///////////////////////// mem ///////////////////////////////
	always@(posedge clk or posedge rst)begin
		if(rst)begin
			P1<=6'd0;
		end else if(enable[0])begin
			P1<={Yi,Xi};
		end
	end

	always@(posedge clk or posedge rst)begin
		if(rst)begin
			P2<=6'd0;
		end else if(enable[1])begin
			P2<={Yi,Xi};
		end
	end

	always@(posedge clk or posedge rst)begin
		if(rst)begin
			P3<=6'd0;
		end else if(enable[2])begin
			P3<={Yi,Xi};
		end
	end

endmodule