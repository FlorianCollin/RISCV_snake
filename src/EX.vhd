library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
library work;
use work.constants_pkg.all;

entity exec is
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
end exec;

architecture behav of exec is

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

    component alu is
        port (
            e1, e2 : in std_logic_vector(DATA_LENGTH - 1 downto 0);
            alu_control_selector : in std_logic_vector(3 downto 0);
            alu_result : out std_logic_vector(DATA_LENGTH - 1 downto 0);
            zero : out std_logic
        );
    end component;

    component add_sum is
        port (
            e1, e2 : in std_logic_vector(INSTR_MEM_LENGTH - 1 downto 0); -- signed
            add_sum_result : out std_logic_vector(INSTR_MEM_LENGTH - 1 downto 0)
        );
    end component;


    signal s_e2 : std_logic_vector(DATA_LENGTH - 1 downto 0);

begin

    inst_mux_ex : mux_generic
    generic map (
        input_size => DATA_LENGTH
    )
    port map (
        e0 => read_data_2,
        e1 => imm_gen,
        s => alu_src,
        q => s_e2
    );

    inst_alu : alu
    port map (
        e1 => read_data_1,
        e2 => s_e2,
        alu_control_selector => alu_control_selector,
        alu_result => alu_result,
        zero => zero
    );

    inst_add_sum : add_sum
    port map (
        e1 => imm_gen,
        e2 => pc_address,
        add_sum_result => add_sum_result
    );

    read_data_2_out <= read_data_2;

end behav ; -- behav