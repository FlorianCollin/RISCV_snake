library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
library work;
use work.constants_pkg.all;

entity add is
    port (
        add_in : in std_logic_vector(INSTR_MEM_LENGTH - 1 downto 0);
        add_out : std_logic_vector(INSTR_MEM_LENGTH - 1 downto 0)
    );
end add;

architecture behav of add is

begin

    process(add_in)
    begin
        add_out <= add_in + std_logic_vector(to_unsigned(4, INSTR_MEM_LENGTH));
    end process;

end behav ; -- behav