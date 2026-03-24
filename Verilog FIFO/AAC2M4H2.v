module FIFO8x9(
  input clk, rst,
  input RdPtrClr, WrPtrClr, 
  input RdInc, WrInc,
  input [8:0] DataIn,
  output [8:0] DataOut, // Changed to wire to support tri-state logic
  input rden, wren
);

  // Storage array: 8 locations, each 9 bits wide
  reg [8:0] fifo_array[7:0];
  
  // Pointers: 3 bits are enough to address 8 locations
  reg [2:0] wrptr, rdptr;

  // --- Write Logic ---
  always @(posedge clk or posedge rst) begin
    if (rst) begin
      wrptr <= 3'b000;
    end else if (WrPtrClr) begin
      wrptr <= 3'b000;
    end else if (wren) begin
      fifo_array[wrptr] <= DataIn;
      if (WrInc) wrptr <= wrptr + 1;
    end
  end

  // --- Read Logic ---
  always @(posedge clk or posedge rst) begin
    if (rst) begin
      rdptr <= 3'b000;
    end else if (RdPtrClr) begin
      rdptr <= 3'b000;
    end else if (rden && RdInc) begin
      rdptr <= rdptr + 1;
    end
  end

  // --- Output Logic (Tri-state) ---
  // If rden is high, output data; otherwise, high impedance (Z)
  assign DataOut = (rden) ? fifo_array[rdptr] : 9'bz;

endmodule