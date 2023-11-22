----------------------------------------------------------------------------------------------------
--    (c)2023 F. COLLIN
----------------------------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity switch is
    generic (
        sw_h : integer := 4
    );
    port (
        SW : in std_logic_vector(15 downto 0);
        sw_value : out std_logic_vector(sw_h downto 0)
    );
end switch;

architecture Behavioral of switch is


begin

    sw_value <= SW(sw_h downto 0);

end Behavioral ; -- Behavioral