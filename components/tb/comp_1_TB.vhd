library IEEE;
use IEEE.STD_LOGIC_1164.all;

library work;
use work.constants.all;
use work.records.all;
--use work.proc_lib.all;
use work.comp_lib.all;

entity comp_1_testbench is
end entity;

architecture behav of comp_1_testbench is
    signal dummy_clock, clock, ready : std_logic := '0';
    constant delay : time := 5 ns;
    signal wb_data : wb_record := zero_wb;
    signal jump_data : jump_record := zero_jump;
    begin
        dummy_clock <= not dummy_clock after delay;
        clock <= dummy_clock when ready = '1'
                else '0';

        comp_1_tb : component_1
        port map(clock => clock, dummy_clock => dummy_clock,
        bin_file => "asm/test.bin",
        wb_data => wb_data, jump_data => jump_data, ready => ready);

        process begin
            wait for delay*3;
                wb_data.data <= (others => '1');
                wb_data.rd <= "00001";
                wb_data.wb <= '1';
            wait for delay*2;
                wb_data.wb <= '0';
            wait for delay*2;
                jump_data.jumping <= '1';
            wait for delay*2;
                jump_data.jumping <= '0';
            wait;
        end process;
end architecture;