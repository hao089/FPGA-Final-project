module test1(output reg [7:0]position_R, position_B, position_G, output reg [2:0]S,output reg touch, beep, input CLK, Clear, right, left, output reg [7:0]b,output reg [2:0]HP,input start,input diff1,diff2);
	wire [7:0]p1;
	wire [2:0]S1;
	wire [7:0]p2;	
	wire [2:0]S2;
	wire [7:0]p3;	
	wire [2:0]S3;
	wire [7:0]p4;
	wire [2:0]s4;
	reg [1:0] count;
	reg [3:0] count2;
   reg [3:0]s;
	reg [0:3]a;
	reg x;
	reg [4:0] score;
	reg [2:0]hp;
	reg [3:0]A_count,B_count;
	divfreq C1(CLK, CLK_div);
	divfreq2 C2(CLK, CLK_div2);
	divfreq3 C3(CLK, CLK_div3);
	divfreq4 C4(CLK,diff1,diff2, CLK_div4);
	divfreq5 C5(CLK, CLK_div5);
	divfreq6 C6(CLK, CLK_div6);
	divfreq8 C8(CLK, CLK_div8);
	moveobject M1(CLK_div, Clear, right, left,start, p1, S1);	
   fallingobject F1(CLK_div2, CLK_div5, Clear,start, p2, S2,get1);
	fallingobject2 F2(CLK_div4, CLK_div6, Clear,start, p3, S3,get2);
	fallingobject3 F3(CLK_div2, CLK_div8, Clear,start, p4, S4,get3);
   initial 
	begin
    beep = 0;		
	 touch = 0;
	 b = 8'b1000000;
	 s=0;
    hp=3;
	 x=1;
	 HP=3'b111;
	end
/*撞到黃色加分*/
	always@(posedge touch,posedge Clear)
		begin
		   if(Clear)
			 score<=0;
		   else if(score<=10&&S1==S2)
		     score<=score+1;
			else if(score<=10&&S1==((S2%8)*2)%8)
			  score<=score+2;
		end
			
/*撞到藍色扣血*/
	always@(posedge touch,posedge Clear)
		begin
			if(Clear)
				begin
					hp<=3;
				end
			else if(hp<=3&&S1==S3)
				hp<=hp-1;
		end
