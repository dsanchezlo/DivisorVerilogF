module Barrido_displays(resultado, done, clk1kHz, Sseg, anodos);
	input [7:0] resultado;
	input clk1kHz;
	input done;

	output reg [6:0] Sseg;
	output reg [7:0] anodos;

	//Guardan el valor (En 7seg) que toma cada display
	reg [6:0] Sseg0 = 0;
	reg [6:0] Sseg1 = 0;
	reg [6:0] Sseg2 = 0;
	reg [6:0] Sseg3 = 0;
	reg [6:0] Sseg4 = 0;
	reg [6:0] Sseg5 = 0;
	reg [6:0] Sseg6 = 0;
	reg [6:0] Sseg7 = 0;
	
	
/*	parameter segmin = 7'b1111110; //-
	parameter segplus = 7'b1101100; // +
	parameter segdiv = 7'b1011011; // /
	parameter segmult = 7'b1001000; // *
*/	parameter seg0 = 7'b0000001; //0
	parameter seg1 = 7'b1001111; //1
/*	parameter seg2 = 7'b0010010; //2
	parameter seg3 = 7'b0000110; //3
	parameter seg4 = 7'b1001100; //4
	parameter seg5 = 7'b0100100; //5
	parameter seg6 = 7'b0100000; //6
	parameter seg7 = 7'b0001111; //7
	parameter seg8 = 7'b0000000; //8
	parameter seg9 = 7'b0000100; //9
	parameter segeq = 7'b1110110; //=
*/	parameter nul = 7'b1111111; //
	
	//Recorrer los 8 displays
	reg [2:0]contadorbar;
	
	//Inicializar registros
	initial contadorbar <= 3'b0;
		
	always @(posedge clk1kHz) begin
		contadorbar = contadorbar + 1'b1;
			/*case(contadorbar)
				3'b000: begin anodos <= 8'b11111110; Sseg <= (resultado[0] == 1) ? seg1 : seg0; end
				3'b001: begin anodos <= 8'b11111101; Sseg <= (resultado[1] == 1) ? seg1 : seg0; end
				3'b010: begin anodos <= 8'b11111011; Sseg <= (resultado[2] == 1) ? seg1 : seg0; end
				3'b011: begin anodos <= 8'b11110111; Sseg <= (resultado[3] == 1) ? seg1 : seg0; end
				3'b100: begin anodos <= 8'b11101111; Sseg <= (resultado[4] == 1) ? seg1 : seg0; end
				3'b101: begin anodos <= 8'b11011111; Sseg <= (resultado[5] == 1) ? seg1 : seg0; end
				3'b110: begin anodos <= 8'b10111111; Sseg <= (resultado[6] == 1) ? seg1 : seg0; end
				3'b111: begin anodos <= 8'b01111111; Sseg <= (resultado[7] == 1) ? seg1 : seg0; end
			endcase*/
			
			case(contadorbar)
				3'b000: begin anodos <= 8'b11111110; Sseg <= Sseg0; end
				3'b001: begin anodos <= 8'b11111101; Sseg <= Sseg1; end
				3'b010: begin anodos <= 8'b11111011; Sseg <= Sseg2; end
				3'b011: begin anodos <= 8'b11110111; Sseg <= Sseg3; end
				3'b100: begin anodos <= 8'b11101111; Sseg <= Sseg4; end
				3'b101: begin anodos <= 8'b11011111; Sseg <= Sseg5; end
				3'b110: begin anodos <= 8'b10111111; Sseg <= Sseg6; end
				3'b111: begin anodos <= 8'b01111111; Sseg <= Sseg7; end
			endcase
			
		if(done == 1)begin
				Sseg0 = (resultado[0] == 1) ? seg1 : seg0;
				Sseg1 = (resultado[1] == 1) ? seg1 : seg0;
				Sseg2 = (resultado[2] == 1) ? seg1 : seg0;
				Sseg3 = (resultado[3] == 1) ? seg1 : seg0;
				Sseg4 = (resultado[4] == 1) ? seg1 : seg0;
				Sseg5 = (resultado[5] == 1) ? seg1 : seg0;
				Sseg6 = (resultado[6] == 1) ? seg1 : seg0;
				Sseg7 = (resultado[7] == 1) ? seg1 : seg0;			
		end else begin
				Sseg0 = nul;
				Sseg1 = nul;
				Sseg2 = nul;
				Sseg3 = nul;
				Sseg4 = nul;
				Sseg5 = nul;
				Sseg6 = nul;
				Sseg7 = nul;
		end
	end

endmodule