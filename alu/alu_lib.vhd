library IEEE;
use IEEE.STD_LOGIC_1164.all;

library work;
use work.constants.all;

package alu_lib is
    component full_adder is
        port(
            x, y, cin : in std_logic;
            z, cout : out std_logic
        );
    end component full_adder;

    component adder is
        port(
            x, y : in std_logic_vector(register_size - 1 downto 0);
            z : out std_logic_vector(register_size - 1 downto 0)
        );
    end component;

    component subtract is
        port(
            x, y : in std_logic_vector(register_size - 1 downto 0);
            z : out std_logic_vector(register_size - 1 downto 0)
        );
    end component;

    component equals is
        port(
            x, y : in std_logic_vector(register_size - 1 downto 0);
            z : out std_logic_vector(register_size - 1 downto 0)
        );
    end component;

    component less_than is
        port(
            x, y : in std_logic_vector(register_size - 1 downto 0);
            z : out std_logic_vector(register_size - 1 downto 0)
        );
    end component;

    component alu is
        port(
            x, y : in std_logic_vector(register_size - 1 downto 0);
            operation : in alu_op;
            z : out std_logic_vector(register_size - 1 downto 0)
        );
    end component;
end package;