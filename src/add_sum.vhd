library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
library work;
use work.constants_pkg.all;

entity add_sum is
    port (
        e1 : in std_logic_vector(INSTR_MEM_LENGTH - 1 downto 0);
        e2 : in std_logic_vector(DATA_LENGTH - 1 downto 0); -- signed
        add_sum_result : out std_logic_vector(INSTR_MEM_LENGTH - 1 downto 0)
    );
end add_sum;

architecture behav of add_sum is
    signal s_e2 : std_logic_vector(INSTR_MEM_LENGTH - 1 downto 0) := (others => '0');

begin

    s_e2 <= e2(INSTR_MEM_LENGTH - 1 downto 0);

    process(e1, e2)
    begin
        add_sum_result <= std_logic_vector(signed(e1) + signed(s_e2));
    end process;

end behav ; -- behav