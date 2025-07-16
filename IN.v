module IN(
	input CLK,
	input enter,
	input halt,
	output reg in_flag
);

	reg enter_d;

	always @(posedge CLK) begin
		enter_d <= enter; 
	end

	always @(posedge CLK) begin
		if (enter == !enter_d)
			in_flag = 1;
	end

endmodule
