----------------------------------------------------------------------------------------------------
--    (c)2023 F. COLLIN
----------------------------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
library work;
use work.constants_pkg.all;

-- control unit of the core

entity control is
    port (
        -- opcode deside wich datapath will be taken !
        opcode : in std_logic_vector(6 downto 0);
        
        branch : out std_logic;
        mem_read : out std_logic;
        mem_to_reg : out std_logic;
        alu_op : out std_logic_vector(1 downto 0); -- + the instruction for the alu operation choice
        mem_write : out std_logic;
        alu_src : out std_logic;
        reg_write : out std_logic
    );
end control;

architecture behav of control is

begin

    process(opcode)
    begin
        case opcode is
            when "0110011" => -- R
                alu_src     <= '0';
                mem_to_reg  <= '0';
                reg_write   <= '1';
                mem_read    <= '0';
                mem_write   <= '0';
                branch      <= '0';
                alu_op      <= "10";
            when "0000011" => -- ld
                alu_src     <= '1';
                mem_to_reg  <= '1';
                reg_write   <= '1';
                mem_read    <= '1';
                mem_write   <= '0';
                branch      <= '0';
                alu_op      <= "00";
            when "0100011" => -- sd
                alu_src     <= '1';
                -- mem_to_reg  <=
                reg_write   <= '0';
                mem_read    <= '0';
                mem_write   <= '1';
                branch      <= '0';
                alu_op      <= "00";

            -- Imediate instruction
            when "0010011" => -- addi 
                -- e2 of alu come from the imm_gen
                alu_src <= '1';     -- come from imm gen I-instr
                mem_to_reg  <= '0'; -- no load (data mem jump)
                reg_write <= '1';   -- wb
                mem_read <= '0';    -- no memory read (data mem jump)
                mem_write <= '1';   -- addi result store in mem
                branch <= '0';      -- (no pc jump)
                alu_op <= "11";     -- unsigned add

            -- branch instruction
            when "1100011" => -- beq (equality) rs1 == rs2 ?
                alu_src     <= '0';
                -- mem_to_reg  <=
                reg_write   <= '0';
                mem_read    <= '0';
                mem_write   <= '0';
                branch      <= '1';
                alu_op      <= "01";
            
            when others => -- opcode ?? -- a definir le cas par default
                alu_src     <= '0';
                mem_to_reg  <= '0';
                reg_write   <= '0';
                mem_read    <= '0';
                mem_write   <= '0';
                branch      <= '0';
                alu_op      <= "00";         
                  
        end case;
    end process;

end behav ; -- behav