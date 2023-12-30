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
    signal s_val : integer;--signed(11 downto 0);

begin

    process(instr)
    begin
        s_val <= to_integer(signed(instr(11 downto 5) & instr(4 downto 0)));
        imm_gen_out <= std_logic_vector(to_signed(s_val, DATA_LENGTH));
    end process;

end behav ; -- behav