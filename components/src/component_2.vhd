library IEEE;
use IEEE.STD_LOGIC_1164.all;

library work;
use work.constants.all;
use work.records.all;
use work.stages.all;

entity component_2 is
    port(
        clock : in std_logic;

        reg_data : in reg_record := zero_reg;

        jump_data : out jump_record := zero_jump;
        wb_data : out wb_record := zero_wb
    );
end entity;

architecture behav of component_2 is
    --Segnali per exec
    signal exec_data : exec_record := zero_exec;
    begin
        execute : exec
        port map(clock => clock, reg_data => reg_data,
                jump_data => jump_data, exec_data => exec_data);

        ram_wb : mem_wb
        port map(clock => clock,    exec_data => exec_data,
                wb_data => wb_data);
end architecture;