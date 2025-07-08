module IN(
	input CLK,
	input enter,
	output reg in_flag
);

	reg enter_d;

	always @(posedge CLK) begin
		enter_d <= enter; 
	end

	always @(posedge CLK) begin
		if (enter && !enter_d)
			in_flag <= ~in_flag; 
	end

endmodule
