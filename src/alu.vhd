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
        e1, e2 : in std_logic_vector(DATA_LENGTH - 1 downto 0);
        alu_control_selector : in std_logic_vector(3 downto 0);
        alu_result : out std_logic_vector(DATA_LENGTH - 1 downto 0);
        zero : out std_logic
    );
end alu;

architecture behav of alu is

    signal s_alu_result : std_logic_vector(DATA_LENGTH - 1 downto 0);
    constant zero_comp : std_logic_vector(DATA_LENGTH - 1 downto 0) := (others => '0'); 

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
                s_alu_result <= std_logic_vector(unsigned(e1) + unsigned(e2));
            
            -- sub
            when "0110" =>
                s_alu_result <= std_logic_vector(unsigned(e1) - unsigned(e2));

            when others =>
                null;

        end case;

        alu_result <= s_alu_result;

        if s_alu_result = zero_comp then
            zero <= '1';
        else
            zero <= '0';
        end if;
    end process;
            
end behav ; -- behav