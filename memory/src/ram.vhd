-- Simple generic RAM Model
--
-- +-----------------------------+
-- |    Copyright 2008 DOULOS    |
-- |   designer :  JK            |
-- +-----------------------------+

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.Numeric_Std.all;

library work;
use work.constants.all;
use work.memory.all;

entity sync_ram is
  port (
    clock   : in  std_logic;
    we      : in  std_logic;
    address : in  std_logic_vector(register_size - 1 downto 0);
    datain  : in  std_logic_vector(register_size - 1 downto 0);
    dataout : out std_logic_vector(register_size - 1 downto 0)
  );
end entity sync_ram;

architecture RTL of sync_ram is
   type ram_type is array (0 to max_ram-1) of std_logic_vector(ram_data_size - 1 downto 0);
   signal ram : ram_type := (others => (others => '0'));
   signal read_address : std_logic_vector(register_size - 1 downto 0) := (others => '0');

   type ram_debug is array(0 to 10) of std_logic_vector(register_size - 1 downto 0);
   signal ram_dbg : ram_debug := (others => (others => '0'));

begin

  RamProc: process(clock) is
  begin
    if rising_edge(clock) then
      if we = '1' then
        for j in 0 to 7 loop
          ram(to_integer(unsigned(address)) + j) <= datain((j+1)*8 - 1 downto j*8);
        end loop;
      end if;
      read_address <= address;
    end if;

  end process RamProc;

    gen_loop: for j in 0 to 7 generate
      dataout((j+1)*8 - 1 downto j*8) <= ram(to_integer(unsigned(read_address)) + j);
    end generate gen_loop;

  --DEBUG
  gen_debug : for j in 0 to 10 generate
          in_loop : for k in 0 to 7 generate
            ram_dbg(j)((k+1)*8-1 downto k*8) <= ram(j*8 + k);
          end generate;
  end generate;

end architecture RTL;