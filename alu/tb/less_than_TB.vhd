library IEEE;
use IEEE.STD_LOGIC_1164.all;
USE ieee.numeric_std.ALL;

library work;
use work.constants.all;
use work.alu_lib.all;

entity less_than_testbench is
end entity;

architecture behaviour of less_than_testbench is
    signal x, y : std_logic_vector(register_size - 1 downto 0);
    signal z : std_logic_vector(register_size - 1 downto 0);

    begin
        lt_tb : less_than
        port map(x => x, y => y, z => z);

        process begin
            x <= std_logic_vector(to_signed(-5, register_size));
            y <= std_logic_vector(to_signed(7, register_size));
            wait for 50 ns;
            y <= std_logic_vector(to_signed(-5, register_size));
            wait for 50 ns;
            x <= std_logic_vector(to_signed(10, register_size));
            wait for 50 ns;
            wait;
        end process;
end architecture;