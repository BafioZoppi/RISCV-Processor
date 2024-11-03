LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

library work;
use work.constants.all;
use work.records.all;
use work.memory.all;
use work.alu_lib.all;
use work.stages.all;

entity ram_wb_testbench is
end entity;

architecture beha of ram_wb_testbench is
    signal clock : std_logic := '0';
    constant delay : time := 5 ns;

    signal exec_data : exec_record := zero_exec;
    signal wb_data : wb_record := zero_wb;
    begin
        clock <= not clock after delay;

        ram_wb_tb : mem_wb
        port map(clock => clock, exec_data => exec_data,
                wb_data => wb_data);

        process begin
            wait for delay;
                exec_data.address <= (register_size - 1 downto 5 => '0') & "01000";
                exec_data.data <= (register_size - 1 downto 5 => '0') & "11000";
            wait for delay*2;
                exec_data.mem_type <= STORE;
            wait for delay*2;
                exec_data.address <= (register_size - 1 downto 5 => '0') & "10000";
                exec_data.data <= (register_size - 1 downto 5 => '0') & "11001";
            wait for delay*2;
                exec_data.address <= (register_size - 1 downto 5 => '0') & "01000";
                exec_data.data <= (register_size - 1 downto 5 => '0') & "00001";
                exec_data.mem_type <= LOAD;
            wait for delay*2;
                exec_data.mem_type <= REG_WR;
            wait for delay*2;
                exec_data.mem_type <= NOP;
            wait;
        end process;
end architecture;