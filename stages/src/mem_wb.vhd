library ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

library work;
use work.constants.all;
use work.records.all;
use work.memory.all;
use work.alu_lib.all;

entity mem_wb is
    port(
        clock : std_logic;

        exec_data : in exec_record := zero_exec;
        wb_data : out wb_record := zero_wb
    );
end entity;

architecture behav of mem_wb is
    signal mem_type, saved_type : mem_op := NOP;
    --Segnali per la ram
    signal we : std_logic := '0';
    signal address, datain, dataout : std_logic_vector(register_size - 1 downto 0) := (others => '0');
    
    --Segnali per wb
    signal wb : std_logic := '0';
    signal data, saved_data : std_logic_vector(register_size - 1 downto 0) := (others => '0');
    signal rd, saved_rd : std_logic_vector(reg_address_size - 1 downto 0) := (others => '0');
    begin
        --Lettura input
        address <= exec_data.address;
        datain <= exec_data.data;
        mem_type <= exec_data.mem_type;

        --RAM
        ram : sync_ram
        port map(clock => clock,    we => we,
                address => address,
                datain => datain,   dataout => dataout);
        --Abilita scrittura RAM
        we <= '1' when mem_type = STORE
            else '0';

        --Selezione output
        wb <= '1' when (saved_type = LOAD or saved_type = REG_WR) and saved_rd /= "00000"
            else '0';
        data <= dataout when saved_type = LOAD
            else saved_data when saved_type = REG_WR
            else (others => '0');
        rd <= exec_data.data(reg_address_size - 1 downto 0) when mem_type = LOAD or mem_type = STORE
            else address(reg_address_size - 1 downto 0) when mem_type = REG_WR
            else (others => '0');

        --Scrittura output
        wb_data.wb <= wb;
        wb_data.data <= data when wb = '1'
                    else (others => '0');
        wb_data.rd <= saved_rd when wb = '1'
                    else (others => '0');

        process(clock) begin
            if rising_edge(clock) then
                saved_type <= mem_type;
                saved_data <= exec_data.data;
                saved_rd <= rd;
            end if;
        end process;
end architecture;