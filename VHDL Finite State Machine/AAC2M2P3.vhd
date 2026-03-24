library ieee;
use ieee.std_logic_1164.all;

entity FSM is
port (In1: in std_logic;
   RST: in std_logic; 
   CLK: in std_logic;
   Out1 : inout std_logic);
end FSM;

architecture behavioral of FSM is
    type state_type is (a, b, c);
    signal current_state, next_state : state_type;
begin
    process(CLK, RST)
    begin
        if (RST = '1') then
            current_state <= a;
        elsif rising_edge(CLK) then
            current_state <= next_state;
        end if;
    end process;

    process(current_state, In1)
    begin
        case current_state is
            when a =>
                Out1 <= '0';
                if (In1 = '1') then 
                    next_state <= b;
                else 
                    next_state <= a;
                end if;
            when b =>
                Out1 <= '0';
                if (In1 = '0') then 
                    next_state <= c;
                else 
                    next_state <= b;
                end if;
            when c =>
                Out1 <= '1';
                if (In1 = '1') then 
                    next_state <= a;
                else 
                    next_state <= c;
                end if;
            when others =>
                Out1 <= '0';
                next_state <= a;
        end case;
    end process;
end behavioral;