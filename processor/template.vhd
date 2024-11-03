library IEEE;
use IEEE.STD_LOGIC_1164.all;

library work;
use work.constants.all;
use work.records.all;
--use work.proc_lib.all;
use work.comp_lib.all;

entity template is
    port(
        bin_file : in string := "asm/test.bin"
    );
end entity;

architecture behav of template is
    signal clock, dummy_clock, ready : std_logic := '0';
    constant delay : time := 5 ns;

    signal reg_data : reg_record := zero_reg;
    
    signal jump_data : jump_record := zero_jump;
    signal wb_data : wb_record := zero_wb;
    begin
        dummy_clock <= not dummy_clock after delay;
        clock <= dummy_clock when ready = '1'
                else '0';

        comp_1 : component_1
        port map(clock => clock, dummy_clock => dummy_clock,
        bin_file => bin_file, reg_data => reg_data,
        wb_data => wb_data, jump_data => jump_data, ready => ready);

        comp_2 : component_2
        port map(clock => clock,
        reg_data => reg_data,
        jump_data => jump_data,
        wb_data => wb_data);
end architecture;