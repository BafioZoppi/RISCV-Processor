library IEEE;
use IEEE.STD_LOGIC_1164.all;

library work;
use work.comp_lib.all;

entity bubble_sort is
end entity;

architecture behav of bubble_sort is
    constant bin_file : string := "asm/bubble_sort.bin";
    begin
        bubble_sort_tb : template
        port map(bin_file => bin_file);
end architecture;