library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
library work;
use work.constants_pkg.all;

entity instr_memory is
    port (
        clk : in std_logic;
        rst : in std_logic;
        we : in std_logic;
        read_address : in std_logic_vector(INSTR_MEM_LENGTH - 1 downto 0);
        instruction : out std_logic_vector(31 downto 0);
        write_address : in std_logic_vector(INSTR_MEM_LENGTH - 1 downto 0);
        instruction_in : in std_logic_vector(31 downto 0)
    );
end instr_memory;

architecture behav of instr_memory is

    type mem_array is array (0 to 2**INSTR_MEM_LENGTH - 1) of std_logic_vector(31 downto 0);
    signal memory : mem_array := (others => (others => '0'));

begin

    process(clk, rst)
    begin
        if rst = '1' then 
            memory <= (others => (others => '0'));
        elsif rising_edge(clk) then
            if we = '1' then
                memory(to_integer(unsigned(write_address))) <= instruction_in;
            end if;
        end if;
    end process;

    instruction <= memory(to_integer(unsigned(read_address))) when rst ='0' else (others => '0');

end behav ; -- behav