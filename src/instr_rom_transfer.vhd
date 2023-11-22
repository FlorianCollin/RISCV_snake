library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
library work;
use work.constants_pkg.all;


entity instr_rom_transfer is
    port (
        clk: in std_logic;
        write_address : out std_logic_vector(INSTR_MEM_LENGTH - 1 downto 0);
        instruction_in : out std_logic_vector(31 downto 0);
        we : out std_logic -- 1 during the transfer time
    );
end instr_rom_transfer;

architecture behav of instr_rom_transfer is

    -- rom + counter architecture !

    signal s_count : integer := 0;

    constant NUM_INSTR : integer := 2; -- number of instruction to put in our instruciton memory
    type mem_array is array (0 to NUM_INSTR - 1) of std_logic_vector(31 downto 0);
    signal memory : mem_array := (
        "0000000" & "00001" & "00010" & "000" & "00011" & "0110011",
        "0000000" & "00011" & "00001" & "000" & "00011" & "0110011"
    ); -- <- here we have to write the instruction of the program in binary


begin

    -- At the begining all this rom will be tranfered into the instruciton memory and it will take NUM_instr * Ts second to completed

    process(clk)
    begin
        if rising_edge(clk) then
            if s_count < NUM_INSTR then
                we <= '1';
                s_count <= s_count + 1;
                instruction_in <= memory(s_count);
                write_address <= std_logic_vector(to_unsigned(s_count, INSTR_MEM_LENGTH));
            else
                we <= '0';
            end if;
        end if;
    end process;
      
end behav ; -- behav