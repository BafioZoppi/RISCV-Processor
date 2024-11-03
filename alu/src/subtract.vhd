LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

library work;
use work.constants.all;
use work.alu_lib.all;

entity subtract is
    port(
        --cin : in std_logic;
        --overflow : out std_logic;
        x, y : in std_logic_vector(register_size - 1 downto 0);
        z : out std_logic_vector(register_size - 1 downto 0)
    );
end entity;

architecture behaviour of subtract is

    --constant cin : std_logic := '0';
    constant one : std_logic_vector(register_size - 1 downto 0) := std_logic_vector(to_unsigned(1, register_size));
    signal flipped : std_logic_vector(register_size - 1 downto 0);
    signal negated : std_logic_vector(register_size - 1 downto 0);

    begin
        flipped <= not y;
        flip : adder
        port map(x => one, y => flipped, z => negated);

        sub : adder
        port map(x => x, y => negated, z => z);
end architecture;