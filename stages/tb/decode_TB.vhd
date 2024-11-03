LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

library work;
use work.constants.all;
use work.records.all;
use work.memory.all;
use work.alu_lib.all;
use work.stages.all;
use work.tools.all;

entity decode_testbench is
end entity;

architecture beh of decode_testbench is
    signal clock, dummy_clock : std_logic := '0';
    constant bin_file : string := "asm/test.bin";

    signal fetch_data : fetch_record := zero_fetch;

    constant delay : time := 5 ns;
    begin
        dummy_clock <= not dummy_clock after delay;
        clock <= dummy_clock when dummy_clock = '1'
                else '0';

        fetch_tb : fetch
        port map(clock => clock, dummy_clock => dummy_clock,
        bin_file => bin_file, jump_data => zero_jump, stall_flag => '0',
        fetch_data => fetch_data);

        id_tb : decode 
        port map(inst_in => fetch_data.instruction);
end architecture;