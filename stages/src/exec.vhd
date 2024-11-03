library ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

library work;
use work.constants.all;
use work.records.all;
use work.memory.all;
use work.alu_lib.all;

entity exec is
    port(
        clock : std_logic;
    
        reg_data : in reg_record := zero_reg;
        jump_data : out jump_record := zero_jump;
        exec_data : out exec_record := zero_exec
    );
end entity;

architecture behav of exec is
    constant one : std_logic_vector(register_size - 1 downto 0) := (register_size - 1 downto 1 => '0') & '1';
    --Segnali per lettura input
    signal prog_count, rs1_val, rs2_val, immediate : std_logic_vector(register_size - 1 downto 0) := (others => '0');
    signal rd : std_logic_vector(reg_address_size - 1 downto 0) := (others => '0');
    signal instruction_type : inst_type := INST_NOP;

    --Segnali per ALU
    signal x, y, z : std_logic_vector(register_size - 1 downto 0);
    signal alu_type : alu_op := OP_ADD;

    --Segnali per output
    signal jump_dest, address, data : std_logic_vector(register_size - 1 downto 0) := (others => '0');
    signal jumping : std_logic := '0';
    signal mem_type : mem_op := NOP;
    begin
        --Lettura input
        prog_count <= reg_data.prog_count;
        rd <= reg_data.rd;
        rs1_val <= reg_data.rs1_val;
        rs2_val <= reg_data.rs2_val;
        immediate <= reg_data.immediate;
        instruction_type <= reg_data.instruction_type;

        --Calcolo jump destination
        jump_calc : adder
        port map(x => prog_count, y => immediate, z => jump_dest);

        --Main ALU
        main_alu : alu
        port map(x => x, y => y, z => z, operation => alu_type);
        --Selezione input ALU
        x <= rs1_val;
        y <= immediate when instruction_type = INST_ADDI or instruction_type = INST_LD or instruction_type = INST_SD
            else rs2_val;
        alu_type <= OP_EQ when instruction_type = INST_BEQ
            else OP_LT when instruction_type = INST_BLT
            else OP_ADD;

        --Selezione output
        mem_type <= REG_WR when instruction_type = INST_ADD or instruction_type = INST_ADDI
                else STORE when instruction_type = INST_SD
                else LOAD  when instruction_type = INST_LD
                else NOP;
        --ATTENZIONE! ld usa address come indirizzo per la ram e data come indirizzo di destinazione!
        data <= z when mem_type = REG_WR
                else rs2_val when mem_type = STORE
                else (register_size - 1 downto reg_address_size => '0') & rd when mem_type = LOAD
                else (others => '0');
        address <= z when mem_type = LOAD or mem_type = STORE
                else (register_size - 1 downto reg_address_size => '0') & rd when mem_type = REG_WR
                else (others => '0');
        jumping <= '1' when (instruction_type = INST_BEQ or instruction_type = INST_BLT) and z = one
                else '0';

        --SCrittura jump
        jump_data.jumping <= jumping;
        jump_data.jump_dest <= jump_dest;

        --Scrittura di exec_data
        process(clock) begin
            if rising_edge(clock) then
                exec_data.address <= address;
                exec_data.data <= data;
                exec_data.mem_type <= mem_type;
            end if;
        end process;
end architecture;