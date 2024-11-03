library IEEE;
use IEEE.STD_LOGIC_1164.all;

library work;
use work.constants.all;
use work.alu_lib.all;

--mi servono a qualcosa cin e overflow?
--credo di no --> per il momento li rimuovo

entity adder is
    port(
        --cin : in std_logic;
        --overflow : out std_logic;
        x, y : in std_logic_vector(register_size - 1 downto 0);
        z : out std_logic_vector(register_size - 1 downto 0)
    );
end entity;

architecture behaviour of adder is
    signal carry : std_logic_vector(register_size downto 0);
    signal temp : std_logic_vector(register_size - 1 downto 0);

    begin
        --carry(0) <= 'cin';
        --overflow <= carry(int_size);
        carry(0) <= '0';
        gen : for j in register_size - 1 downto 0 generate
            add : full_adder
            port map(
                x => x(j),
                y => y(j),
                z => z(j),
                cin => carry(j),
                cout => carry(j + 1)
            );
        end generate;
end architecture;