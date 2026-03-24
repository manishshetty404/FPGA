module RAM128x32 
#(
  parameter Data_width = 32,  //# of bits in word
            Addr_width = 7   // # of address bits
  )
  (  //ports
    input wire clk,
    input wire we,
    input wire [(Addr_width-1):0] address, 
    input wire [(Data_width-1):0] d,
    output reg [(Data_width-1):0] q  // Changed to reg to register the output
  );

  // 1. Declare the memory array 
  // This creates 128 (2^7) words, each 32 bits wide
  reg [Data_width-1:0] mem [2**Addr_width-1:0];

  // 2. Synchronous Write and Synchronous Read logic
  always @(posedge clk) begin
    if (we) begin
      // Write the data 'd' into memory at the specified address
      mem[address] <= d;
    end
    
    // Register the read output as requested
    // Q updates on the clock edge based on the current address
    q <= mem[address];
  end

endmodule