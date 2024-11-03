library IEEE;
use IEEE.STD_LOGIC_1164.all;

library work;
--use work.constants.all;
--use work.records.all;
--use work.proc_lib.all;
use work.comp_lib.all;

entity ldsd_testbench is
end entity;

architecture behav of ldsd_testbench is
    constant bin_file : string := "asm/ldsd.bin";
    begin
        ldsd_rb : template
        port map(bin_file => bin_file);
end architecture;