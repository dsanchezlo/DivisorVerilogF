`timescale 1ns / 1ns


module testbench;

	// Inputs
	reg [7:0] SW;
	reg clk2;
	reg btnres;

	//reg [3:0] countBench;

	// Outputs
	wire [7:0] LED;
	wire [6:0] Sseg;
	wire [7:0] anodos;

	// Instantiate the Unit Under Test (UUT)
	principal uut (
		.SW(SW), 
		.clk(clk2), 
		.btnres(btnres),
		.LED(LED), 
		.anodos(anodos),
		.Sseg(Sseg)
	);

	initial begin
		// Initialize Inputs
		clk2= 1;
		btnres = 0;
		SW = 8'b00100001;

		//countBench = 'b0;
	end
      

	always begin 
		#10;
		clk2 = ~clk2;
		/*if (fil == 4'b1000 && countBench <= 'd3)begin
			col = 4'b1000;
		end else begin
			col = 4'b0000;
		end*/
	end
	/*always @(posedge col[3])begin
		countBench = countBench + 'b1;
	end*/
endmodule