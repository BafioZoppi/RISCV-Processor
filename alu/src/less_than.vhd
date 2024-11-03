library ieee;
use ieee.std_logic_1164.all;

library work;
use work.constants.all;
use work.alu_lib.all;

entity less_than is
    port(
        x, y : in std_logic_vector(register_size - 1 downto 0);
        z : out std_logic_vector(register_size - 1 downto 0)
    );
end entity;

architecture behaviour of less_than is
    signal difference : std_logic_vector(register_size - 1 downto 0);
    begin
        sub : subtract
        port map (x => x, y => y, z => difference);
        z <= (register_size - 1 downto 1 => '0') & difference(register_size - 1);
end architecture;