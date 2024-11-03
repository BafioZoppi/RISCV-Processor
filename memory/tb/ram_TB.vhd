LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

library work;
use work.constants.all;
use work.memory.all;

ENTITY ram_testbench is
END ram_testbench;

ARCHITECTURE ram_TB OF ram_testbench is
    signal clk : std_logic := '0';
    signal we : std_logic := '0';
    signal adr : std_logic_vector(register_size - 1 downto 0);
    signal din : std_logic_vector(register_size - 1 downto 0);
    signal dout : std_logic_vector(register_size - 1 downto 0);
    constant delay : time := 5 ns;
    begin
        ram_tb: sync_ram 
        port map(
            clock => clk,
            we => we,
            address => adr,
            datain => din,
            dataout => dout
        );
        clk <= not clk after 5 ns;
        process begin
            --wait for delay;
            --we <= '1';
            adr <= std_logic_vector(to_unsigned(10*8, register_size));
            din <= std_logic_vector(to_unsigned(8, register_size));
            wait for delay;
            wait for delay;
            we <= '0';
            wait for delay;
            we <= '1';
            --din <= std_logic_vector(to_unsigned(9, register_size));
            wait for delay;
            wait for delay;
            we <= '0';
            --din <= std_logic_vector(to_unsigned(10, register_size));
            wait for delay;
            adr <= std_logic_vector(to_unsigned(15*8, register_size));
            din <= std_logic_vector(to_unsigned(12, register_size));
            wait for delay;
            we <= '1';
            wait for delay;
            wait for delay;
            we <= '0';
            wait for delay;
            adr <= std_logic_vector(to_unsigned(15*8, register_size));
            wait for delay;
            wait for delay;
            adr <= std_logic_vector(to_unsigned(10*8, register_size));
            wait for delay;
            adr <= std_logic_vector(to_unsigned(9*8, register_size));
            wait for delay;
            wait;
        end process;
end architecture ram_TB;