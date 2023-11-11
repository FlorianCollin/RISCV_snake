library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
library work;
use work.constants_pkg.all;

entity imm_gen is
    port(
        instr : in std_logic_vector(31 downto 0);
        imm_gen_out : out std_logic_vector(DATA_LENGTH - 1 downto 0) -- signed
    );
end imm_gen;

architecture behav of imm_gen is

begin

    process(instr)
    begin
        imm_gen_out <=  x"FFFFFFFFFFFFF" & instr(11 downto 5) & instr(4 downto 0);
    end process;

end behav ; -- behav