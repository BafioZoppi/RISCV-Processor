library IEEE;
use IEEE.STD_LOGIC_1164.all;

library work;
use work.constants.all;
use work.records.all;
--use work.proc_lib.all;
use work.tools.all;
use work.memory.all;

entity register_decode is
    port(
        clock : in std_logic;
        fetch_data : in fetch_record := zero_fetch;

        flush : in std_logic := '0';
        wb_data : in wb_record := zero_wb;
        
        reg_data : out reg_record := zero_reg;
        stall_flag : out std_logic := '0'
    );
end entity;

architecture behavior of register_decode is
    --segnali per decode
    signal inst_in : std_logic_vector(instruction_size - 1 downto 0) := (others => '0');
    signal rd, rs1, rs2 : std_logic_vector(reg_address_size - 1 downto 0) := (others => '0');
    signal inst_out : inst_type := INST_NOP;
    signal immediate : std_logic_vector(register_size - 1 downto 0);

    --Segnali per hazard
    signal haz_rd : std_logic_vector(reg_address_size - 1 downto 0) := (others => '0');
    signal stalling, pop : std_logic := '0';

    --Segnali per i registri
    signal wr_adr : std_logic_vector(reg_address_size - 1 downto 0) := (others => '0');
    signal wr_en : std_logic := '0';
    signal rs1_val, rs2_val, wr_data : std_logic_vector(register_size - 1 downto 0) := (others => '0');
    
    --Segnali per output
    signal instruction_type : inst_type := INST_NOP;
    begin
        id : decode
        port map(inst_in => inst_in,
        rd => rd,   rs1 => rs1,    rs2 => rs2,
        inst_out => inst_out,     immediate => immediate);
        inst_in <= fetch_data.instruction;

        registri : regfile
        port map(clk => clock,
                din => wr_data, wr => wr_en, wrA => wr_adr,
                rdA_A => rs1, doutA => rs1_val,
                rdA_B => rs2, doutB => rs2_val);

        haz_detect : hazard
        port map(clock => clock, pop => pop,
        rd => haz_rd,   rs1 => rs1,     rs2 => rs2,
        stall_flag => stalling);
        haz_rd <= (others => '0') when instruction_type = INST_NOP
                else rd;
        pop <= wb_data.wb;
        stall_flag <= stalling;

        wr_en <= wb_data.wb;
        wr_data <= wb_data.data;
        wr_adr <= wb_data.rd;

        instruction_type <= INST_NOP when flush = '1' or stalling = '1'
                        else inst_out;

        process(clock) begin
            if rising_edge(clock) then
                reg_data.prog_count <= fetch_data.prog_count;
                reg_data.rd <= rd;
                reg_data.rs1_val <= rs1_val;
                reg_data.rs2_val <= rs2_val;
                reg_data.immediate <= immediate;
                reg_data.instruction_type <= instruction_type;
            end if;
        end process;
end architecture;