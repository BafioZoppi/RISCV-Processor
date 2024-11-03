library IEEE;
use IEEE.STD_LOGIC_1164.all;

library work;
use work.comp_lib.all;

entity reg_wr_testbench is
end entity;

architecture behav of reg_wr_testbench is
    constant bin_file : string := "asm/reg_wr.bin";
    begin
        reg_wr_tb : template
        port map(bin_file => bin_file);
end architecture;