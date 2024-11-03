library IEEE;
use IEEE.STD_LOGIC_1164.all;

library work;
use work.constants.all;

entity decode is
    port(
        inst_in : in std_logic_vector(instruction_size - 1 downto 0);

        rd, rs1, rs2 : out std_logic_vector(reg_address_size - 1 downto 0) := (others => '0');
        inst_out : out inst_type;
        --inst_int : out integer; --Utile per debug!
        --alu_operation : out alu_op;
        immediate : out std_logic_vector(register_size - 1 downto 0)
    );
end entity;

architecture behaviour of decode is
    signal i_imm, s_imm, b_imm, j_imm : std_logic_vector(register_size - 1 downto 0);
    signal code : std_logic_vector(opcode_size - 1 downto 0);
    signal funct3 : std_logic_vector(funct3_size - 1 downto 0);

    signal imm : std_logic_vector(register_size - 1 downto 0);
    signal inst_id : inst_type;
    signal inst_int_id : integer;
    begin
        code <= inst_in(6 downto 0);
        funct3 <= inst_in(14 downto 12);

        i_imm <= (register_size - 1 downto 11 => inst_in(31)) & inst_in(30 downto 20);
        s_imm <= (register_size - 1 downto 11 => inst_in(31)) & inst_in(30 downto 25) & inst_in(11 downto 7);
        b_imm <= (register_size - 1 downto 12 => inst_in(31)) & inst_in(7) &
                    inst_in(30 downto 25) & inst_in(11 downto 8) & '0';

        immediate <= i_imm when (code = addi_op or code = ld_op) else
                    s_imm when code = sd_op else
                    b_imm when code = blt_op else
                    (others => '0');

        inst_id <= INST_ADD when code = add_op else
                    INST_ADDI when code = addi_op else
                    INST_SD when code = sd_op else
                    INST_LD when code = ld_op else
                    INST_BLT when (code = blt_op and funct3 = blt_funct3) else
                    INST_BEQ when (code = beq_op and funct3 = beq_funct3) else
                    INST_NOP;

        inst_out <= inst_id;

        --inst_int <= 0 when code = add_op else
          --          1 when code = addi_op else
            --        2 when code = sd_op else
              --      3 when code = ld_op else
                --    4 when (code = blt_op and funct3 = blt_funct3) else
                  --  5 when (code = beq_op and funct3 = beq_funct3) else
                    ---1;

        --alu_operation <= OP_EQ when code = beq_op else
          --              OP_LT when code = blt_op else
            --            OP_ADD;

        rd <= inst_in(11 downto 7) when (inst_id = INST_ADD or inst_id = INST_ADDI or inst_id = INST_LD) else (others => '0');
        rs1 <= inst_in(19 downto 15);
        rs2 <= inst_in(24 downto 20) when (inst_id = INST_ADD or inst_id = INST_SD or inst_id = INST_BLT or inst_id = INST_BEQ) else (others => '0');

end architecture;