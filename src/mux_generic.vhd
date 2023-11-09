library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
library work;
use work.constants_pkg.all;

entity mux is
    generic (
        input_size : integer := 64
    );
    port (
        e0, e1 : std_logic_vector(input_size - 1  downto 0);
        s : std_logic;
        q : std_logic_vector(input_size - 1 downto 0)
    );
end mux;

architecture behav of mux is

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