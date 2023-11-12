library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
library work;
use work.constants_pkg.all;

entity write_back is
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
end write_back;


architecture behav of write_back is

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

begin

    inst_mux_wb : mux_generic
    port map (
        e0 => alu_result,
        e1 => read_data,
        s => mem_to_reg,
        q => write_back_data
    );



end behav ; -- behav