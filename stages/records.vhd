LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

library work;
use work.constants.all;

package records is
    type fetch_record is record
        instruction : std_logic_vector(instruction_size - 1 downto 0);
        prog_count : std_logic_vector(register_size - 1 downto 0);
    end record;

    type jump_record is record
        jumping : std_logic;
        jump_dest : std_logic_vector(register_size - 1 downto 0);
    end record;

    type reg_record is record
        prog_count : std_logic_vector(register_size - 1 downto 0);
        rd : std_logic_vector(reg_address_size - 1 downto 0);
        rs1_val, rs2_val, immediate : std_logic_vector(register_size - 1 downto 0);
        instruction_type : inst_type;
    end record;

    type exec_record is record
        address, data : std_logic_vector(register_size - 1 downto 0);
        mem_type : mem_op;
    end record;

    type wb_record is record
        wb : std_logic;
        data : std_logic_vector(register_size - 1 downto 0);
        rd : std_logic_vector(reg_address_size - 1 downto 0);
    end record;

    -----------------------------------------------------

    constant zero_jump : jump_record := (
        jumping => '0',
        jump_dest => (others => '0')
    );

    constant zero_fetch : fetch_record := (
        instruction => (others => '0'),
        prog_count => (others => '0')
    );

    constant zero_reg : reg_record := (
        prog_count => (others => '0'),
        rd => (others => '0'),
        rs1_val => (others => '0'),
        rs2_val => (others => '0'),
        immediate => (others => '0'),
        instruction_type => INST_NOP
    );

    constant zero_wb : wb_record := (
        wb => '0',
        data => (others => '0'),
        rd => (others => '0')
    );

    constant zero_exec : exec_record := (
        address => (others => '0'),
        data => (others => '0'),
        mem_type => NOP
    );
end package;

