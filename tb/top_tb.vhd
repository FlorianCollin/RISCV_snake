library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_top is
end tb_top;

architecture tb of tb_top is

    component top
        port (clk  : in std_logic;
              rst  : in std_logic;
              SW   : in std_logic_vector (15 downto 0);
              btnc : in std_logic;
              btnr : in std_logic;
              LED  : out std_logic_vector (15 downto 0));
    end component;

    signal clk  : std_logic;
    signal rst  : std_logic;
    signal SW   : std_logic_vector (15 downto 0);
    signal btnc : std_logic;
    signal btnr : std_logic;
    signal LED  : std_logic_vector (15 downto 0);

begin

    dut : top
    port map (clk  => clk,
              rst  => rst,
              SW   => SW,
              btnc => btnc,
              btnr => btnr,
              LED  => LED);

    clk_process : process
    begin
        clk <= '1';
        wait for 5 ns;
        clk <= '0';
        wait for 5 ns;
    end process;

    stimuli : process
    begin
        -- EDIT Adapt initialization as needed
        rst <= '1';
        SW <= (others => '0');
        btnc <= '0';
        btnr <= '0';
        -- wait for instuction load
        wait for 100 ns;
        -- test of debug leds
        SW <= std_logic_vector(to_unsigned(2, SW'length));
        wait for 100 ns;
        -- pc incr.
        btnc <= '1';
        wait for 20 ns;
        btnc <= '0';
        wait for 20 ns;
        -- visu test
        SW <= std_logic_vector(to_unsigned(0, SW'length));
        wait for 20 ns;
        SW <= std_logic_vector(to_unsigned(1, SW'length));
        wait for 20 ns;
        SW <= std_logic_vector(to_unsigned(2, SW'length));
        wait for 100 ns;
        wait;
    end process;

end tb;