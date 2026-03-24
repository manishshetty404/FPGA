module FSM(
  input In1,
  input RST,
  input CLK, 
  output reg Out1
);

  // 1. State Encoding
  reg [1:0] current_state, next_state;
  parameter A = 2'b00, B = 2'b01, C = 2'b10;

  // 2. State Register (Sequential block)
  always @(posedge CLK or negedge RST) begin
    if (!RST) begin
      current_state <= A; // Reset to state A
    end else begin
      current_state <= next_state;
    end
  end

  // 3. Next State and Output Logic (Combinational block)
  always @(*) begin
    // Default values to prevent latches
    next_state = current_state;
    Out1 = 1'b0;

    case (current_state)
      A: begin
        Out1 = 1'b0;
        if (In1 == 1'b1) next_state = B;
        else             next_state = A;
      end

      B: begin
        Out1 = 1'b0;
        if (In1 == 1'b0) next_state = C;
        else             next_state = B;
      end

      C: begin
        Out1 = 1'b1;
        if (In1 == 1'b1) next_state = A;
        else             next_state = C;
      end

      default: next_state = A;
    endcase
  end

endmodule
