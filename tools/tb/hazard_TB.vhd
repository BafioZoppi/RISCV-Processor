library IEEE;
use IEEE.STD_LOGIC_1164.all;

library work;
use work.constants.all;
use work.tools.all;

entity hazard_testbench is
end entity;

architecture arch of hazard_testbench is
    signal clock : std_logic := '0';
    constant delay : time := 5 ns;

    signal pop, stall_flag : std_logic := '0';
    signal rd, rs1, rs2 : std_logic_vector(reg_address_size - 1 downto 0) := (others => '0');
    begin
        clock <= not clock after delay;

        hazard_tb : hazard
        port map(clock => clock, pop => pop,
        rd => rd, rs1 => rs1, rs2 => rs2,
        stall_flag => stall_flag);

        process begin
            wait for delay*3;
            rd <= "11111";
            rs1 <= "11111";
            wait for delay*8;
            rd <= "00000";
            pop <= '1';
            wait for delay*2;
            pop <= '0';
            rs1 <= "00000";
            wait for delay*2;
            rd <= "11111";
            wait for delay*4;
            rd <= "10001";
            wait for delay*4;
            rd <= "00000";
            wait for delay*2;
            rs1 <= "11111";
            rd <= "00001";
            wait for delay*2;
            pop <= '1';
            wait for delay*6;
            pop <= '0';
            wait for delay*4;
            rs2 <= "00001";
            wait for delay*2;
            pop <= '1';
            wait;
        end process;
end architecture;