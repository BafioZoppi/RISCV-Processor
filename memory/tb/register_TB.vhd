LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

library work;
use work.constants.all;
use work.memory.all;

ENTITY register_testbench IS
END register_testbench;

ARCHITECTURE behaviour OF register_testbench IS

SIGNAL clk : std_logic := '0';
SIGNAL din : std_logic_vector(register_size - 1 downto 0);
--SIGNAL rdA : std_logic := '0';
--SIGNAL rdB : std_logic := '0';
SIGNAL wr : std_logic := '0';
SIGNAL rdA_A : std_logic_vector(reg_address_size - 1 downto 0);
SIGNAL rdA_B : std_logic_vector(reg_address_size - 1 downto 0);
SIGNAL wrA : std_logic_vector(reg_address_size - 1 downto 0);
SIGNAL doutA : std_logic_vector(register_size - 1 downto 0);
SIGNAL doutB : std_logic_vector(register_size - 1 downto 0);

type int_array is array (natural range<>) of natural;
    
signal x_array : int_array(0 to 3) := (0, 1, 15, 25);
signal y_array : int_array(0 to 3) := (20, 31, 500, 100);

type adr_array is array (natural range<>) of std_logic_vector(reg_address_size - 1 downto 0);
signal adr : adr_array(0 to 3);
type data_array is array (natural range<>) of std_logic_vector(register_size - 1 downto 0);
signal data : data_array(0 to 3);

constant delay : time := 10 ns;
constant half_delay : time := 5 ns;
BEGIN
    register_tb: regfile
    PORT MAP(
        clk => clk,
        din => din,
        --rdA => rdA,
        --rdB => rdB,
        wr => wr,
        rdA_A => rdA_A,
        rdA_B => rdA_B,
        wrA => wrA,
        doutA => doutA,
        doutB => doutB
    );
-- *** Test Bench - User Defined Section ***
    clk <= not clk after half_delay;
    tb : PROCESS
    BEGIN
        wait for half_delay;
        for i in x_array'range loop
            adr(i) <= std_logic_vector(to_unsigned(x_array(i), reg_address_size));
            data(i) <= std_logic_vector(to_unsigned(y_array(i), register_size));
        end loop;
        wait for delay;
        wait for delay;
        din <= data(1);
        rdA_A <= adr(1);
        --rdA <= '1';
        wrA <= adr(1);
        wr <= '1';
        wait for delay;
        wr <= '0';
        wait for delay;
        --rdB <= '1';
        rdA_B <= adr(0);
        wrA <= adr(0);
        wr <= '1';
        wait for delay;
        wait for delay;
        wr <= '0';
        wait for delay;
        rdA_A <= adr(2);
        wait for delay;
        rdA_A <= adr(1);
        wait for delay;
        rdA_A <= adr(2);
        wait for delay;
        rdA_A <= adr(1);
        wait for delay;
        wrA <= adr(1);
        din <= data(3);
        wait for delay;
        wr <= '1';
        wait for delay;
        wr <= '0';
        wait for delay;
        din <= data(2);
        wait for delay;
        wr <= '1';
        wait for delay;
        wr <= '0';
        wait;
    END PROCESS;
END;
-- *** End Test Bench - User Defined Section ***