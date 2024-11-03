library ieee;
use ieee.std_logic_1164.all;
use IEEE.Numeric_Std.all;
use std.textio.all;

library work;
use work.constants.all;
use work.memory.all;

entity instruction_memory is
    port (
      clock   : in  std_logic;
      address : in  std_logic_vector(register_size - 1 downto 0);
      --address_out non sta in ram_testbench perchè è stata implementata tardi
      address_out : out  std_logic_vector(register_size - 1 downto 0) := (others => '0');
      ready : out std_logic := '0';
      in_file : in string;
      dataout : out std_logic_vector(instruction_size - 1 downto 0) := (others => '0')
    );
end entity instruction_memory;

architecture behavoiur of instruction_memory is
    type inst_file is file of character;
    type ram_type is array (0 to max_inst-1) of std_logic_vector(ram_data_size -1 downto 0);    
    
    begin
        instructionProcess : process(clock)

        --queste variabili servono solo durante il setup
        variable char : character;
        file myfile : inst_file;
        variable index : natural := 0;

        --queste variabili servono per l'esecuzione
        variable is_ready : std_logic := '0';
        variable ram : ram_type := (others => (others => '0'));
        begin
            ready <= is_ready;
            if rising_edge(clock) then
                --questa parte di codice è eseguita durante l'esecuzione regolare
                if is_ready = '1' then
                    for j in 0 to 3 loop
                        dataout((j+1)*8 - 1 downto j*8) <= ram(to_integer(unsigned(address)) + j);
                    end loop;
                    address_out <= address;
                --qui invece avviene il setup
                elsif is_ready = '0' then
                    --dataout <= (others => '0');
                    index := 0;
                    file_open(myfile, in_file);
                    while not endfile(myfile) loop
                        read(myfile, char);
                        ram(index) := std_logic_vector(to_unsigned(character'pos(char), 8));
                        index := index + 1;
                    end loop;
                    file_close(myfile);
                    is_ready := '1';
                end if;
            end if;
        end process;
end architecture;