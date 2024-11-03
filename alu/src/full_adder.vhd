library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity full_adder is
    port(
        x, y, cin : in std_logic;
        z, cout : out std_logic
    );
end entity full_adder;

architecture behaviour of full_adder is
    begin
        z <= cin xor (x xor y);
        cout <= (cin and (x xor y)) or (x and y);
end architecture;