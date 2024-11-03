LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

library work;
use work.constants.all;
use work.alu_lib.all;

entity alu_testbench is
end entity;

architecture behaviour of alu_testbench is
    type int_array is array (natural range<>) of integer;
    signal val_array : int_array(0 to 3) := (0, -1, 200, 3000);

    signal x, y, z : std_logic_vector(register_size - 1 downto 0);
    signal op : alu_op;

    begin

    alu_tb : alu
    port map(x => x, y => y, z => z, operation => op);

    process begin
        op <= OP_ADD;
        for i in val_array'range loop
            for j in val_array'range loop
                x <= std_logic_vector(to_signed(val_array(i), register_size));
                y <= std_logic_vector(to_signed(val_array(j), register_size));
                wait for 10 ns;
            end loop;
        end loop;
        op <= OP_EQ;
        for i in val_array'range loop
            for j in val_array'range loop
                x <= std_logic_vector(to_signed(val_array(i), register_size));
                y <= std_logic_vector(to_signed(val_array(j), register_size));
                wait for 10 ns;
            end loop;
        end loop;
        op <= OP_LT;
        for i in val_array'range loop
            for j in val_array'range loop
                x <= std_logic_vector(to_signed(val_array(i), register_size));
                y <= std_logic_vector(to_signed(val_array(j), register_size));
                wait for 10 ns;
            end loop;
        end loop;
        wait;
    end process;
end architecture;