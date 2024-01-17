----------------------------------------------------------------------------------------------------
--    (c)2023 F. COLLIN

-- Fr.
-- Ce bloc permet d'effectuer un saut d'adresse en incrémentant la valeur de la variable pc qui pointe vers l'instruction courante.
-- Par exemple, dans le cas d'une instruction BEQ, on teste l'égalité entre deux variables (contenues dans les registres).
-- Si le résultat 'zéro' de l'ALU est à '1', alors la nouvelle valeur du pc (program counter) est la sortie add_sum_result.
-- Sinon, pc <= pc + 1.

-- En.
-- This block allows for a jump in address by incrementing the value of the pc variable, which points to the current instruction.
-- For example, in the case of a BEQ instruction, we test the equality between two variables (contained in the registers).
-- If the 'zero' result from the ALU is '1', then the new value of the pc (program counter) is the add_sum_result output.
-- Otherwise, pc <= pc + 1.
----------------------------------------------------------------------------------------------------


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
library work;
use work.constants_pkg.all;

entity add_sum is
    port (
        e1 : in std_logic_vector(INSTR_MEM_LENGTH - 1 downto 0);
        e2 : in std_logic_vector(DATA_LENGTH - 1 downto 0); -- signed
        add_sum_result : out std_logic_vector(INSTR_MEM_LENGTH - 1 downto 0)
    );
end add_sum;

architecture behav of add_sum is
    signal s_e2 : std_logic_vector(INSTR_MEM_LENGTH - 1 downto 0) := (others => '0');

begin

    s_e2 <= e2(INSTR_MEM_LENGTH - 1 downto 0);

    process(e1, e2)
    begin
        add_sum_result <= std_logic_vector(signed(e1) + signed(s_e2));
    end process;

end behav ; -- behav