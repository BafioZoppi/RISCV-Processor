LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

library work;
use work.constants.all;
use work.alu_lib.all;

entity full_adder_testbench is
end entity;

architecture full_adder_tb of full_adder_testbench is
    signal params_in : std_logic_vector(2 downto 0);
    signal params_out : std_logic_vector(1 downto 0);

    begin
        full_adder_tb : full_adder
        port map(
            x => params_in(0),
            y => params_in(1),
            cin => params_in(2),
            z => params_out(0),
            cout => params_out(1)
        );

    process begin
        params_in <= "000";
        wait for 10 ns;
        params_in <= "001";
        wait for 10 ns;
        params_in <= "010";
        wait for 10 ns;
        params_in <= "100";
        wait for 10 ns;
        params_in <= "011";
        wait for 10 ns;
        params_in <= "101";
        wait for 10 ns;
        params_in <= "110";
        wait for 10 ns;
        params_in <= "111";
        wait for 10 ns;
        wait;
    end process;
end architecture;