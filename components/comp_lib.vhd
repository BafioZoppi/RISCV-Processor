library IEEE;
use IEEE.STD_LOGIC_1164.all;

library work;
use work.constants.all;
use work.records.all;

package comp_lib is
    component component_1 is
        port(
            clock, dummy_clock : in std_logic;
            wb_data : in wb_record;
            jump_data : in jump_record;
            bin_file : in string;
            ready : out std_logic;
            reg_data : out reg_record
        );
    end component;

    component component_2 is
        port(
            clock : in std_logic;
    
            reg_data : in reg_record := zero_reg;
    
            jump_data : out jump_record := zero_jump;
            wb_data : out wb_record := zero_wb
        );
    end component;

    component template is
        port(
            bin_file : in string := "asm/test.bin"
        );
    end component;
end package;