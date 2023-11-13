library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
library work;
use work.constants_pkg.all;

entity riscv is
    port (
        clk : in std_logic;
        rst : in std_logic;
        instr_we : in std_logic;
        instr_write_address : in std_logic_vector(INSTR_MEM_LENGTH - 1 downto 0);
        instruction_in : in std_logic_vector(31 downto 0)
    );
end riscv;

architecture behav of riscv is

    -- components

    component instr_fetch is
        port (
            -- Control signals
            branch_pc : in std_logic_vector(INSTR_MEM_LENGTH - 1 downto 0);
            branch_control : in std_logic;
            ------------------------------------------------------------------------------
            pc_address : out std_logic_vector(INSTR_MEM_LENGTH - 1 downto 0);
            instruction : out std_logic_vector(31 downto 0); -- also for alu_control and control
            ------------------------------------------------------------------------------
            -- Outside control
            clk, rst : in std_logic;
            we : in std_logic;
            write_address : in std_logic_vector(INSTR_MEM_LENGTH - 1 downto 0);
            instruction_in : in std_logic_vector(31 downto 0)
        );
    end component;

    

begin

end behav ; -- behav