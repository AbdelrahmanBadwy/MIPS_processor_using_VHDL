


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_signed.all;
use IEEE.NUMERIC_STD.ALL;


entity alu is
 Port ( inp_a : in STD_LOGIC_VECTOR(15 downto 0);
 inp_b : in STD_LOGIC_VECTOR(15 downto 0);
 alu_control : in STD_LOGIC_VECTOR (2 downto 0);
 alu_result : out STD_LOGIC_VECTOR(15 downto 0);
  zero_flag,sign_flag : out std_logic);
end alu;

architecture Behavioral of alu is
signal out_alu : std_logic_vector(15 downto 0);
begin
process(inp_a, inp_b, alu_control) 
	begin
		if (ieee.std_logic_signed."="(alu_control,"000")) then out_alu<=inp_a + inp_b; 
		elsif (ieee.std_logic_signed."="(alu_control,"001")) then out_alu<=inp_a - inp_b;
		elsif (ieee.std_logic_signed."="(alu_control,"010"))then out_alu<= std_logic_vector(to_unsigned((to_integer(unsigned(inp_a)) * to_integer(unsigned(inp_b))),16)) ;
		elsif (ieee.std_logic_signed."="(alu_control,"011")) then out_alu<=std_logic_vector(to_unsigned((to_integer(unsigned(inp_a)) / to_integer(unsigned(inp_b))),16)) ;
		elsif (ieee.std_logic_signed."="(alu_control,"100")) then out_alu<=inp_a and inp_b;
		elsif (ieee.std_logic_signed."="(alu_control,"101")) then out_alu<=inp_a or inp_b;
		elsif (ieee.std_logic_signed."="(alu_control,"110")) then out_alu<= inp_a xor inp_b;
		elsif (ieee.std_logic_signed."="(alu_control,"111")) then out_alu<= not inp_a;
end if;
end process;
zero_flag <= '1' when (ieee.std_logic_signed."="(out_alu,x"0000")) else '0';
sign_flag <= '1' when (ieee.std_logic_signed."<"(inp_a,inp_b)) else '0';

alu_result <= out_alu;

end Behavioral;
	






