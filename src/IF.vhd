library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
library work;
use work.constants_pkg.all;

-- instruction fecth entity
entity instr_fetch
 is
    -- Control signals
    port (
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
end instr_fetch;

architecture behav of instr_fetch is
    -- components declaration :
    component add is
        port (
            add_in : in std_logic_vector(INSTR_MEM_LENGTH - 1 downto 0);
            add_out : out std_logic_vector(INSTR_MEM_LENGTH - 1 downto 0)
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

    -- signals
    signal s_pc_address : std_logic_vector(INSTR_MEM_LENGTH - 1 downto 0);
    signal s_pc_in : std_logic_vector(INSTR_MEM_LENGTH - 1 downto 0);
    signal s_e0 : std_logic_vector(INSTR_MEM_LENGTH - 1 downto 0);

begin

    inst_mux_if : mux_generic
    generic map (
        input_size => INSTR_MEM_LENGTH
    )
    port map (
        e0 => s_e0,
        e1 => branch_pc,
        s => branch_control,
        q => s_pc_in
    );

    inst_pc : pc
    port map (
        clk => clk,
        rst => rst,
        pc_in => s_pc_in,
        pc_out => s_pc_address
    );

    inst_instr_mem : instr_memory
    port map (
        clk => clk,
        rst => rst,
        we => we,
        read_address => s_pc_address,
        instruction => instruction,
        write_address => write_address,
        instruction_in => instruction_in
    );

    inst_add : add
    port map (
        add_in => s_pc_address,
        add_out => s_e0
    );

    pc_address <= s_pc_address;

end behav ; -- behav