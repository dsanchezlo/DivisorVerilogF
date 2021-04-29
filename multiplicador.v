module multiplicador(SW, clk, init, resultado, done);
input [7:0] SW;
input clk;
input init;
output reg [7:0] resultado;
output reg done = 0;
reg [3:0] status = 0;
reg rst = 0;
reg sh = 0;
reg add = 0;
wire z;
reg [7:0] A;
reg [3:0] B;
//reg contador = 0;
parameter START = 'b00, CHECK = 'b01, ADD = 'b10, SHIFT = 'b11, END = 'b100;
assign z = (B == 4'b0000) ? 1 : 0;
//FINITE STATE MACHINE (FSM)

// Suma de A con el resultado
always @(posedge clk) begin
	if(rst == 1)
		resultado = 0;
	else if(add == 1)
		resultado = resultado + A;
end
// Módulo de corrimiento

always @(posedge clk) begin
	if(rst) begin
		A = {4'b0000, SW[7:4]};
		B = SW[3:0];
	end else if (sh) begin
		A = A << 1;
		B = B >> 1;
	end
end
/*
always @(posedge clk) begin
	if(done == 1 && contador == 0) begin
		resultado = resultado >> 1;
		contador = contador + 1;
	end else contador = 0;
end
*/
always @(posedge clk) begin
	case(status)
		START: begin
			sh = 0;
			add = 0;
			if(init) begin
				done = 0;
				rst = 1;
				status = CHECK;
			end
		end
		CHECK: begin
			sh = 0;
			add = 0;
			done = 0;
			rst = 0;
			if(B[0] == 1)
				status = ADD;
			else
				status = SHIFT;
			end
		ADD: begin
			sh = 0;
			add = 1;
			done = 0;
			rst = 0;
			status = SHIFT;
		end
		SHIFT: begin
			sh = 1;
			add = 0;
			done = 0;
			rst = 0;
			if(z == 1)
				status = END;
			else
				status = CHECK;
			end
		END: begin
			sh = 0;
			add = 0;
			done = 1;
			rst = 0;
			status = START;
			end
		default: status = START;
	endcase
end

endmodule