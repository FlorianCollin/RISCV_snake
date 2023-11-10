library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
library work;
use work.constants_pkg.all;

-- signed shift !!
entity shift_led_1 is
    Port ( 
        d  : in  std_logic_vector(DATA_LENGTH - 1 downto 0);
        q : out std_logic_vector(DATA_LENGTH - 1 downto 0)
    );
end shift_led_1;

architecture Behavioral of shift_led_1 is
begin
    process (d)
    begin
        q <= d(DATA_LENGTH - 1 downto 1) & '0';
    end process;
end Behavioral;
