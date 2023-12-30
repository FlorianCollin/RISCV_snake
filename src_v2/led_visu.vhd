library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
library work;
use work.constants_pkg.all;


entity led_visu is
    port (
        clk : in std_logic;
        btn : in std_logic;
        print_data : in std_logic_vector(DATA_LENGTH - 1 downto 0);
        LED : out std_logic_vector(15 downto 0)
    );
end led_visu;

architecture behavioral of led_visu is

    signal s : std_logic := '0';

begin

    process(clk, btn)
    begin
        if rising_edge(clk) then
            if btn = '1' then
                if s = '0' then
                    s <= '1';
                elsif s = '1' then
                    s <= '0';
                end if;
            end if;
        end if;
    end process;

    process(clk, print_data)
    begin
        if rising_edge(clk) then
            if s = '0' then
                LED <= print_data(15 downto 0);
            elsif s = '1' then
                LED <= print_data(31 downto 16);
            end if;
        end if;      
    end process;

end behavioral ; -- behavioral