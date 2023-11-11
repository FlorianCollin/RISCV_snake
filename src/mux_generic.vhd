library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
library work;
use work.constants_pkg.all;

entity mux_generic is
    generic (
        input_size : integer := 64
    );
    port (
        e0, e1 : in std_logic_vector(input_size - 1  downto 0);
        s : in std_logic;
        q : out std_logic_vector(input_size - 1 downto 0)
    );
end mux_generic;

architecture behav of mux_generic is

begin

    process(e0, e1, s)
    begin
        if s = '0' then
            q <= e0;
        else
            q <= e1;
        end if;
    end process;

end behav ; -- behav