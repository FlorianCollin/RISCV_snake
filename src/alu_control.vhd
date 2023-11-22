library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
library work;
use work.constants_pkg.all;

entity alu_control is
    port (
        alu_op : in std_logic_vector(1 downto 0);
        instr_30 : in std_logic;
        instr_14to12 : in std_logic_vector(2 downto 0);
        alu_control_selector : out std_logic_vector(3 downto 0)
    );
end alu_control;

architecture behav of alu_control is

begin

    process(alu_op, instr_30, instr_14to12)
    begin
        if alu_op = "00" then -- sd or ld use add
            alu_control_selector <= "0010"; -- add
        elsif alu_op = "01" then -- beq use sub to detect zero
            alu_control_selector <= "0110"; -- sub
        elsif alu_op = "10" then -- R-type
            if instr_30 = '1' then
                alu_control_selector <= "0110"; -- sub
            else
                if instr_14to12 = "000" then
                    alu_control_selector <= "0010"; -- add
                elsif instr_14to12 = "111" then
                    alu_control_selector <= "0000"; -- and
                elsif instr_14to12 = "110" then
                    alu_control_selector <= "0001"; -- or
                end if;
            end if;
        end if;
    end process;

end behav ; -- behav