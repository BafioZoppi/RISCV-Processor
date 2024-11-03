library IEEE;
use IEEE.STD_LOGIC_1164.all;

library work;
use work.constants.all;
use work.records.all;
use work.stages.all;

entity component_1 is
    port(
            clock, dummy_clock : in std_logic;
            wb_data : in wb_record := zero_wb;
            jump_data : in jump_record := zero_jump;
            ready : out std_logic := '0';
            bin_file : in string := "asm/test.bin";
            reg_data : out reg_record := zero_reg
    );
end entity;

architecture beh of component_1 is 

    signal fetch_data : fetch_record := zero_fetch;
    signal stall_flag : std_logic := '0';

    begin
        fetch_tb : fetch
        port map(clock => clock, dummy_clock => dummy_clock, ready => ready,
        bin_file => bin_file, jump_data => jump_data, stall_flag => stall_flag,
        fetch_data => fetch_data);

        reg_id_tb : register_decode
        port map(clock => clock, fetch_data => fetch_data,
        flush => jump_data.jumping, wb_data => wb_data,
        stall_flag => stall_flag, reg_data => reg_data);
end architecture;