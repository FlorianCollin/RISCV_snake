library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
library work;
use work.constants_pkg.all;

entity riscv_no_pipeline is
    port (
        -- for debug
        SW : in std_logic_vector(4 downto 0); -- the reigister address to print comming from switches values
        print_data : out std_logic_vector(DATA_LENGTH - 1 downto 0);
        ----------------------------------------------------------------------
        -- std
        clk : in std_logic;
        rst : in std_logic;
        we : in std_logic;
        pc_enable : in std_logic;
        write_address : in std_logic_vector(INSTR_MEM_LENGTH - 1 downto 0);
        instruction_in : in std_logic_vector(31 downto 0)
    );
end riscv_no_pipeline;

architecture top_level of riscv_no_pipeline is

    -- component
    component add_sum is
        port (
            e1 : in std_logic_vector(INSTR_MEM_LENGTH - 1 downto 0);
            e2 : in std_logic_vector(DATA_LENGTH - 1 downto 0); -- signed
            add_sum_result : out std_logic_vector(INSTR_MEM_LENGTH - 1 downto 0)
        );
    end component;

    component add is
        port (
            add_in : in std_logic_vector(INSTR_MEM_LENGTH - 1 downto 0);
            add_out : out std_logic_vector(INSTR_MEM_LENGTH - 1 downto 0)
        );
    end component;

    component alu_control is
        port (
            alu_op : in std_logic_vector(1 downto 0);
            instr_30 : in std_logic;
            instr_14to12 : in std_logic_vector(2 downto 0);
            alu_control_selector : out std_logic_vector(3 downto 0)
        );
    end component;

    component alu is
        port (
            e1, e2 : in std_logic_vector(DATA_LENGTH - 1 downto 0);
            alu_control_selector : in std_logic_vector(3 downto 0);
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
            alu_op : out std_logic_vector(1 downto 0); -- + the instruction for the alu operation choice
            mem_write : out std_logic;
            alu_src : out std_logic;
            reg_write : out std_logic
        );
    end component;

    component data_memory is
        port (
            -- the memory can be rst
            rst : in std_logic;
            -- the two signal comming from Control unit
            mem_write : in std_logic; -- for sd instruction
            mem_read : in std_logic; -- for ld instruction
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
            --
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
            enable : in std_logic;
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
            read_data_2 : out std_logic_vector(DATA_LENGTH - 1 downto 0);
            print_register : in std_logic_vector(4 downto 0);
            print_data : out std_logic_vector(DATA_LENGTH - 1 downto 0)
        );
    end component;
    
    -- signals

    -- controls signals
    signal s_pc_src, s_branch, s_mem_read, s_mem_to_reg, s_mem_write, s_alu_src, s_reg_write : std_logic := '0';
    signal s_alu_op : std_logic_vector(1 downto 0);

    signal s_mux_if_e0 : std_logic_vector(INSTR_MEM_LENGTH - 1 downto 0) := (others => '0');

    signal s_pc_in : std_logic_vector(INSTR_MEM_LENGTH - 1 downto 0) := (others => '0');
    signal s_pc_out : std_logic_vector(INSTR_MEM_LENGTH - 1 downto 0) := (others => '0');
    signal s_instruction : std_logic_vector(31 downto 0);
    signal s_opcode : std_logic_vector(6 downto 0);
    signal s_rs1, s_rs2, s_rd : std_logic_vector(4 downto 0);
    signal s_instr_30 : std_logic;
    signal s_write_address_tt : std_logic_vector(INSTR_MEM_LENGTH - 1 downto 0) := (others => '0');
    signal s_instruction_tt : std_logic_vector(31 downto 0) := (others => '0');

    signal s_add_sum_result : std_logic_vector(INSTR_MEM_LENGTH - 1 downto 0);
    signal s_instr_14to12 : std_logic_vector(2 downto 0);
    signal s_alu_control_selector : std_logic_vector(3 downto 0);
    signal s_zero : std_logic;

    signal s_write_data : std_logic_vector(DATA_LENGTH - 1 downto 0);
    signal s_read_data_1, s_read_data_2 : std_logic_vector(DATA_LENGTH - 1 downto 0);
    signal s_imm_gen_out :  std_logic_vector(DATA_LENGTH - 1 downto 0);
    signal s_alu_e2 :  std_logic_vector(DATA_LENGTH - 1 downto 0);
    signal s_alu_result : std_logic_vector(DATA_LENGTH - 1 downto 0);
    signal s_read_data : std_logic_vector(DATA_LENGTH - 1 downto 0);
    signal s_sw : std_logic_vector(4 downto 0);

