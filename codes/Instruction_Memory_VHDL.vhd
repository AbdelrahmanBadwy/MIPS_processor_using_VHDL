library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;  

entity Instruction_Memory_VHDL is
port (
 inst_add: in std_logic_vector(3 downto 0);
 instruction: out  std_logic_vector(15 downto 0)
);
end Instruction_Memory_VHDL;

architecture Behavioral of Instruction_Memory_VHDL is
signal rom_addr: std_logic_vector(3 downto 0);
 type ROM_type is array (0 to 15 ) of std_logic_vector(15 downto 0);
 constant rom_data: ROM_type:=(
   "0111000100001110",
   "0001100101001001", -- op xxxx rs xxx rt xxx rd xxx fun xxx
   "0001001110001010",
   "0010001001000001",
   "0001011010011000", -- counter at 111
   "0011001001000001",  
   "0010010010000010",
   "1010000001001111",
   "1111000000000100",
   "0000000000000000",
   "0000000000000000",
   "0000000000000000",
   "0000000000000000",
   "0000000000000000",
   "0000000000000000",
   "0000000000000000"
  );
begin

 rom_addr <= inst_add;
  instruction <= rom_data(to_integer(unsigned(rom_addr)));

end Behavioral;