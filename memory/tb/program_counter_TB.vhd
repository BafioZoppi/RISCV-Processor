LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

library work;
use work.constants.all;
use work.memory.all;

entity program_counter_testbench is
end entity;

architecture behavoiur of program_counter_testbench is
    signal we : std_logic := '0';
    signal clock : std_logic := '0';
    signal din, dout : std_logic_vector(register_size - 1 downto 0);

    constant delay : time := 5 ns;
    begin
        pc_tb : program_counter
        port map(clock => clock,
        we => we,
        din => din, dout => dout);

        clock <= not clock after delay;

        process begin
            din <= std_logic_vector(to_unsigned(20, register_size));
            wait for delay;
            wait for delay;    
            wait for delay;            
            we <= '1';
            wait for delay;
            wait for delay;
            we <= '0';
            wait for delay;    
            wait for delay;
            wait for delay;
            wait for delay;
            din <= std_logic_vector(to_unsigned(99, register_size));
            wait for delay;
            wait for delay;
            wait for delay;
            wait for delay;
            we <= '1';
            wait for delay;
            wait for delay;
            we <= '0';
            wait for delay;
            wait for delay;
            din <= std_logic_vector(to_unsigned(700, register_size));
            wait for delay;
            wait for delay;
            we <= '1';
            wait for delay;
            wait for delay;
            we <= '0';
            wait;
        end process;
end architecture;