/*掉落物與移動物的位置*/
	always@(posedge CLK_div3,posedge Clear)
	begin
	   if(Clear)
		begin
			count <= count+1;
			b<=8'b1000000;
			if(count>2)
				count<=0;
			if(count==0)/*移動物*/
				begin
					position_R<=p1;
					position_G<=8'b11111111;
					position_B<=p1;
					S<=S1;		
				end
			else if(count==1)/*掉落物1*/
				begin
						position_R<=~p2;
						position_G<=~p2;
						position_B<=8'b11111111;
						S<=S2;
						if(get1)
							s<= s+1;
						
				end
			else if(count==2)/*掉落物2*/
					 begin
						position_R<=~p3;
						position_B<=8'b11111111;
						position_G<=8'b11111111;
						S<=S3;
						if(get2)
							s<=s+1;
					 end
			else if(count==3)/*掉落物3*/
					 begin
						position_R<=8'b11111111;
						position_B<=~p4;
						position_G<=8'b11111111;
						S<=((S2%8)*2)%8;
						if(get3)
							s<=s+1;
					 end
			
		end
		else if(score<10&&hp>0)
		begin
			count <= count+1;
			
			if(count>2)
				count<=0;
			if(count==0)/*移動物*/
				begin
					position_R<=p1;
					position_G<=8'b11111111;
					position_B<=p1;
					S<=S1;		
				end
			else if(count==1)/*掉落物1*/
				begin
						position_R<=~p2;
						position_G<=~p2;
						position_B<=8'b11111111;
						S<=S2;
						if(get1)
							s<= s+1;
						
				end
			else if(count==2)/*掉落物2*/
					 begin
						position_R<=~p3;
						position_B<=8'b11111111;
						position_G<=8'b11111111;
						S<=S3;
						if(get2)
							s<=s+1;
					 end
			else if(count==3)/*掉落物3*/
					 begin
						position_R<=8'b11111111;
						position_B<=~p4;
						position_G<=8'b11111111;
						S<=((S2%8)*2)%8;
						if(get3)
							s<=s+1;
					 end
					 
			if(((p1==((~p2)+2'b11))&&(S1==S2))||((p1==((~p3)-1'b1))&&(S1==S3))||((p1==((~p4)-1'b1))&&(S1==((S2%8)*2)%8)))
				begin
					beep <=1;
					touch <=1;
				end	
			else 
				begin
					beep<=0;
					touch<=0;
				end
			if(hp==3)
			  HP<=3'b111;
			else if(hp==2)
			  HP<=3'b110;
			else if(hp==1)
			  HP<=3'b100;	
			if(score==0)
			  b<=8'b1000000;
			if(score==1)
			  b<=8'b1111001;
			else if(score==2)
			  b<=8'b0100100;
			else if(score==3)
			  b<=8'b0110000;
			else if(score==4)
			  b<=8'b0011001;
			else if(score==5)
			  b<=8'b0010010;
			else if(score==6)
			  b<=8'b0000010;
			else if(score==7)
			  b<=8'b1011000;
			else if(score==8)
			  b<=8'b0000000;
			else if(score==9)
			  b<=8'b0010000;
		end
		else if(score==10||score>10)	//顯示勝利
			begin
				beep<=0;
				count2 <= count2+1;
				b<=8'b0001000;
				if(count2>7)
					count2<=0;
				if(count2==0)
					begin
						position_R<=8'b00000000;
						position_G<=8'b00000000;
						position_B<=8'b00000000;
						S<=0;		
					end
				else if(count2==1)
					begin
						position_R<=8'b00000000;
						position_G<=8'b11111111;
						position_B<=8'b11111111;
						S<=1;
						
					end
				else if(count2==2)
					begin
						position_R<=8'b00000000;
						position_G<=8'b00000000;
						position_B<=8'b11111111;
						S<=2;
					end
				else if(count2==3)
					begin
						position_R<=8'b11111111;
						position_G<=8'b00000000;
						position_B<=8'b11111111;
						S<=3;
					end
				else if(count2==4)
					begin
						position_R<=8'b11111111;
						position_G<=8'b00000000;
						position_B<=8'b00000000;
						S<=4;
					end
				else if(count2==5)
					begin
						position_R<=8'b11111111;
						position_G<=8'b11111111;
						position_B<=8'b00000000;
						S<=5;
					end
				else if(count2==6)
					begin
						position_R<=8'b00000000;
						position_G<=8'b11111111;
						position_B<=8'b00000000;
						S<=6;
					end
				else if(count2==7)
					begin
						position_R<=8'b00000000;
						position_G<=8'b00000000;
						position_B<=8'b00000000;
						S<=7;
					end
			end	
		else if(hp==0)	//顯示失敗
			begin
				beep<=0;
				count2 <= count2+1;
				HP<=3'b000;
				if(count2>7)
					count2<=0;
				if(count2==0)
					begin
						position_R<=8'b00000000;
						position_G<=8'b11111111;
						position_B<=8'b11111111;
						S<=0;		
					end
				else if(count2==1)
					begin
						position_R<=8'b01101110;
						position_G<=8'b11111111;
						position_B<=8'b11111111;
						S<=1;
						
					end
				else if(count2==2)
					begin
						position_R<=8'b01101110;
						position_G<=8'b11111111;
						position_B<=8'b11111111;
						S<=2;
					end
				else if(count2==3)
					begin
						position_R<=8'b00000000;
						position_G<=8'b11111111;
						position_B<=8'b11111111;
						S<=3;
					end
				else if(count2==4)
					begin
						position_R<=8'b11111111;
						position_G<=8'b11111111;
						position_B<=8'b00000000;
						S<=4;
					end
				else if(count2==5)
					begin
						position_R<=8'b11111111;
						position_G<=8'b11111111;
						position_B<=8'b01101110;
						S<=5;
					end
				else if(count2==6)
					begin
						position_R<=8'b11111111;
						position_G<=8'b11111111;
						position_B<=8'b01101110;
						S<=6;
					end
				else if(count2==7)
					begin
						position_R<=8'b11111111;
						position_G<=8'b11111111;
						position_B<=8'b00000000;
						S<=7;
					end	
			end
		
		
end

endmodule

/*移動物*/
module moveobject(input CLK_div, Clear, right, left,start, output reg [7:0]position, output reg [2:0]S); 
	always@(posedge CLK_div, posedge Clear)
		begin
			if(Clear)	//重置
				begin
					S<=4;
					position<=~(8'b00000011);
				end
			else if(start==1)
				begin
					if(left)
						begin
							if(S==0)	//邊
								begin
									S<=S;
									position<=~(8'b00000011);
								end
							else
								begin
									S<=S-1;
									position<=~(8'b00000011);
								end
						end
					else if(right)
						begin	
							if(S==7)	//邊
								begin
									S<=S;
									position<=~(8'b00000011);
								end
							else
								begin
									S<=S+1;
									position<=~(8'b00000011);
								end
						end
					end
			else 
				begin
					S<=S;
					position<=~(8'b00000011);
				end	
		end
endmodule

/*掉落物1*/
module fallingobject(input CLK_div2, CLK_div5, Clear,start, output reg [7:0]position, output reg [2:0]SS,output reg get);
	reg[24:0]cnt;
   reg restart;

	always @(posedge CLK_div5) 
		begin
				if(cnt > 250000)
					cnt <= 25'd0; 		

				else
					cnt <= cnt + 1'b1;
		end
	initial
	begin
		position = 8'b11000000;
		SS =cnt%8;
      restart = 0;
		get=0;
	end	
	always @(posedge CLK_div2)
		begin
			if(start==1)
				begin
				if(restart)
					begin
						position <= 8'b11000000;	
						SS <=cnt%8;
						restart = 0;
					end
			   else
					begin
						position = position >> 1;
						if(position == 8'b00000000)
						begin
							restart = 1;
							get =1;
						end
					end
				end
			else
				begin
					SS<=SS;
					position<=position;
				end
		end

endmodule

/*掉落物2*/
module fallingobject2(input CLK_div4, CLK_div6, Clear,start, output reg [7:0]position, output reg [2:0]SS,output reg get);
	reg[24:0]cnt;
	reg restart;
	always @(posedge CLK_div6) 
		begin
			if(cnt > 250000)
				cnt <= 25'd0; 		
			else
				cnt <= cnt + 1'b1;	  
		end 	
		
	initial
	begin
		position = 8'b10000000;
		SS =cnt%8;
      restart = 0;
		get=0;
	end		
	always @(posedge CLK_div4)
		begin
			if(start==1)
				begin
				if(restart)
				begin
					position <= 8'b10000000;	
					SS <=cnt%8;
					restart = 0;
				end
			else 
				begin
					position = position >> 1;
					if(position == 8'b00000000)
					begin
						restart = 1;
						get = 1;
					end
				end
			end
		else
			begin
				SS<=SS;
				position<=position;
			end
		end
endmodule

/*掉落物3*/
module fallingobject3(input CLK_div2, CLK_div8, Clear,start, output reg [7:0]position, output reg [2:0]SS,output reg get);
	reg[24:0]cnt;
	reg restart;
	always @(posedge CLK_div8) 
		begin
			if(cnt > 250000)
				cnt <= 25'd0; 		
			else
				cnt <= cnt + 1'b1;	  
		end 	
		
	initial
	begin
		position = 8'b10000000;
		SS =cnt%8;
      restart = 0;
		get=0;
	end		
	always @(posedge CLK_div2)
		begin
			if(start==1)
				begin
				if(restart)
				begin
					position <= 8'b10000000;	
					SS <=cnt%8;
					restart = 0;
				end
			else 
				begin
					position = position >> 1;
					if(position == 8'b00000000)
					begin
						restart = 1;
						get = 1;
					end
				end
			end
		else
			begin
				SS<=SS;
				position<=position;
			end
		end	
endmodule
/*移動物的除頻器*/
module divfreq(input CLK, output reg CLK_div); 
	reg [24:0] Count; 
	always @(posedge CLK) 
		begin 
			if(Count > 3000000) 
				begin 
					Count <= 20'b0; CLK_div <= ~CLK_div; 
				end 
			else 
				Count <= Count + 1'b1; 	
		end 
endmodule 

/*掉落物1的除頻器*/
module divfreq2(input CLK, output reg CLK_div);
	reg [24:0] Count; 
	always @(posedge CLK) 
		begin 
			if(Count > 2500000) 
				begin 
					Count <= 25'b0; CLK_div <= ~CLK_div; 
				end 
			else 
				Count <= Count + 1'b1; 
		end 
endmodule 

/*移動物和掉落物交替的除頻器*/
module divfreq3(input CLK, output reg CLK_div); 
	reg [24:0] Count; 
	always @(posedge CLK) 
		begin 
			if(Count > 10000) 
				begin 
					Count <= 25'b0; CLK_div <= ~CLK_div; 
				end 
			else 
				Count <= Count + 1'b1; 
		end 
endmodule 

/*掉落物2的除頻器---------------------難度調整*/
module divfreq4(input CLK,diff1,diff2, output reg CLK_div); 
reg [24:0] Count; 
always @(posedge CLK) 
begin 
	if (diff1==1&&diff2==0)
	begin
	if(Count > 2000000) 
	begin 
		Count <= 25'b0; CLK_div <= ~CLK_div; 
	end 
	else 
		Count <= Count + 1'b1; 
end 
else if(diff1==0&&diff2==1)
begin
	if(Count > 1500000) 
	begin 
		Count <= 25'b0; CLK_div <= ~CLK_div; 
	end 
	else 
		Count <= Count + 1'b1; 
end 
else if(diff1==1&&diff2==1)
begin
	if(Count > 1000000) 
	begin 
		Count <= 25'b0; CLK_div <= ~CLK_div; 
	end 
	else 
		Count <= Count + 1'b1; 
end 
else
begin
	if(Count > 2500000) 
	begin 
		Count <= 25'b0; CLK_div <= ~CLK_div; 
	end 
	else 
		Count <= Count + 1'b1; 
end 
end

endmodule 

/*隨機掉落物1的生成位置*/
module divfreq5(input CLK, output reg CLK_div); 
reg [24:0] Count; 
always @(posedge CLK) 
begin 
	if(Count > 123456) 
	begin 
		Count <= 25'b0; CLK_div <= ~CLK_div; 
	end 
	else 
		Count <= Count + 1'b1; 
end 
endmodule 

/*掉落物2的生成位置*/
module divfreq6(input CLK, output reg CLK_div); 
reg [24:0] Count; 
always @(posedge CLK) 
begin 
	if(Count > 654321) 
	begin 
		Count <= 25'b0; CLK_div <= ~CLK_div; 
	end 
	else 
		Count <= Count + 1'b1; 
end 
endmodule 

/*掉落物3的生成位置*/
module divfreq8(input CLK, output reg CLK_div); 
reg [24:0] Count; 
always @(posedge CLK) 
begin 
	if(Count > 355555) 
	begin 
		Count <= 25'b0; CLK_div <= ~CLK_div; 
	end 
	else 
		Count <= Count + 1'b1; 
end 
endmodule 