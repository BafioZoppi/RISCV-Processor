LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

library work;
use work.constants.all;
use work.records.all;
use work.memory.all;
use work.alu_lib.all;
use work.stages.all;

entity fetch_testbench is
end entity;

architecture beh of fetch_testbench is
    signal clock, dummy_clock : std_logic := '0';
    constant bin_file : string := "asm/test.bin";
    signal jump_data : jump_record := zero_jump;
    signal stall_flag : std_logic := '0';
    constant delay : time := 5 ns;
    signal ready : std_logic := '0';
    begin
        dummy_clock <= not dummy_clock after delay;
        clock <= dummy_clock when ready = '1'
                else '0';

        fetch_tb : fetch
        port map(clock => clock, dummy_clock => dummy_clock, ready => ready,
        bin_file => bin_file, jump_data => jump_data, stall_flag => stall_flag);

        process begin
            wait for delay*9;
            jump_data.jump_dest <= (63 downto 3 => '0') & "100";
            jump_data.jumping <= '1';
            wait for delay*2;
            jump_data.jumping <= '0';
            wait for delay*4;
            jump_data.jumping <= '1';
            jump_data.jump_dest <= (others => '0');
            wait for delay*12;
            jump_data.jumping <= '0';
            wait for delay*4;
            stall_flag <= '1';
            wait for delay*4;
            stall_flag <= '0';
            wait for delay*2;
            jump_data.jump_dest <= (63 downto 3 => '0') & "100";
            stall_flag <= '1';
            jump_data.jumping <= '1';
            wait for delay*4;
            jump_data.jumping <= '0';
            wait for delay*2;
            stall_flag <= '0';
            wait for delay*2;
            stall_flag <= '1';
            jump_data.jumping <= '1';
            wait for delay * 2;
            stall_flag <= '0';
            wait for delay * 2;
            jump_data.jumping <= '0';
            wait;
        end process;
end architecture;