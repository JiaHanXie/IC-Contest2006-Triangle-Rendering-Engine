module Counter(
		input 					clk,
		input 					rst,
		input 			[2:0]	X1,
		input 			[2:0]	X2,
		input 			[2:0]	Y1,
		input 			[2:0]	Y3,
		input 					run,
		output	reg		[2:0]	X_Test,
		output	reg		[2:0]	Y_Test,
		output	wire			finish
		);
///////////////////////// var ///////////////////////////////
	reg		[2:0]	next_X_Test;
	reg		[2:0]	next_Y_Test;
	wire	[2:0]	X_begin;
	wire	[2:0]	X_end;
	wire	[2:0]	Y_begin;
	wire	[2:0]	Y_end;
	wire			LR;//0: X1>=X2; 1: X1<X2
	wire			notpo;
///////////////////////// assign ////////////////////////////
	assign	LR=(X2>X1);
	assign	X_begin=(LR)?X1:X2;
	assign	X_end=(LR)?X2:X1;
	assign	Y_begin=Y1;
	assign	Y_end=Y3;
	assign	finish=((X_Test==X1)&&(Y_Test==Y3))?1'b1:1'b0;
///////////////////////// counter ///////////////////////////
	always@(posedge clk or posedge rst)begin
		if(rst)begin
			X_Test<=3'd0;
		end else if(run)begin
			X_Test<=next_X_Test;
		end else begin
			X_Test<=X_begin;
		end

	end
	
	always@(posedge clk or posedge rst)begin
		if(rst)begin
			Y_Test<=3'd0;
		end else if(run)begin
			Y_Test<=next_Y_Test;
		end else begin
			Y_Test<=Y_begin;
		end
	end

	always@(*)begin
		if((X_Test==X_end)&&(Y_Test==Y_end))begin
			next_X_Test=X_Test;
		end else if((X_Test==X_end))begin
			next_X_Test=X_begin;
		end else begin
			next_X_Test=X_Test+3'd1;
		end
	end

	always@(*)begin
		if((X_Test==X_end)&&(Y_Test==Y_end))begin
			next_Y_Test=Y_Test;
		end else if((X_Test==X_end))begin
			next_Y_Test=Y_Test+3'd1;
		end else begin
			next_Y_Test=Y_Test;
		end
	end

endmodule