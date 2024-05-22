module traffic (clk, Rst, Go, highway_signal1, highway_signal2, farm_signal1, farm_signal2);
	
	input clk, Rst, Go;
	output reg [1:0] highway_signal1, highway_signal2,farm_signal1, farm_signal2; 
	reg [3:0] current_state, next_state;
	reg [4:0] counter;
	
	parameter S0 = 4'b0000, S1 = 4'b0001, S2 = 4'b0010, S3 = 4'b0011, S4 = 4'b0100, S5 = 4'b0101, S6 = 4'b0110, S7 = 4'b0111,
				S8 = 4'b1000, S9 = 4'b1001, S10 = 4'b1010, S11 = 4'b1011, S12 = 4'b1100, S13 = 4'b1101, S14 = 4'b1110,
				S15 = 4'b1111, S16 = 4'b10000, S17 = 4'b10001;
	
	always @(posedge clk) begin
		if (Rst) begin
			current_state <= S0;
			counter <= 0;
		end 
		else if (Go) begin
			current_state <= next_state;
			counter <= counter + 1;
		end
	end
	
	always @(current_state, counter) begin
		case (current_state)
		S0: begin
		highway_signal1 <= 2'b10;
		highway_signal2 <= 2'b10;
		farm_signal1 <= 2'b10;
		farm_signal2 <= 2'b10;
		if (counter == 1) next_state <= S1;
		end
		S1: begin
		highway_signal1 <= 2'b11;
		highway_signal2 <= 2'b11;
		farm_signal1 <= 2'b10;
		farm_signal2 <= 2'b10;
		if (counter == 2) next_state <= S2;
		end
		S2: begin
		highway_signal1 <= 2'b00;
		highway_signal2 <= 2'b00;
		farm_signal1 <= 2'b10;
		farm_signal2 <= 2'b10;
		if (counter == 30) next_state <= S3;
		end
		S3: begin
		highway_signal1 <= 2'b00;
		highway_signal2 <= 2'b01;
		farm_signal1 <= 2'b10;
		farm_signal2 <= 2'b10;
		if (counter == 2) next_state <= S4;
		end
		S4: begin
		highway_signal1 <= 2'b00;
		highway_signal2 <= 2'b10;
		farm_signal1 <= 2'b10;
		farm_signal2 <= 2'b10;
		if (counter == 10) next_state <= S5;
		end
		S5: begin
		highway_signal1 <= 2'b01;
		highway_signal2 <= 2'b10;
		farm_signal1 <= 2'b10;
		farm_signal2 <= 2'b10;
		if (counter == 2) next_state <= S6;
		end
		S6: begin
		highway_signal1 <= 2'b10;
		highway_signal2 <= 2'b10;
		farm_signal1 <= 2'b10;
		farm_signal2 <= 2'b10;
		if (counter == 1) next_state <= S7;
		end
		S7: begin
		highway_signal1 <= 2'b10;
		highway_signal2 <= 2'b10;
		farm_signal1 <= 2'b11;
		farm_signal2 <= 2'b11;
		if (counter == 2) next_state <= S8;
		end
		S8: begin
		highway_signal1 <= 2'b10;
		highway_signal2 <= 2'b10;
		farm_signal1 <= 2'b00;
		farm_signal2 <= 2'b00;
		if (counter == 15) next_state <= S9;
		end
		S9: begin
		highway_signal1 <= 2'b10;
		highway_signal2 <= 2'b10;
		farm_signal1 <= 2'b00;
		farm_signal2 <= 2'b01;
		if (counter == 2) next_state <= S10;
		end
		S10: begin
		highway_signal1 <= 2'b10;
		highway_signal2 <= 2'b10;
		farm_signal1 <= 2'b00;
		farm_signal2 <= 2'b10;
		if (counter == 5) next_state <= S11;
		end
		S11: begin
		highway_signal1 <= 2'b10;
		highway_signal2 <= 2'b10;
		farm_signal1 <= 2'b01;
		farm_signal2 <= 2'b11;
		if (counter == 2) next_state <= S12;
		end
		S12: begin
		highway_signal1 <= 2'b10;
		highway_signal2 <= 2'b10;
		farm_signal1 <= 2'b10;
		farm_signal2 <= 2'b00;
		if (counter == 10) next_state <= S13;
		end
		S13: begin
		highway_signal1 <= 2'b10;
		highway_signal2 <= 2'b10;
		farm_signal1 <= 2'b10;
		farm_signal2 <= 2'b01;
		if (counter == 2) next_state <= S14;
		end
		S14: begin
		highway_signal1 <= 2'b10;
		highway_signal2 <= 2'b10;
		farm_signal1 <= 2'b10;
		farm_signal2 <= 2'b10;
		if (counter == 1) next_state <= S15;
		end
		S15: begin
		highway_signal1 <= 2'b10;
		highway_signal2 <= 2'b11;
		farm_signal1 <= 2'b10;
		farm_signal2 <= 2'b10;
		if (counter == 2) next_state <= S16;
		end
		S16: begin
		highway_signal1 <= 2'b00;
		highway_signal2 <= 2'b10;
		farm_signal1 <= 2'b10;
		farm_signal2 <= 2'b10;
		if (counter == 15) next_state <= S17;
		end
		S17: begin
		highway_signal1 <= 2'b01;
		highway_signal2 <= 2'b10;
		farm_signal1 <= 2'b10;
		farm_signal2 <= 2'b10;
		if (counter == 3) next_state <= S0;
		end
		endcase
	end

endmodule

module traffic_tb;

	reg clk, Rst, Go;
	wire [1:0] highway_signal1, highway_signal2, farm_signal1, farm_signal2;

	traffic dut (clk, Rst, Go, highway_signal1, highway_signal2, farm_signal1, farm_signal2);
	
	always #5 clk = ~clk;
	initial begin
		clk = 0;
		Rst = 1;
		Go = 1;
		#30 Rst = 0;
	end
	
	initial begin
		#100 Rst = 1;
		#30 Rst = 0;
		#200 Go = 0;
		#200 Go = 1;
		#200 Go = 0;
		#200 Go = 1;
		#200 Go = 0;
		#200 Go = 1;
		#200 Go = 0;
		#200 Go = 1;
		#200 Go = 0;
		#200 Go = 1;
		#200 Go = 0;
		#200 Go = 1;
		#200 Go = 0;
		#200 Go = 1;
		#200 Go = 0;
		#200 Go = 1;
		#200 Go = 0;
		#200 Go = 1;
		#200 Go = 0;
	end

endmodule