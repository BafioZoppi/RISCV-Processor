library IEEE;
use IEEE.STD_LOGIC_1164.all;

library work;
use work.constants.all;
--use work.records.all;

package tools is
    component decode is
        port(
            inst_in : in std_logic_vector(instruction_size - 1 downto 0);
    
            rd, rs1, rs2 : out std_logic_vector(reg_address_size - 1 downto 0) := (others => '0');
            inst_out : out inst_type;
            --inst_int : out integer; --Utile per debug!
            --alu_operation : out alu_op;
            immediate : out std_logic_vector(register_size - 1 downto 0)
        );
    end component;

    component hazard is
        port(
            clock, pop : in std_logic := '0';
    
            rd, rs1, rs2 : in std_logic_vector(reg_address_size - 1 downto 0) := (others => '0');
            stall_flag : out std_logic := '0'
        );
    end component;
end package;