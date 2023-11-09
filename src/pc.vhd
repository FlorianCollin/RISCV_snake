library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
library work;
use work.constants_pkg.all;

entity pc is
    port (
        clk : in std_logic;
        rst : in std_logic; --async
        pc_in : in std_logic_vector(INSTR_MEM_LENGTH - 1 downto 0);
        pc_out : out std_logic_vector(INSTR_MEM_LENGTH - 1 downto 0)
    );
end pc;

architecture behav of pc is

begin

    process(clk, rst pc_in)
    begin
        if rst = '1' then
            pc_out <= (others => '0');
        elsif rising_edge(clk) then
            pc_out <= pc_in;
        end if;
    end process;  

end behav ; -- behav