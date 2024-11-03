library IEEE;
use IEEE.STD_LOGIC_1164.all;

library work;
use work.comp_lib.all;

entity hazard_bin_testbench is
end entity;

architecture behav of hazard_bin_testbench is
    constant bin_file : string := "asm/hazard.bin";
    begin
        reg_wr_tb : template
        port map(bin_file => bin_file);
end architecture;