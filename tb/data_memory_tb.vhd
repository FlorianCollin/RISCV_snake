library ieee;
use ieee.std_logic_1164.all;

entity data_memory_tb is
end data_memory_tb;

architecture tb of data_memory_tb is

    component data_memory
        port (rst        : in std_logic;
              mem_write  : in std_logic;
              mem_read   : in std_logic;
              address    : in std_logic_vector (data_length - 1 downto 0);
              write_data : in std_logic_vector (data_length - 1 downto 0);
              read_data  : out std_logic_vector (data_length - 1 downto 0));
    end component;

    signal rst        : std_logic;
    signal mem_write  : std_logic;
    signal mem_read   : std_logic;
    signal address    : std_logic_vector (data_length - 1 downto 0);
    signal write_data : std_logic_vector (data_length - 1 downto 0);
    signal read_data  : std_logic_vector (data_length - 1 downto 0);

begin

    dut : data_memory
    port map (rst        => rst,
              mem_write  => mem_write,
              mem_read   => mem_read,
              address    => address,
              write_data => write_data,
              read_data  => read_data);

    stimuli : process
    begin
        rst <= '0';
        mem_write <= '0';
        mem_read <= '0';
        address <= (others => '0');
        write_data <= (others => '0');


        wait;
    end process;

end tb;