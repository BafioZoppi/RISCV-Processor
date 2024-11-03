LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

library work;
use work.constants.all;
use work.alu_lib.all;

entity adder_testbench is
end entity;

architecture adder_TB of adder_testbench is
    --non posso creare dei natural troppo grandi, ma vorrei comunque testare gli overflow
    --soluzione: creo un valore biggest che contiene il numero massimo
    signal x, y, z, biggest : std_logic_vector(register_size - 1 downto 0);
    type int_array is array (natural range<>) of natural;
    
    signal x_array : int_array(0 to 3) := (0, 1, 200, 3000);
    signal y_array : int_array(0 to 3) := (20, 31, 500, 100);
    begin
        adder_tb : adder
        port map(
            --cin => cin,
            --overflow => overflow,
            x => x,
            y => y,
            z => z
        );

        --cin <= '1';
        process begin
            --cin <= not cin;
            for j in biggest'range loop
                biggest(j) <= '1';
            end loop;
            wait for 10 ns;
            --test per overflow
            y <= biggest;
            for i in x_array'range loop
                x <= std_logic_vector(to_unsigned(x_array(i), register_size));
                wait for 10 ns;
            end loop;
            --test privo di overflow
            for i in x_array'range loop
                for j in y_array'range loop
                    x <= std_logic_vector(to_unsigned(x_array(i), register_size));
                    y <= std_logic_vector(to_unsigned(y_array(j), register_size));
                    wait for 10 ns;
                end loop;
            end loop;
        end process;
end architecture;