library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
library work;
use work.constants_pkg.all;

-- for the moment the riscv processor has no pipeline

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
    --IF
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
    -- ID
    component instr_decod is
        port (
            -- Control signals
            reg_write : in std_logic;
            ------------------------------------------------------------------------------
            -- IF output
            instruction : in std_logic_vector(31 downto 0);
            pc_address : in std_logic_vector(INSTR_MEM_LENGTH - 1 downto 0);
            ------------------------------------------------------------------------------
            -- instr_decod output
            read_data_1 : out std_logic_vector(DATA_LENGTH - 1 downto 0);
            read_data_2 : out std_logic_vector(DATA_LENGTH - 1 downto 0);
            imm_gen_out : out std_logic_vector(DATA_LENGTH - 1 downto 0);
            pc_address_out : out std_logic_vector(INSTR_MEM_LENGTH - 1 downto 0);
            ------------------------------------------------------------------------------
            write_data : in std_logic_vector(DATA_LENGTH - 1 downto 0);
            ------------------------------------------------------------------------------
            -- Outside control
            rst : in std_logic
        );  
    end component;
    -- EX
    component exec is
        port(
            -- ID Output
            pc_address : in std_logic_vector(INSTR_MEM_LENGTH - 1 downto 0); -- for branch calcul
            read_data_1 : in std_logic_vector(DATA_LENGTH - 1 downto 0);
            read_data_2 : in std_logic_vector(DATA_LENGTH - 1 downto 0);
            imm_gen : in std_logic_vector(DATA_LENGTH - 1 downto 0);
            --------------------------------------------------------------------------------
            -- Control signals
            alu_control_selector : in std_logic_vector(3 downto 0);
            alu_src : in std_logic;
            --------------------------------------------------------------------------------
            -- EX out
            alu_result : out std_logic_vector(DATA_LENGTH - 1 downto 0);
            zero : out std_logic;
            read_data_2_out : out std_logic_vector(DATA_LENGTH - 1 downto 0); -- same as the input read_data_2
            add_sum_result : out std_logic_vector(INSTR_MEM_LENGTH - 1 downto 0) -- go to IF
        );
    end component;
    -- WB
    component write_back is
        port (
            -- MEM out
            read_data : in std_logic_vector(DATA_LENGTH - 1 downto 0);
            alu_result : in std_logic_vector(DATA_LENGTH - 1 downto 0);
            ----------------------------------------------------------------
            -- Control signals
            mem_to_reg : in std_logic;
            ----------------------------------------------------------------
            write_back_data : out std_logic_vector(DATA_LENGTH - 1 downto 0)
        );
    end component;


begin

    architecture behav of riscv is
    
        signal 
    
    begin
    
    end behav ; -- behav

end behav ; -- behav