library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
library work;
use work.constants_pkg.all;
entity registers_tb is
end registers_tb;

architecture tb of registers_tb is

    component registers
        port (rst             : in std_logic;
              reg_write       : in std_logic;
              read_register_1 : in std_logic_vector (4 downto 0);
              read_register_2 : in std_logic_vector (4 downto 0);
              write_register  : in std_logic_vector (4 downto 0);
              write_data      : in std_logic_vector (DATA_LENGTH - 1 downto 0);
              read_data_1     : out std_logic_vector (DATA_LENGTH - 1 downto 0);
              read_data_2     : out std_logic_vector (DATA_LENGTH - 1 downto 0));
    end component;

    signal rst             : std_logic;
    signal reg_write       : std_logic;
    signal read_register_1 : std_logic_vector (4 downto 0);
    signal read_register_2 : std_logic_vector (4 downto 0);
    signal write_register  : std_logic_vector (4 downto 0);
    signal write_data      : std_logic_vector (DATA_LENGTH - 1 downto 0);
    signal read_data_1     : std_logic_vector (DATA_LENGTH - 1 downto 0);
    signal read_data_2     : std_logic_vector (DATA_LENGTH - 1 downto 0);

begin

    dut : registers
    port map (rst             => rst,
              reg_write       => reg_write,
              read_register_1 => read_register_1,
              read_register_2 => read_register_2,
              write_register  => write_register,
              write_data      => write_data,
              read_data_1     => read_data_1,
              read_data_2     => read_data_2);

    stimuli : process
    begin
        rst <= '0';
        reg_write <= '0';
        read_register_1 <= (others => '0');
        read_register_2 <= (others => '0');
        write_register <= (others => '0');
        write_data <= (others => '0');
        wait;
    end process;

end tb;