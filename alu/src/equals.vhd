library ieee;
use ieee.std_logic_1164.all;

library work;
use work.constants.all;
use work.alu_lib.all;

entity equals is
    port(
        x, y : in std_logic_vector(register_size - 1 downto 0);
        z : out std_logic_vector(register_size - 1 downto 0)
    );
end entity;

architecture behaviour of equals is
    signal difference : std_logic_vector(register_size - 1 downto 0);
    constant zero : std_logic_vector(register_size - 1 downto 0) := (others => '0');
    begin
        sub : subtract
        port map (x => x, y => y, z => difference);
        z <= (register_size - 1 downto 1 => '0') & '1' when difference = zero
            else (register_size - 1 downto 1 => '0') & '0';
end architecture;