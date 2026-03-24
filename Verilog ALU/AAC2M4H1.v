module ALU ( 
  input [2:0] Op_code,
  input [31:0] A, B,
  output reg [31:0] Y
);

  // Combinational logic block to determine output Y based on Op_code
  always @(*) begin
    case (Op_code)
      3'b000:  Y = A;             // Pass through A
      3'b001:  Y = A + B;         // Addition
      3'b010:  Y = A - B;         // Subtraction
      3'b011:  Y = A & B;         // Bitwise AND
      3'b100:  Y = A | B;         // Bitwise OR
      3'b101:  Y = A + 1'b1;      // Increment A
      3'b110:  Y = A - 1'b1;      // Decrement A
      3'b111:  Y = B;             // Pass through B
      default: Y = 32'b0;         // Default case to avoid latches
    endcase
  end

endmodule