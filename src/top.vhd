library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
library work;
use work.constants_pkg.all;

entity top is
end top;

architecture top_level of top is
-- component
component add_sum is
    port (
        e1, e2 : in std_logic_vector(INSTR_MEM_LENGTH - 1 downto 0); -- signed
        add_out : out std_logic_vector(INSTR_MEM_LENGTH - 1 downto 0)
    );
end component;

component add_sum is
    port (
        e1, e2 : in std_logic_vector(INSTR_MEM_LENGTH - 1 downto 0); -- signed
        add_out : std_logic_vector(INSTR_MEM_LENGTH - 1 downto 0)
    );
end component;

component alu_control is
    port (
        alu_op : in std_logic_vector(1 downto 0);
        instr_30 : in std_logic;
        instr_14to12 : in std_logic_vector(2 downto 0);
        alu_control : out std_logic_vector(3 downto 0)
    );
end component;

component alu is
    port (
        e1, e2 : in std_logic_vector(DATA_LENGTH - 1 downto 0);
        alu_control : in std_logic_vector(3 downto 0);
        alu_result : out std_logic_vector(DATA_LENGTH - 1 downto 0);
        zero : out std_logic
    );
end component;

component control is
    port (
        opcode : in std_logic_vector(6 downto 0);
        branch : out std_logic;
        mem_read : out std_logic;
        mem_to_reg : out std_logic;
        alu_op : out std_logic_vector(1 downto 0);
        mem_write : out std_logic;
        alu_src : out std_logic;
        reg_write : out std_logic
    );
end component;

component data_memory is
    port (
        rst : in std_logic;
        mem_write : in std_logic;
        mem_read : in std_logic;
        address : in std_logic_vector(DATA_LENGTH - 1 downto 0);
        write_data : in std_logic_vector(DATA_LENGTH - 1 downto 0);
        read_data : out std_logic_vector(DATA_LENGTH - 1 downto 0)
    );
end component;


component imm_gen is
    port(
        instr : in std_logic_vector(31 downto 0);
        imm_gen_out : out std_logic_vector(DATA_LENGTH - 1 downto 0) -- signed
    );
end component;

component instr_memory is
    port (
        clk : in std_logic;
        rst : in std_logic;
        we : in std_logic;
        read_address : in std_logic_vector(INSTR_MEM_LENGTH - 1 downto 0);
        instruction : out std_logic_vector(31 downto 0);
        write_address : in std_logic_vector(INSTR_MEM_LENGTH - 1 downto 0);
        instruction_in : in std_logic_vector(31 downto 0)
    );
end component;

component mux_generic is
    generic (
        input_size : integer := 64
    );
    port (
        e0, e1 : in std_logic_vector(input_size - 1  downto 0);
        s : in std_logic;
        q : out std_logic_vector(input_size - 1 downto 0)
    );
end component;

component mux is
    port (
        e0, e1 : std_logic;
        s : std_logic;
        q : std_logic
    );
end component;

component pc is
    port (
        clk : in std_logic;
        rst : in std_logic;
        pc_in : in std_logic_vector(INSTR_MEM_LENGTH - 1 downto 0);
        pc_out : out std_logic_vector(INSTR_MEM_LENGTH - 1 downto 0)
    );
end component;

component registers is
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
end component;

begin



end top_level ; -- top