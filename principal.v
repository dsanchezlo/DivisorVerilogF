module principal (SW, clk, btnres, LED, anodos, Sseg);
input [7:0] SW;
input clk;
input btnres;
output reg [7:0] LED;

output [6:0] Sseg;
output [7:0] anodos;
wire clk1kHz;
wire [7:0] resultado;
wire done;
wire init;

//El boton se presiono o no?
reg btnresON;
reg estadoINIT;

initial begin
	btnresON <= 'b0;
end

assign init = estadoINIT;
//assign resultado = SW[3:0]*SW[7:4];
//assign resultado = SW[3:0]/SW[7:4];

always @(posedge clk1kHz) begin
	
		if (btnres == 'b0 && btnresON == 'b0) begin
			btnresON = 'b1;
			estadoINIT = 'b1;
		end else begin
			estadoINIT = 'b0;
		end
		if (btnres == 'b1) btnresON = 'b0;

		LED[7:0] = resultado[7:0];
end

divfreq dFreq(clk, clk1kHz);

//multiplicador Mult(SW, clk, init, resultado, done);

Barrido_displays barrido(resultado, done, clk1kHz, Sseg, anodos);

divisor Div(SW, clk, init, resultado, done);

endmodule