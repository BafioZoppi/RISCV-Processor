library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE ieee.numeric_std.ALL;

library work;
use work.constants.all;
use work.memory.all;

entity regfile is
    Port ( 
        clk : in std_logic;
        --qui c'è il dato di input
        din : in std_logic_vector(register_size - 1 downto 0);
        --questi decidono se leggere i dati o meno
        --rdA : in std_logic;
        --rdB : in std_logic;
        --questo decide se scrivere i dati
        wr : in std_logic;
        --gli indirizzi dei registri da leggere
        rdA_A : in std_logic_vector(reg_address_size - 1 downto 0);
        rdA_B : in std_logic_vector(reg_address_size - 1 downto 0);
        --indirizzo del registro da scrivere
        wrA : in std_logic_vector(reg_address_size - 1 downto 0);
        --dati di output
        doutA : out std_logic_vector(register_size - 1 downto 0);
        doutB : out std_logic_vector(register_size - 1 downto 0));
end regfile;
    
architecture Behavioral of regfile is
    type memory_array is array(2**reg_address_size - 1 downto 0) of std_logic_vector(register_size - 1 downto 0);
    signal rfile : memory_array := (others => (others => '0'));
    constant zero : std_logic_vector(reg_address_size - 1 downto 0) := (others => '0');

begin
    process(clk)
    begin
        if rising_edge(clk) then
            if (wr = '1') and wrA /= zero then
                rfile(to_integer(unsigned(wrA))) <= din;
            end if;
        end if;
    end process;

    doutA <= rfile(to_integer(unsigned(rdA_A)));
    doutB <= rfile(to_integer(unsigned(rdA_B)));
end Behavioral;