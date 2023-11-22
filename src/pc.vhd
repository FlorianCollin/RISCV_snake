library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
library work;
use work.constants_pkg.all;

-- the program counter for the instruction memory
-- the only clk trigger module
entity pc is
    port (
        clk : in std_logic;
        rst : in std_logic;
        enable : in std_logic;
        pc_in : in std_logic_vector(INSTR_MEM_LENGTH - 1 downto 0);
        pc_out : out std_logic_vector(INSTR_MEM_LENGTH - 1 downto 0)
    );
end pc;

architecture behav of pc is
    --signal s_pc : std_logic_vector(INSTR_MEM_LENGTH - 1 downto 0) := (others => '0');
    signal init : std_logic := '0';
begin

    process(clk, rst, pc_in, enable)
    begin
        if rst = '1' then
            pc_out <= (others => '0');
        elsif rising_edge(clk) then
            if init = '0' then
                pc_out <= (others => '0');
                init <= '1'; -- initialisation finie
            elsif enable = '1' then
                pc_out <= pc_in;
            end if;
        end if;
    end process;


end behav ; -- behav