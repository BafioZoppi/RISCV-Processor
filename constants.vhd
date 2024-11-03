library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

package constants is
    constant reg_address_size : positive := 5; --2**5 = 32
    constant register_size : positive := 64;
    constant instruction_size : positive := 32;
    constant register_num : positive := 32;
    constant instruction_bytes : positive := 4;
    constant max_ram : positive := 10000; --con 2**20 fallisce la simulazione
    constant max_inst : positive := 10000;
    constant ram_data_size : positive := 8; --la ram è indicizzata per byte!
    --constant bin_file : string := "c_code/bubble_sort.bin";
    
    constant opcode_size : positive := 7;
    constant rd_size, rs1_size, rs2_size : positive := reg_address_size;
    constant funct3_size : positive := 3;
    constant funct7_size : positive := 7;
    constant immediate_size : positive := 12;

    constant add_op     : std_logic_vector(opcode_size - 1 downto 0) := "0110011";
    constant addi_op    : std_logic_vector(opcode_size - 1 downto 0) := "0010011";
    constant sd_op      : std_logic_vector(opcode_size - 1 downto 0) := "0100011";
    constant ld_op      : std_logic_vector(opcode_size - 1 downto 0) := "0000011";
    constant blt_op     : std_logic_vector(opcode_size - 1 downto 0) := "1100011";
    constant beq_op     : std_logic_vector(opcode_size - 1 downto 0) := "1100011";
    constant nop_op     : std_logic_vector(opcode_size - 1 downto 0) := (others => '0');

    constant beq_funct3 : std_logic_vector(funct3_size - 1 downto 0) := "000";
    constant blt_funct3 : std_logic_vector(funct3_size - 1 downto 0) := "100";

    constant zero_inst : std_logic_vector(instruction_size - 1 downto 0) := (others => '0');

    type inst_type is (INST_ADD, INST_ADDI, INST_SD, INST_LD, INST_BLT, INST_BEQ, INST_NOP);
    type alu_op is (OP_ADD, OP_EQ, OP_LT);
    type mem_op is (STORE, LOAD, REG_WR, NOP);
end package;

