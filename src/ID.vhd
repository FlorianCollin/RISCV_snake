library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
library work;
use work.constants_pkg.all;

entity ID is
    port (
        -- Control signals
        reg_write : in std_logic;
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
        write_data : in std_logic_vector(DATA_LENGTH - 1 downto 0);
        ------------------------------------------------------------------------------
        -- Outside control
        rst : in std_logic

    );  
end ID;

architecture behav of ID is
    component registers is
        port (
            rst : in std_logic;
            reg_write : in std_logic; -- write enable
            -- the two register read
            read_register_1 : in std_logic_vector(4 downto 0);
            read_register_2 : in std_logic_vector(4 downto 0);
            -- the register to write
            write_register : in std_logic_vector(4 downto 0);
            write_data : in std_logic_vector(DATA_LENGTH - 1 downto 0);
            -- output data
            read_data_1 : out std_logic_vector(DATA_LENGTH - 1 downto 0);
            read_data_2 : out std_logic_vector(DATA_LENGTH - 1 downto 0)
        );
    end component;

    component imm_gen is
        port(
            instr : in std_logic_vector(31 downto 0);
            imm_gen_out : out std_logic_vector(DATA_LENGTH - 1 downto 0) -- signed
        );
    end component;

begin

end behav ;