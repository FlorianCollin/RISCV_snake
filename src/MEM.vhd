library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
library work;
use work.constants_pkg.all;

entity mem is
    port (
        -- EX Output
        -- zero : in std_logic;
        alu_result : in std_logic_vector(DATA_LENGTH - 1 downto 0);
        read_data_2 : in std_logic_vector(DATA_LENGTH - 1 downto 0);
        -----------------------------------------------------------------
        -- Control signals
        mem_read : in std_logic;
        mem_write : in std_logic;
        -----------------------------------------------------------------
        -- MEM out
        read_data : out std_logic_vector(DATA_LENGTH - 1 downto 0);
        alu_result_out : out std_logic_vector(DATA_LENGTH - 1 downto 0);
        -----------------------------------------------------------------
        -- Outside control
        rst : in std_logic
    );
end mem;

architecture behav of mem is
    component data_memory is
        port (
            -- the memory can be rst
            rst : in std_logic;
            -- the two signal comming from Control unit
            mem_write : in std_logic; -- for sd instruction
            mem_read : in std_logic; -- for ld instruction
            address : in std_logic_vector(DATA_LENGTH - 1 downto 0);
            write_data : in std_logic_vector(DATA_LENGTH - 1 downto 0);
            read_data : out std_logic_vector(DATA_LENGTH - 1 downto 0)
        );
    end component;

begin

    inst_data_mem : data_memory
    port map (
        rst => rst,
        mem_write => mem_write,
        mem_read => mem_read,
        address => alu_result,
        write_data => read_data_2,
        read_data => read_data
    );

end behav ; -- behav