begin
    s_opcode <= s_instruction(OPCODE_H downto OPCODE_L);
    s_rs1 <= s_instruction(RS1_H downto RS1_L);
    s_rs2 <= s_instruction(RS2_H downto RS2_L);
    s_rd <= s_instruction(RD_H downto RD_L);
    s_instr_30 <= s_instruction(30);
    s_instr_14to12 <= s_instruction(14 downto 12);


    s_pc_src <= s_zero and s_branch;
    
    inst_control : control
    port map(
        -- opcode deside wich datapath will be taken !
        opcode => s_opcode,
        branch => s_branch,
        mem_read => s_mem_read,
        mem_to_reg => s_mem_to_reg,
        alu_op => s_alu_op,
        mem_write => s_mem_write,
        alu_src => s_alu_src,
        reg_write => s_reg_write
    );

    -- instruction fetch mux
    inst_mux_if : mux_generic
    generic map (
        input_size => INSTR_MEM_LENGTH
    )
    port map (
        e0 => s_mux_if_e0,
        e1 => s_add_sum_result,
        s => s_pc_src, -- control address
        q => s_pc_in
    );

    inst_pc : pc
    port map (
        clk => clk,
        rst => rst,
        enable => pc_enable,
        pc_in => s_pc_in,
        pc_out => s_pc_out-- current instruction address
    );

    
    inst_instr_mem : instr_memory
    port map (
        clk => clk,
        rst => rst,
        we => we,
        read_address => s_pc_out, -- pc output
        instruction => s_instruction, -- output
        -- data from uart/rom for instruction mem register
        write_address => write_address,
        instruction_in => instruction_in
    );

    inst_add : add
    port map (
        add_in => s_pc_out,
        add_out => s_mux_if_e0
    );

    inst_registers_debug : registers
    port map (
        rst => rst,
        reg_write => s_reg_write,
        read_register_1 => s_rs1,
        read_register_2 => s_rs2,
        write_register => s_rd,
        write_data => s_write_data,
        read_data_1 => s_read_data_1,
        read_data_2 => s_read_data_2,
        print_register => s_sw, -- the address of the register to print
        print_data => print_data
    );

    inst_imm_gen : imm_gen
    port map (
        instr => s_instruction,
        imm_gen_out => s_imm_gen_out
    );

    inst_mux_ex : mux_generic
    generic map (
        input_size => DATA_LENGTH
    )
    port map (
        e0 => s_read_data_2,
        e1 => s_imm_gen_out,
        s => s_alu_src, -- selector
        q => s_alu_e2
    );

    inst_alu_control : alu_control
    port map (
        alu_op => s_alu_op,
        instr_30 => s_instr_30,
        instr_14to12 => s_instr_14to12,
        alu_control_selector => s_alu_control_selector
    );

    inst_alu : alu
    port map (
        e1 => s_read_data_1,
        e2 => s_alu_e2,
        alu_control_selector => s_alu_control_selector,
        alu_result => s_alu_result,
        zero => s_zero
    );

    inst_add_sum : add_sum
    port map (
        e1 => s_pc_out,
        e2 => s_imm_gen_out,
        add_sum_result => s_add_sum_result
    );

    inst_data_mem : data_memory
    port map (
        rst => rst,
        mem_write => s_mem_write,
        mem_read => s_mem_read,
        address => s_alu_result,
        write_data => s_read_data_2,
        read_data => s_read_data -- mem output
    );

    inst_mux_wb : mux_generic
    generic map (
        input_size => DATA_LENGTH
    )
    port map (
        e0 => s_alu_result,
        e1 => s_read_data,
        s => s_mem_to_reg,
        q => s_write_data
    );


end top_level ; -- top_level