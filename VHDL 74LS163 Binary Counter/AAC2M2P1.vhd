LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

entity AAC2M2P1 is port (                 	
   CP: 	in std_logic; 	-- clock
   SR:  in std_logic;  -- Active low, synchronous reset
   P:    in std_logic_vector(3 downto 0);  -- Parallel input
   PE:   in std_logic;  -- Parallel Enable (Load)
   CEP: in std_logic;  -- Count enable parallel input
   CET:  in std_logic; -- Count enable trickle input
   Q:   out std_logic_vector(3 downto 0);            			
    TC:  out std_logic  -- Terminal Count
);            		
end AAC2M2P1;

architecture behavioral of AAC2M2P1 is
    -- We need a signal to hold the value because we can't read from the output port Q
    signal count_reg : unsigned(3 downto 0); 
begin

    process(CP)
    begin
        -- The 74LS163 is FULLY synchronous, so everything stays inside the rising_edge block
        if rising_edge(CP) then
            if SR = '0' then            -- Synchronous Reset (Highest Priority)
                count_reg <= "0000";
            elsif PE = '0' then         -- Parallel Load (Active Low)
                count_reg <= unsigned(P);
            elsif (CEP = '1' and CET = '1') then -- Increment only if both enables are High
                count_reg <= count_reg + 1;
            else
                count_reg <= count_reg; -- Hold the current value
            end if;
        end if;
    end process;

    -- Concurrent assignments (these happen outside the process)
    Q <= std_logic_vector(count_reg);
    
    -- Terminal Count (TC) is high when count is 15 AND the trickle enable (CET) is high
    TC <= '1' when (count_reg = "1111" and CET = '1') else '0';

end behavioral;