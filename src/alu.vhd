library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
library work;
use work.constants_pkg.all;

-- executive part of the cpu
-- can perform 4 operations for the moment :
-- add / sub / and / or
-- zero signal detection
entity alu is
    port (
        e1, e2 : std_logic_vector(DATA_LENGTH - 1 downto 0);
        alu_control : std_logic_vector(3 downto 0);
        alu_result : std_logic_vector(DATA_LENGTH - 1 downto 0);
        zero : std_logic
    );
end alu;

architecture behav of alu is

    signal s_alu_result : std_logic_vector(DATA_LENGTH - 1 downto 0);

begin

    process(e1, e2, alu_control)
    begin
        case alu_control is
            -- and
            when "0000" =>
                s_alu_result <= e1 and e2;

            -- or
            when "0001" =>
                s_alu_result <= e1 or e2;

            -- add
            when "0010" =>
                s_alu_result <= std_logic_vector(unsigned(e1) + unsigned(e2))
            
            -- sub
            when "0110" =>
                s_alu_result <= std_logic_vector(unsigned(e1) - unsigned(e2))

            when others =>
                null;

        end case;

        alu_result <= s_alu_result;

        if s_alu_result = (ohters => '0') then
            zero <= '1';
        else
            zero <= '0'
        end if;
    end process;
            
end behav ; -- behav