library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
library work;
use work.constants_pkg.all;

entity ID is
    port (
        -- Control signals
        reg_write : in std_logic;
        ------------------------------------------------------------------------------
        -- IF output
        instruction : in std_logic_vector(31 downto 0);
        current_pc : in std_logic_vector(INSTR_MEM_LENGTH - 1 downto 0);
        ------------------------------------------------------------------------------
        -- ID output
        read_data_1 : out std_logic_vector(DATA_LENGTH - 1 downto 0);
        read_data_2 : out std_logic_vector(DATA_LENGTH - 1 downto 0);
        imm_gen_out : out std_logic_vector(DATA_LENGTH - 1 downto 0);
        ------------------------------------------------------------------------------
        write_data : in std_logic_vector(DATA_LENGTH - 1 downto 0);
        ------------------------------------------------------------------------------
        -- Outside control
        rst : in std_logic
    );  
end ID;

architecture behav of ID is
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

    component imm_gen is
        port(
            instr : in std_logic_vector(31 downto 0);
            imm_gen_out : out std_logic_vector(DATA_LENGTH - 1 downto 0) -- signed
        );
    end component;

    signal s_rs1, s_rs2, s_rd : std_logic_vector(4 downto 0);

begin

    s_rs1 <= instruction(RS1_H downto RS1_L);
    s_rs2 <= instruction(RS2_H downto RS2_L);
    s_rd <= instruction(RD_H downto RSD_L);

    inst_registers : registers
    port map (
        rst <= rst,
        reg_write <= reg_write,
        read_register_1 <= s_rs1,
        read_register_2 <= s_rs2,
        write_register <= s_rd,
        write_data <= write_data,
        read_data_1 <= read_data_1,
        read_data_2 <= read_data_2
    );

    inst_imm_gen : imm_gen
    port map (
        instr <= instruction,
        imm_gen_out <= imm_gen_out
    );

end behav ;