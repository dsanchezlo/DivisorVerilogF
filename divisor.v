module divisor(SW, clk, init, resultado, done);
input [7:0] SW;
input clk;
input init;
output reg [7:0] resultado;
output reg done = 0;
reg [7:0] A = 0;
reg [3:0] B = 0;
reg sh = 0;
reg comp = 0;
reg resta = 0;
reg reset = 0;
reg [2:0] status = 0;
reg h = 0;	// A[7:4] >= B ?
reg e = 0;	// Ya se recorrio todo el numero?
reg [2:0] contadorA = 0;
parameter START = 'b00, SHIFT = 'b01, COMPARATOR = 'b10, COMPARATOR2 = 'b11, RESTA = 'b100, END = 'b101;

always @(posedge clk) begin
	if(contadorA == 3'd4) e = 1;
	if(reset) begin
		resultado  = 0;
		e = 0;
	end else if(comp == 1) begin
		if(A[7:4] >= B && A!=0 && B!=0) begin
			h = 1;
			resultado[0] = 1;
		end else if(A[7:4] < B) begin
			h = 0;
		end
		if (e == 0) resultado = resultado << 1;
	end
	if (done == 1) begin
		e = 0;
		h = 0;
	end
end

always @(posedge clk) begin
	if(reset) begin
		A = {4'b0000, SW[7:4]};
		B = SW[3:0];
		contadorA = 0;	
	end else if (sh==1 && A[7]==0) begin
		A = A << 1;
		if (contadorA < 'd4) contadorA = contadorA + 3'b1;
	end else if(resta) begin
		A[7:4] = A[7:4] - B;
	end
end

always @(posedge clk) begin
	case(status)
		START: begin
			sh = 0;
			comp = 0;
			resta = 0;
			if(init == 1) begin
				done = 0;
				reset = 1;
				status = SHIFT;
			end
		end
		SHIFT: begin
			sh = 1;
			comp = 0;
			resta = 0;
			done = 0;
			reset = 0;
			status = COMPARATOR;
		end
		COMPARATOR: begin
			if(e == 0) begin
				sh = 0;
				comp = 1;
				resta = 0;
				done = 0;
				reset = 0;
				status = COMPARATOR2;
			end else begin
				status = END;
			end
		end
		COMPARATOR2: begin
			sh = 0;
			comp = 0;
			resta = 0;
			done = 0; 
			reset = 0;
			if(h == 1) status = RESTA;
			else if(h == 0) status = SHIFT;
		end
		RESTA: begin
			sh = 0;
			comp = 0;
			resta = 1;
			done = 0;
			reset = 0;
			status = SHIFT;			
		end
		END: begin
			sh = 0;
			comp = 0;
			resta = 0;
			done = 1;
			reset = 0;
			status = START;			
		end
		default: status = START;
	endcase
end

endmodule