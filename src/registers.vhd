library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
library work;
use work.constants_pkg.all;

-- for the moment this is not realy a riscV core but near to it
-- there are 32 registers of 32 bits each one and we acces them by there indice 0 1 2 ...
-- contrarly to risc V where register are numerate like 0 4 8 ...
-- no signal de clk
entity registers is
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
end registers;


architecture behav of registers is
    constant NUMB_REG : integer := 32;
    type mem_array is array (0 to NUMB_REG - 1) of std_logic_vector(DATA_LENGTH - 1 downto 0);
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
    
    -- direct ouptut
    read_data_1 <= memory(to_integer(unsigned(read_register_1))) when not rst else (others => '0');
    read_data_2 <= memory(to_integer(unsigned(read_register_2))) when not rst else (others => '0');


end behav ; -- behav

