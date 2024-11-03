LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

library work;
use work.constants.all;

entity program_counter is
    port(
        din : in std_logic_vector(register_size - 1 downto 0);
        we : in std_logic := '0';
        clock : in std_logic;
        dout : out std_logic_vector(register_size - 1 downto 0) := (others => '0')
    );
end entity;

architecture behaviour of program_counter is
    signal status : std_logic_vector(register_size - 1 downto 0) := (others => '0');

    begin
        process(clock) begin
            if rising_edge(clock) and we = '1' then
                status <= din;
            end if;
        end process;

        dout <= status;
end architecture;