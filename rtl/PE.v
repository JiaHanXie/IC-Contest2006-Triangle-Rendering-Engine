module PE(
		input			[5:0]	P1,
		input			[5:0]	P2,
		input			[5:0]	P3,
		input			[2:0]	X_Test,
		input			[2:0]	Y_Test,
		input					Flag,
		output	wire			po
		);
///////////////////////// var ///////////////////////////////
	wire			LR;//0: X1>=X2; 1: X1<X2

	wire	[3:0]	y0y2;
	wire	[3:0]	x3x2;
	wire	[3:0]	y3y2;
	wire	[3:0]	x0x2;
	wire	[3:0]	y1y2;
	wire	[3:0]	x1x2;

	wire	[2:0]	M_y0y2;
	wire	[2:0]	M_x3x2;
	wire	[2:0]	M_y3y2;
	wire	[2:0]	M_x0x2;
	wire	[2:0]	M_y1y2;
	wire	[2:0]	M_x1x2;

	wire	[3:0]	SM_y0y2;
	wire	[3:0]	SM_x3x2;
	wire	[3:0]	SM_y3y2;
	wire	[3:0]	SM_x0x2;
	wire	[3:0]	SM_y1y2;
	wire	[3:0]	SM_x1x2;

	wire	[5:0]	MAG_A;
	wire	[5:0]	MAG_B;
	wire	[5:0]	MAG_C;
	wire	[5:0]	MAG_D;

	wire			SIGN_A;
	wire			SIGN_B;
	wire			SIGN_C;
	wire			SIGN_D;

	wire			MALTB;
	wire			MASTB;
	wire			MAETB;
	wire			MCLTD;
	wire			MCSTD;
	wire			MCETD;

	reg				ALTB;
	reg				ASTB;
	reg				AETB;
	reg				CLTD;
	reg				CSTD;
	reg				CETD;

	wire			po_;

///////////////////////// mainpart //////////////////////////

	assign	LR=(P2[2:0]>P1[2:0]);

	assign	y0y2=Y_Test-P2[5:3];//4
	assign	x3x2=P3[2:0]-P2[2:0];
	assign	y3y2=P3[5:3]-P2[5:3];
	assign	x0x2=X_Test-P2[2:0];
	assign	y1y2=P1[5:3]-P2[5:3];
	assign	x1x2=P1[2:0]-P2[2:0];

	assign  M_y0y2=(y0y2[3])?(~y0y2[2:0]+3'd1):y0y2[2:0];//3
	assign  M_x3x2=(x3x2[3])?(~x3x2[2:0]+3'd1):x3x2[2:0];
	assign  M_y3y2=(y3y2[3])?(~y3y2[2:0]+3'd1):y3y2[2:0];
	assign  M_x0x2=(x0x2[3])?(~x0x2[2:0]+3'd1):x0x2[2:0];
	assign  M_y1y2=(y1y2[3])?(~y1y2[2:0]+3'd1):y1y2[2:0];
	assign  M_x1x2=(x1x2[3])?(~x1x2[2:0]+3'd1):x1x2[2:0];

	assign	SM_y0y2={y0y2[3],M_y0y2};//4
	assign	SM_x3x2={x3x2[3],M_x3x2};
	assign	SM_y3y2={y3y2[3],M_y3y2};
	assign	SM_x0x2={x0x2[3],M_x0x2};
	assign	SM_y1y2={y1y2[3],M_y1y2};
	assign	SM_x1x2={x1x2[3],M_x1x2};
//Magnitude
	assign	MAG_A=SM_y0y2[2:0]*SM_x3x2[2:0];//6
	assign	MAG_B=SM_y3y2[2:0]*SM_x0x2[2:0];
	assign	MAG_C=SM_y1y2[2:0]*SM_x0x2[2:0];
	assign	MAG_D=SM_y0y2[2:0]*SM_x1x2[2:0];
//Sign
	assign	SIGN_A=SM_y0y2[3]^SM_x3x2[3];//1
	assign	SIGN_B=SM_y3y2[3]^SM_x0x2[3];
	assign	SIGN_C=SM_y1y2[3]^SM_x0x2[3];
	assign	SIGN_D=SM_y0y2[3]^SM_x1x2[3];
//
	assign	MALTB=(MAG_A>MAG_B);
	assign	MASTB=(MAG_A<MAG_B);
	assign	MAETB=(MAG_A==MAG_B);

	assign	MCLTD=(MAG_C>MAG_D);
	assign	MCSTD=(MAG_C<MAG_D);
	assign	MCETD=(MAG_C==MAG_D);

	always@(*)begin
		case({SIGN_A,SIGN_B})
			2'b00:begin
				ALTB=MALTB;
				ASTB=MASTB;
				AETB=MAETB;
			end
			2'b01:begin
				ALTB=1'b1;
				ASTB=1'b0;
				AETB=MAETB;
			end
			2'b10:begin
				ALTB=1'b0;
				ASTB=1'b1;
				AETB=MAETB;
			end
			2'b11:begin
				ALTB=~MALTB;
				ASTB=~MASTB;
				AETB=MAETB;
			end
			default:begin
				ALTB=1'bx;
				ASTB=1'bx;
				AETB=1'bx;
			end
		endcase
	end

	always@(*)begin
		case({SIGN_C,SIGN_D})
			2'b00:begin
				CLTD=MCLTD;
				CSTD=MCSTD;
				CETD=MCETD;
			end
			2'b01:begin
				CLTD=1'b1;
				CSTD=1'b0;
				CETD=MCETD;
			end
			2'b10:begin
				CLTD=1'b0;
				CSTD=1'b1;
				CETD=MCETD;
			end
			2'b11:begin
				CLTD=~MCLTD;
				CSTD=~MCSTD;
				CETD=MCETD;
			end
			default:begin
				CLTD=1'bx;
				CSTD=1'bx;
				CETD=1'bx;
			end
		endcase
	end

	assign	po_=((LR)?(ALTB|AETB):(ASTB|AETB))&((LR)?(CLTD|CETD):(CSTD|CETD));
	assign	po=(po_&Flag);

endmodule