module LS161a(
    input [3:0] D,        // Parallel Input
    input CLK,            // Clock
    input CLR_n,          // Active Low Asynchronous Reset
    input LOAD_n,         // Enable Parallel Input (Synchronous)
    input ENP,            // Count Enable Parallel
    input ENT,            // Count Enable Trickle
    output reg [3:0] Q,   // Parallel Output 	
    output RCO            // Ripple Carry Output (Terminal Count)
); 

    // Asynchronous Reset block
    always @(posedge CLK or negedge CLR_n) begin
        if (!CLR_n) begin
            // Reset takes priority and happens immediately (Asynchronous)
            Q <= 4'b0000;
        end else begin
            // Synchronous operations happen on the rising edge of CLK
            if (!LOAD_n) begin
                // Load data from D
                Q <= D;
            end else if (ENP && ENT) begin
                // Increment counter only if both enables are high
                Q <= Q + 1'b1;
            end
            // Note: If none of the above are true, Q maintains its value
        end
    end

    // Ripple Carry Output (RCO) logic
    // RCO is high when the count reaches 15 (4'b1111) AND ENT is high
    assign RCO = (Q == 4'b1111) && ENT;

endmodule