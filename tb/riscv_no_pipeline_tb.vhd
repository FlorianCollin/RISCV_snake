library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library work;
use work.constants_pkg.all;

entity riscv_no_pipeline_tb is
end riscv_no_pipeline_tb;

architecture tb of riscv_no_pipeline_tb is

    component riscv_no_pipeline
        port (clk            : in std_logic;
              rst            : in std_logic;
              we             : in std_logic;
              pc_enable      : in std_logic;
              write_address  : in std_logic_vector (INSTR_MEM_LENGTH - 1 downto 0);
              instruction_in : in std_logic_vector (31 downto 0));
    end component;

    signal clk            : std_logic;
    signal rst            : std_logic;
    signal we             : std_logic;
    signal pc_enable      : std_logic;
    signal write_address  : std_logic_vector (INSTR_MEM_LENGTH - 1 downto 0);
    signal instruction_in : std_logic_vector (31 downto 0);

begin

    dut : riscv_no_pipeline
    port map (clk            => clk,
              rst            => rst,
              we             => we,
              pc_enable      => pc_enable,
              write_address  => write_address,
              instruction_in => instruction_in);

    clk_process : process
    begin
        clk <= '1';
        wait for 5 ns;
        clk <= '0';
        wait for 5 ns;
    end process;

    stimuli : process
    begin
        rst <= '0';
        we <= '0';
        pc_enable <= '0';
        write_address <= (others => '0');
        instruction_in <= (others => '0');
        wait for 10 ns;
        rst <= '0';
        we <= '1';
        -- Ecriture de l'instuction : add x3 x1 x2 dans l'addresse 0 et 1 de la mémoire d'instruction
        instruction_in <= "0000000" & "00001" & "00010" & "000" & "00011" & "0110011";
        wait for 10 ns;
        write_address <= std_logic_vector(to_unsigned(1,INSTR_MEM_LENGTH));
        wait for 10 ns;
        write_address <= std_logic_vector(to_unsigned(2,INSTR_MEM_LENGTH));
        -- add x3 x1 x3
        instruction_in <= "0000000" & "00011" & "00001" & "000" & "00011" & "0110011";
        wait for 10 ns;
        we <= '0';
        pc_enable <= '1';
        wait for 100 ns;
        pc_enable <= '0';
        
        --pc_enable <= '1';

        wait;
    end process;

end tb;