library ieee;
use ieee.std_logic_1164.all;

package constants_pkg is
    constant INSTR_MEM_LENGTH : integer := 4;
    constant DATA_LENGTH      : integer := 32;

    -- constants for the différent instrucitons section
    constant INSTR_LENGTH   : integer := 32;
    constant FUNCT7_H       : integer := 31;
    constant FUNCT7_L       : integer := 25;

    constant RS2_H          : integer := 24;
    constant RS2_L          : integer := 20;

    constant RS1_H          : integer := 19;
    constant RS1_L          : integer := 15;

    constant RD_H           : integer := 11;
    constant RD_L           : integer := 7;

    constant OPCODE_H       : integer := 6;
    constant OPCODE_L       : integer := 0;
    constant IMM_H          : integer := 31;
    constant I_IMM_L        : integer := 20;
    constant S_SB_IMM_L     : integer := 25;
    
end package constants_pkg;

package body constants_pkg is
end package body constants_pkg;
