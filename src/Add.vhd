----------------------------------------------------------------------------------------------------
--    (c)2023 F. COLLIN

-- pc <= pc + 1

----------------------------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
library work;
use work.constants_pkg.all;

entity add is
    port (
        add_in : in std_logic_vector(INSTR_MEM_LENGTH - 1 downto 0);
        add_out : out std_logic_vector(INSTR_MEM_LENGTH - 1 downto 0)
    );
end add;

architecture behav of add is

    constant incr_value : integer := 1; -- <-- Increment value

    signal s_add_out : unsigned(INSTR_MEM_LENGTH - 1 downto 0) := (others => '0');

begin

    process(add_in)
    begin
        s_add_out <= unsigned(add_in) + to_unsigned(incr_value, INSTR_MEM_LENGTH);
    end process;
    
    add_out <= std_logic_vector(s_add_out);

end behav ; -- behav