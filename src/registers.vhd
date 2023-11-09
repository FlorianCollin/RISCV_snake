library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
library work;
use work.constants_pkg.all;

entity registers is
    port (
        rst : in std_logic;
        reg_write : in std_logic; -- for R-format and load instruction
        read_register_1 : in std_logic_vector(4 downto 0);
        read_register_2 : in std_logic_vector(4 downto 0);
        write_register : in std_logic_vector(4 downto 0);
        write_data : in std_logic_vector(DATA_LENGTH - 1 downto 0);

        read_data_1 : out std_logic_vector(DATA_LENGTH - 1 downto 0);
        read_data_2 : out std_logic_vector(DATA_LENGTH - 1 downto 0)
    );
end registers;


architecture behav of registers is

    type mem_array is array (0 to 31) of std_logic_vector(DATA_LENGTH - 1 downto 0);
    signal memory : mem_array := (others => (others => '0'));

begin

    process(rst, reg_write, read_register_1, read_register_2, write_register)
    begin
        if rst = '1' then 
            memory <= (others => (others => '0'));
        else
            if reg_write = '1' then
                memory(to_integer(unsigned(write_register))) <= write_register;
            end if;
        end if;
    end process;

    read_data_1 <= memory(to_integer(unsigned(read_register_1))) when not rst else (others => '0');
    read_data_2 <= memory(to_integer(unsigned(read_register_2))) when not rst else (others => '0');


end behav ; -- behav

