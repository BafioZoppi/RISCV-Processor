LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

library work;
use work.constants.all;
use work.memory.all;

entity instruction_memory_testbench is
end entity;

architecture behaviour of instruction_memory_testbench is
    signal clock : std_logic := '0';
    signal address : std_logic_vector(register_size - 1 downto 0) := (others => '0');
    signal dout : std_logic_vector(instruction_size - 1 downto 0);
    signal ready : std_logic;
    signal index : natural := 0;
    constant in_file : string := "asm/test.bin";
    constant delay : time := 10 ns;

    --signal load_me : std_logic;

    begin
        instruction_tb : instruction_memory
        port map(clock => clock, address => address,
        dataout => dout, ready => ready, in_file => in_file);
        clock <= not clock after delay;

        process begin
            --report "eee";
            wait for delay;
            if ready = '1' then
                --Aspetta un paio di cicli
                wait for delay;
                while index < 40 loop
                    address <= std_logic_vector(to_unsigned(index, register_size));
                    index <= index + 4;
                    wait for delay;
                    wait for delay;
                end loop;
                wait for delay;
                address <= std_logic_vector(to_unsigned(16, register_size));
                wait for delay;
                address <= std_logic_vector(to_unsigned(8, register_size));
                wait for delay;
                address <= std_logic_vector(to_unsigned(12, register_size));
                wait for delay;
                address <= std_logic_vector(to_unsigned(20, register_size));
                wait for delay;
                wait for delay;
                wait for delay;
                wait for delay;
                address <= std_logic_vector(to_unsigned(4, register_size));
                wait for delay;
                address <= std_logic_vector(to_unsigned(8, register_size));
                wait for delay;
                address <= std_logic_vector(to_unsigned(16, register_size));
                wait for delay;
                --report "asd";
                --report "qqq";
                wait;
            end if;
        end process;
end architecture;