library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity control_unit_VHDL is
port (
  opcode: in std_logic_vector(3 downto 0);
  reset: in std_logic;
  alu_op: out std_logic_vector(2 downto 0);
  reg_dst,mem_to_reg,jump,branch,branch_g,branch_l,mem_read,mem_write,alu_src,reg_write : out std_logic
 );
end control_unit_VHDL;

architecture Behavioral of control_unit_VHDL is

begin
process(reset,opcode)
begin
 if((reset = '1') or (opcode = "0000")) then
   reg_dst <= '0';
   mem_to_reg <= '0';
   alu_op <= "000";
   jump <= '0';
   branch_g <= '0';
   branch_l <= '0';
   branch <= '0';
   mem_read <= '0';
   mem_write <= '0';
   alu_src <= '0';
   reg_write <= '0';
 else 
 case opcode is
  when "0001" => -- arith and logic
    reg_dst <= '1';
    mem_to_reg <= '0';
    alu_op <= "000";
    jump <= '0';
	branch_g <= '0';
	branch_l <= '0';
    branch <= '0';
    mem_read <= '0';
    mem_write <= '0';
    alu_src <= '0';
    reg_write <= '1';

  when "0010" =>    -- addi
   reg_dst <= '0';
   mem_to_reg <= '0';
   alu_op <= "011";
   jump <= '0';
   branch_g <= '0';
   branch_l <= '0';
   branch <= '0';
   mem_read <= '0';
   mem_write <= '0';
   alu_src <= '1';
   reg_write <= '1';
   
   when "0011" =>    -- subi
   reg_dst <= '0';
   mem_to_reg <= '0';
   alu_op <= "001";
   jump <= '0';
   branch_g <= '0';
   branch_l <= '0';
   branch <= '0';
   mem_read <= '0';
   mem_write <= '0';
   alu_src <= '1';
   reg_write <= '1';
   
   when "0100" =>    -- andi
   reg_dst <= '0';
   mem_to_reg <= '0';
   alu_op <= "010";
   jump <= '0';
   branch_g <= '0';
   branch_l <= '0';
   branch <= '0';
   mem_read <= '0';
   mem_write <= '0';
   alu_src <= '1';
   reg_write <= '1';

when "0101" =>    -- ori
   reg_dst <= '0';
   mem_to_reg <= '0';
   alu_op <= "100";
   jump <= '0';
   branch_g <= '0';
   branch_l <= '0';
   branch <= '0';
   mem_read <= '0';
   mem_write <= '0';
   alu_src <= '1';
   reg_write <= '1';
   
when "0110" =>    -- xori
   reg_dst <= '0';
   mem_to_reg <= '0';
   alu_op <= "101";
   jump <= '0';
   branch_g <= '0';
   branch_l <= '0';
   branch <= '0';
   mem_read <= '0';
   mem_write <= '0';
   alu_src <= '1';
   reg_write <= '1';
   
 when "0111" =>-- li
   reg_dst <= '0' ;
   mem_to_reg <= '0';
   alu_op <= "011";
   jump <= '0';
   branch_g <= '0';
   branch_l <= '0';
   branch <= '0';
   mem_read <= '0';
   mem_write <= '0';
   alu_src <= '1';
   reg_write <= '1';
   
when "1000" =>-- lw
   reg_dst <= '0';
   mem_to_reg <= '1';
   alu_op <= "011";
   jump <= '0';
   branch_g <= '0';
   branch_l <= '0';
   branch <= '0';
   mem_read <= '1';
   mem_write <= '0';
   alu_src <= '1';
   reg_write <= '1';
 
 when "1001" => -- sw
   reg_dst <= '0';
   mem_to_reg <= '0';
   alu_op <= "011";
   jump <= '0';
   branch_g <= '0';
   branch_l <= '0';
   branch <= '0';
   mem_read <= '0';
   mem_write <= '1';
   alu_src <= '1';
   reg_write <= '0';
 
 when "1010" => -- beq
   reg_dst <= '0';
   mem_to_reg <= '0';
   alu_op <= "001";
   jump <= '0';
   branch_g <= '0';
   branch_l <= '0';
   branch <= '1';
   mem_read <= '0';
   mem_write <= '0';
   alu_src <= '0';
   reg_write <= '0';

 when "1011" => -- bg
   reg_dst <= '0';
   mem_to_reg <= '0';
   alu_op <= "001";
   jump <= '0';
   branch_g <= '1';
   branch_l <= '0';
   branch <= '0';
   mem_read <= '0';
   mem_write <= '0';
   alu_src <= '0';
   reg_write <= '0';
   
 when "1100" => -- bl
   reg_dst <= '0';
   mem_to_reg <= '0';
   alu_op <= "001";
   jump <= '0';
   branch_g <= '0';
   branch_l <= '1';
   branch <= '0';
   mem_read <= '0';
   mem_write <= '0';
   alu_src <= '0';
   reg_write <= '0';
   
 when "1101" => -- bc---------------------------------------->
   reg_dst <= '0';
   mem_to_reg <= '0';
   alu_op <= "000";
   jump <= '0';
   branch_g <= '0';
   branch_l <= '0';
   branch <= '1';
   mem_read <= '0';
   mem_write <= '0';
   alu_src <= '0';
   reg_write <= '0';
   
   when "1110" => -- bz---------------------------------------->
   reg_dst <= '0';
   mem_to_reg <= '0';
   alu_op <= "000";
   jump <= '0';
   branch_g <= '0';
   branch_l <= '0';
   branch <= '1';
   mem_read <= '0';
   mem_write <= '0';
   alu_src <= '0';
   reg_write <= '0';
   
  when "1111" => -- j
   reg_dst <= '0';
   mem_to_reg <= '0';
   alu_op <= "000";
   jump <= '1';
   branch_g <= '0';
   branch_l <= '0';
   branch <= '0';
   mem_read <= '0';
   mem_write <= '0';
   alu_src <= '0';
   reg_write <= '0';

 when others =>   
    reg_dst <= '1';
    mem_to_reg <= '0';
    alu_op <= "000";
    jump <= '0';
    branch <= '0';
	branch_g <= '0';
    branch_l <= '0';
    mem_read <= '0';
    mem_write <= '0';
    alu_src <= '0';
    reg_write <= '1';
 end case;
 end if;
end process;

end Behavioral;