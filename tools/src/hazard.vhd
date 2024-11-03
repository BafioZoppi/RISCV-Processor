library IEEE;
use IEEE.STD_LOGIC_1164.all;

library work;
use work.constants.all;

entity hazard is
    port(
        clock, pop : in std_logic := '0';

        rd, rs1, rs2 : in std_logic_vector(reg_address_size - 1 downto 0) := (others => '0');
        stall_flag : out std_logic := '0'
    );
end entity;

architecture behav of hazard is
    constant MAX : positive := 3;
    --Il primo e l'ultimo elemento di questo array non sono in realtà utilizzati dal programma
    --La loro unica utilità è quella di semplificare la logica in modo da poter descrivere
    --tutto il funzionamento dell'algoritmo in un unico generate
    type hazard_memory is array(-1 to MAX) of std_logic_vector(reg_address_size - 1 downto 0);
    signal haz_mem, future_mem : hazard_memory := (others => (others => '0'));
    signal stalling : std_logic := '0';
    signal conflict_vector, stall_vector : std_logic_vector(MAX downto 0) := (others => '0');
    begin

        mem_gen : for j in 0 to MAX - 1 generate
            future_mem(j) <= rd when haz_mem(j) = "00000" and haz_mem(j-1) /= "00000" and stalling = '0' and pop = '0'
                        else haz_mem(j+1) when rd = "00000" and pop = '1'
                        else haz_mem(j+1) when rd /= "00000" and stalling = '1' and pop = '1'
                        else rd           when rd /= "00000" and stalling = '0' and pop = '1' and haz_mem(j) /= "00000" and haz_mem(j+1) = "00000"
                        else haz_mem(j+1) when rd /= "00000" and stalling = '0' and pop = '1'
                        else haz_mem(j);
            conflict_vector(j) <= '1' when (rs1 = haz_mem(j) and rs1 /= "00000") or (rs2 = haz_mem(j) and rs2 /= "00000")
                                else '0';
            stall_vector(j) <= conflict_vector(j) or stall_vector(j + 1);
        end generate;

        stalling <= stall_vector(0);
        stall_flag <= stalling;

        process(clock) begin
            if rising_edge(clock) then
                haz_mem(-1) <= (others => '1');
                haz_mem(MAX) <= (others => '0');
                stall_vector(MAX) <= '0';

                for j in 0 to MAX - 1 loop
                    haz_mem(j) <= future_mem(j);
                end loop;
            end if;
        end process;
end architecture;