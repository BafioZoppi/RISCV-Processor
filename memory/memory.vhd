library IEEE;
use IEEE.STD_LOGIC_1164.all;

library work;
use work.constants.all;

package memory is
    component sync_ram is
        port (
          clock   : in  std_logic;
          we      : in  std_logic;
          address : in  std_logic_vector(register_size - 1 downto 0);
          datain  : in  std_logic_vector(register_size - 1 downto 0);
          dataout : out std_logic_vector(register_size - 1 downto 0)
        );
      end component sync_ram;

      component program_counter is
        port(
            din : in std_logic_vector(register_size - 1 downto 0);
            we : in std_logic := '0';
            clock : in std_logic;
            dout : out std_logic_vector(register_size - 1 downto 0)
        );
      end component;

      component regfile is
        Port ( 
            clk : in std_logic;
            din : in std_logic_vector(register_size - 1 downto 0);
            --rdA : in std_logic;
            --rdB : in std_logic;
            wr : in std_logic;
            rdA_A : in std_logic_vector(reg_address_size - 1 downto 0);
            rdA_B : in std_logic_vector(reg_address_size - 1 downto 0);
            wrA : in std_logic_vector(reg_address_size - 1 downto 0);
            doutA : out std_logic_vector(register_size - 1 downto 0);
            doutB : out std_logic_vector(register_size - 1 downto 0));
    end component;

    component instruction_memory is
      port (
        clock   : in  std_logic;
        address : in  std_logic_vector(register_size - 1 downto 0);
        --address_out non sta in instruction_memory_testbench perchè è stata implementata tardi
        address_out : out  std_logic_vector(register_size - 1 downto 0);
        ready : out std_logic := '0';
        in_file : in string;
        dataout : out std_logic_vector(instruction_size - 1 downto 0)
      );
  end component instruction_memory;
end package;