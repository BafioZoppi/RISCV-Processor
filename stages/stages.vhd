library IEEE;
use IEEE.STD_LOGIC_1164.all;

library work;
use work.constants.all;
use work.records.all;

package stages is
    component fetch is
        port(
            clock, dummy_clock : in std_logic;
            bin_file : in string := "asm/test.bin";

            jump_data : in jump_record;
            stall_flag : in std_logic := '0';
            fetch_data : out fetch_record;

            ready : out std_logic
        );
    end component;

    component register_decode is
        port(
            clock : in std_logic;
            fetch_data : in fetch_record;

            flush : in std_logic;
            wb_data : in wb_record;
            
            reg_data : out reg_record;
            stall_flag : out std_logic := '0'
        );
    end component;

    component exec is
        port(
            clock : std_logic;
    
            reg_data : in reg_record := zero_reg;
            jump_data : out jump_record := zero_jump;
            exec_data : out exec_record := zero_exec
        );
    end component;

    component mem_wb is
        port(
            clock : std_logic;
    
            exec_data : in exec_record := zero_exec;
            wb_data : out wb_record := zero_wb
        );
    end component;
end package;