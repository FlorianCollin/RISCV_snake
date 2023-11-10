library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
library work;
use work.constants_pkg.all;

entity add_sum is
    port (
        e1, e2 : in std_logic_vector(INSTR_MEM_LENGTH - 1 downto 0); -- signed
        add_out : std_logic_vector(INSTR_MEM_LENGTH - 1 downto 0)
    );
end add_sum;

architecture behav of add_sum is

begin

    process(add_in)
    begin
        add_out <= std_logic_vector(signed(e1) + signed(e2))
    end process;

end behav ; -- behav