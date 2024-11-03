library ieee;
use ieee.std_logic_1164.all;

library work;
use work.constants.all;
use work.alu_lib.all;

entity alu is
    port(
        x, y : in std_logic_vector(register_size - 1 downto 0);
        operation : in alu_op;
        z : out std_logic_vector(register_size - 1 downto 0)
    );
end entity;

architecture behaviour of alu is
    signal add_res, eq_res, lt_res : std_logic_vector(register_size - 1 downto 0);

    begin

    eq : equals
    port map(x => x, y => y, z => eq_res);

    lt : less_than
    port map(x => x, y => y, z => lt_res);

    add : adder
    port map(x => x, y => y, z => add_res);

    z <= eq_res when operation = OP_EQ else
        add_res when operation = OP_ADD else
        lt_res;
end architecture;