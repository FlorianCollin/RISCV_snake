library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
library work;
use work.constants_pkg.all;

entity imm_gen is
    port(
        instr : in std_logic_vector(31 downto 0);
        
    )