library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
library work;
use work.constants_pkg.all;

entity ID is
    port (
        -- Control signals
        
        ------------------------------------------------------------------------------
        -- IF output
        instruction : in std_logic_vector(31 downto 0);
        current_pc : in std_logic_vector(INSTR_MEM_LENGTH - 1 downto 0);
        ------------------------------------------------------------------------------
        -- ID output
        read_data_1 : out std_logic_vector(DATA_LENGTH - 1 downto 0);
        read_data_2 : out std_logic_vector(DATA_LENGTH - 1 downto 0);
        imm_gen_out : out std_logic_vector(DATA_LENGTH - 1 downto 0);
        ------------------------------------------------------------------------------
        
    );  
end ID;