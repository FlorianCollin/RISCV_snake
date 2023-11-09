library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
library work;
use work.constants_pkg.all;

entity data_memory is
    port (
        rst : in std_logic;
        -- the two signal comming from Control unit
        mem_write : in std_logic; -- for sd instruction
        mem_read : in std_logic; -- for ld instruction
        address : in std_logic_vector(DATA_LENGTH - 1 downto 0);
        write_data : in std_logic_vector(DATA_LENGTH - 1 downto 0);

        read_data : out std_logic_vector(DATA_LENGTH - 1 downto 0)

    );
end data_memory;


architecture behav of data_memory is

    type mem_array is array (0 to 2**DATA_LENGTH - 1) of std_logic_vector(DATA_LENGTH - 1 downto 0);
    signal memory : mem_array := (others => (others => '0'));

begin

    process(rst, mem_write, mem_read, address, write_data)
    begin
        if rst = '1' then 
            memory <= (others => (others => '0'));
        else
            if mem_write = '1' then
                memory(to_integer(unsigned(address))) <= write_data;
            elsif mem_read  = '1' then
                read_data <= memory(to_integer(unsigned(address)));
            end if;
        end if;
    end process;
end behav ; -- behav

