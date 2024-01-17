----------------------------------------------------------------------------------------------------
--    (c)2023 F. COLLIN
----------------------------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
library work;
use work.constants_pkg.all;



entity top is
    port(
        clk, rst : in std_logic;
        SW : in std_logic_vector(15 downto 0); -- switches input values
        -- The 'btnc' instruction is employed to increment the program counter.
        -- It functions akin to the clock of the core.
        btnc : in std_logic;
        -- btnr is used to switch between the begining and the end of the register value
        btnr : in std_logic;
        -- button control :
        LED : out std_logic_vector(15 downto 0) -- the led half register value
    );
end top;


architecture top_level of top is
    -- components

    component riscv_no_pipeline is
        port (
            -- for debug
            SW : in std_logic_vector(4 downto 0);
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
    end component;

    component instr_rom_transfer is
        port (
            clk: in std_logic;
            write_address : out std_logic_vector(INSTR_MEM_LENGTH - 1 downto 0);
            instruction_in : out std_logic_vector(31 downto 0);
            we : out std_logic
        );
    end component;

    component led_visu is
        port (
            clk : in std_logic;
            btn : in std_logic;
            print_data : in std_logic_vector(DATA_LENGTH - 1 downto 0);
            LED : out std_logic_vector(15 downto 0)
        );
    end component;

    component switch is
        generic (
            sw_h : integer := 4
        );
        port (
            SW : in std_logic_vector(15 downto 0);
            sw_value : out std_logic_vector(sw_h downto 0)
        );
    end component;

    component detect_impulsion is
        port (
            clock : in std_logic;
            btn_input : in std_logic;
            btn_output : out std_logic
        );
    end component;

    signal s_clk, s_rst : std_logic;
    signal s_write_address : std_logic_vector(INSTR_MEM_LENGTH - 1 downto 0); -- switch value
    signal s_instruction_in : std_logic_vector(31 downto 0);
    signal s_we : std_logic := '0';
    signal s_print_data : std_logic_vector(DATA_LENGTH - 1 downto 0);
    signal s_btn_led : std_logic;

    signal s_SW : std_logic_vector(4 downto 0);
    signal s_pc_enable : std_logic;

begin
    s_clk <= clk;
    s_rst <= not rst;  

    inst_riscV : riscv_no_pipeline
    port map (
        SW => s_SW,
        print_data => s_print_data,
        --
        clk => s_clk,
        rst => s_rst,
        we => s_we,
        pc_enable => s_pc_enable, -- button signal
        write_address => s_write_address,
        instruction_in => s_instruction_in
    );

    inst_instr_rom_transfer : instr_rom_transfer
    port map (
        clk => clk,
        write_address => s_write_address,
        instruction_in => s_instruction_in,
        we => s_we
    );

    inst_led_visu : led_visu
    port map (
        clk => s_clk,
        btn => s_btn_led,
        print_data => s_print_data,
        LED => LED
    );

    inst_switch : switch
    port map (
        SW => SW,
        sw_value => s_SW
    );

    inst_detect_impulsion_btnc : detect_impulsion
    port map (
        clock => s_clk,
        btn_input => btnc,
        btn_output => s_btn_led
    );

    inst_detect_impulsion_btnr : detect_impulsion
    port map (
        clock => s_clk,
        btn_input => btnr,
        btn_output => s_pc_enable
    );


end top_level  ; -- top