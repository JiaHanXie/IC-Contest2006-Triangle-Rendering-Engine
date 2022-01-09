module FSM(
		input				clk,
		input				rst,
		input				nt,
		output	reg			busy,
		output	reg	[2:0]	enable4mem,
		output	wire		flag4pe,
		output	wire		run,
		input				finish
		);
///////////////////////// define state //////////////////////
	`define	RST_state		3'd0
	`define	NT_state		3'd1
	`define READ_state		3'd2
	`define	CALC_state		3'd3
	`define	FINISH_state	3'd4
///////////////////////// var ///////////////////////////////
	reg	[2:0]	state;
	reg	[2:0]	next_state;
	wire		AtCalc_state;
///////////////////////// state /////////////////////////////
	always@(posedge clk or posedge rst)begin
		if(rst)begin
			state<=3'd0;
		end else begin
			state<=next_state;
		end
	end

	always@(*)begin
		case(state)
			`RST_state:begin
				next_state=(nt)?`NT_state:state;
			end
			`NT_state:begin
				next_state=`READ_state;
			end
			`READ_state:begin
				next_state=`CALC_state;
			end
			`CALC_state:begin
				next_state=(finish)?`FINISH_state:state;
			end
			`FINISH_state:begin
				next_state=`RST_state;
			end
			default:begin
				next_state=state;
			end
		endcase
	end
//busy
	always@(*)begin
		if(state==`RST_state)begin
			busy=1'b0;
		end else begin
			busy=1'b1;
		end
	end
//enable4mem
	always@(*)begin
		case(state)
			`RST_state:begin
				enable4mem=3'b001;
			end
			`NT_state:begin
				enable4mem=3'b010;
			end
			`READ_state:begin
				enable4mem=3'b100;
			end
			default:begin
				enable4mem=3'b000;
			end
		endcase
	end
//flag4pe
	assign	AtCalc_state=(state==`CALC_state)?1'b1:1'b0;
	assign	flag4pe=AtCalc_state;
//run
	assign	run=AtCalc_state;

endmodule