LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

library work;
use work.constants.all;
use work.records.all;
use work.memory.all;
use work.alu_lib.all;

entity fetch is
    port(
        clock, dummy_clock : in std_logic;
        bin_file : in string := "asm/test.bin";

        jump_data : in jump_record := zero_jump;
        stall_flag : in std_logic := '0';
        fetch_data : out fetch_record := zero_fetch;

        ready : out std_logic := '0'
    );
end entity;

architecture beha of fetch is
    --Segnali per instruction_memory
    signal address_in, address_out : std_logic_vector(register_size - 1 downto 0) := (others => '0');
    signal is_ready : std_logic := '0';
    signal instruction : std_logic_vector(instruction_size -1 downto 0) := (others => '0');

    --Segnali per program_counter
    signal pc_in, pc_out : std_logic_vector(register_size - 1 downto 0) := (others => '0');
    signal pc_we : std_logic := '0';

    --Segnali per avanzamento pc
    signal adv_x, adv_y, adv_z : std_logic_vector(register_size - 1 downto 0) := (others => '0');
    constant increment : std_logic_vector(register_size - 1 downto 0) := (register_size - 1 downto 3 => '0') & "100";

    --Segnali per branching
    signal current_addr : std_logic_vector(register_size - 1 downto 0) := (others => '0');
    
    begin
        current_addr <= jump_data.jump_dest when jump_data.jumping = '1'
                    else address_out when stall_flag = '1'
                    else pc_out;
        
        inst_mem : instruction_memory
        port map(clock => dummy_clock, address => address_in, address_out => address_out,
        ready => is_ready, in_file => bin_file, dataout => instruction);

        address_in <= current_addr;

        prog_count : program_counter
        port map(clock => clock, din => pc_in, dout => pc_out, we => pc_we);
        pc_we <= is_ready;

        count_advance : adder
        port map(x => adv_x, y => adv_y, z => adv_z);

        adv_x <= current_addr;
        adv_y <= increment;
        pc_in <= adv_z;

        --Output
        ready <= is_ready;
        fetch_data.prog_count <= address_out;
        fetch_data.instruction <= (others => '0') when jump_data.jumping = '1' else instruction;
end architecture;