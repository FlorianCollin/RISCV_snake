library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
library work;
use work.constants_pkg.all;

entity mux is
    port (
        e0, e1 : std_logic;
        s : std_logic;
        q : std_logic
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