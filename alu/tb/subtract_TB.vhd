LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

library work;
use work.constants.all;
use work.alu_lib.all;

entity subtract_testbench is
end entity;

architecture subtract_TB of subtract_testbench is
    --il funzionamento è analogo a n_bit_adder
    type int_array is array (natural range<>) of natural;
    
    signal x_array : int_array(0 to 3) := (0, 1, 200, 3000);
    signal y_array : int_array(0 to 3) := (20, 31, 500, 100);
    signal x, y, z : std_logic_vector(register_size - 1 downto 0);


    begin
        subtract_tb : subtract
        port map(
            x => x,
            y => y,
            z => z
            --cin => cin,
            --overflow => overflow
        );

        --cin <= '1';
        process begin
            --cin <= not cin;
            for i in x_array'range loop
                for j in y_array'range loop
                    x <= std_logic_vector(to_unsigned(x_array(i), register_size));
                    y <= std_logic_vector(to_unsigned(y_array(j), register_size));
                    wait for 10 ns;
                end loop;
            end loop;
            wait;
        end process;
end architecture;