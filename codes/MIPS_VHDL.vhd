library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_signed.all;
use IEEE.NUMERIC_STD.ALL;

entity MIPS_VHDL is
port (
 clk,reset: in std_logic;
 pc_out : out std_logic_vector( 3 downto 0);
alu_result: out std_logic_vector( 15 downto 0) 
);
end MIPS_VHDL;

architecture Behavioral of MIPS_VHDL is

 signal pc_current: std_logic_vector(3 downto 0);
 signal pc_next,pc2: std_logic_vector(3 downto 0);
 signal instr: std_logic_vector(15 downto 0);
 signal alu_op: std_logic_vector(2 downto 0);
 signal jump,branch,branch_l,branch_g,mem_read,mem_write,alu_src,reg_write,reg_dst,mem_to_reg: std_logic;
 signal reg_write_dest: std_logic_vector(2 downto 0);
 signal reg_write_data: std_logic_vector(15 downto 0);
 signal reg_read_addr_1: std_logic_vector(2 downto 0);
 signal reg_read_data_1: std_logic_vector(15 downto 0);
 signal reg_read_addr_2: std_logic_vector(2 downto 0);
 signal reg_read_data_2: std_logic_vector(15 downto 0);
 signal sign_ext_im,read_data2: std_logic_vector(15 downto 0);
 signal ALU_Control: std_logic_vector(2 downto 0);
 signal ALU_out: std_logic_vector(15 downto 0);
 signal zero_flag,sign_flag: std_logic;
 signal PC_j, PC_branch, PC_4branch,PC_4beqj: std_logic_vector(3 downto 0);
 signal mem_read_data: std_logic_vector(15 downto 0);
 signal f1 : std_logic;
 
 
 component Instruction_Memory_VHDL 
	port (
 inst_add: in std_logic_vector(3 downto 0);
 instruction: out  std_logic_vector(15 downto 0)
);
 end component;
 --signal inst_add : std_logic_vector (3 downto 0);
 signal instruction : std_logic_vector (15 downto 0);
 component control_unit_VHDL 
	port (
  opcode: in std_logic_vector(3 downto 0);
  reset: in std_logic;
  alu_op: out std_logic_vector(2 downto 0);
  reg_dst,mem_to_reg,jump,branch,branch_g,branch_l,mem_read,mem_write,alu_src,reg_write : out std_logic
 );
 end component;
  component ALU_Control_VHDL 
	port(
  ALU_Control: out std_logic_vector(2 downto 0);
  ALUOp : in std_logic_vector(2 downto 0);
  ALU_Funct : in std_logic_vector(2 downto 0)
);
 end component;
 
 component  register_file_VHDL 
	port (
 clk,rst: in std_logic;
 reg_write_en: in std_logic;
 reg_write_dest: in std_logic_vector(2 downto 0);
 reg_write_data: in std_logic_vector(15 downto 0);
 reg_read_addr_1: in std_logic_vector(2 downto 0);
 reg_read_data_1: out std_logic_vector(15 downto 0);
 reg_read_addr_2: in std_logic_vector(2 downto 0);
 reg_read_data_2: out std_logic_vector(15 downto 0)
);
 end component;
component  ALU 
Port ( inp_a : in STD_LOGIC_VECTOR(15 downto 0);
 inp_b : in STD_LOGIC_VECTOR(15 downto 0);
 alu_control : in STD_LOGIC_VECTOR (2 downto 0);
 alu_result : out STD_LOGIC_VECTOR(15 downto 0);
  zero_flag,sign_flag : out std_logic);
   end component;
component sRam
generic(width:	integer:=16; --word
		depth:	integer:=8; --no of locations
		dataaddr:	integer:=3);
port(
	clk: in std_logic;
	Read:		in std_logic;
	Write:		in std_logic;
	Addr:	in std_logic_vector(dataaddr-1 downto 0);   --3
	Data_in: 	in std_logic_vector(width-1 downto 0);  --16
	Data_out: 	out std_logic_vector(width-1 downto 0) --16
);
end component;
begin
-- PC of the MIPS Processor in VHDL
process(clk,reset)
begin 
 if(reset='1') then
  pc_current <= "0000";
 elsif(rising_edge(clk)) then
  pc_current <= pc_next;
 end if;
end process;
-- PC + 1 
  pc2 <= pc_current + "0001";
-- instruction memory of the MIPS Processor in VHDL
Instruction_Memory: Instruction_Memory_VHDL 
        port map
       (
        inst_add=> pc_current,
        instruction => instr
        );
-- control unit of the MIPS Processor in VHDL
control: control_unit_VHDL     --done
   port map
   (reset => reset,
    opcode => instr(15 downto 12),
    reg_dst => reg_dst,
    mem_to_reg => mem_to_reg,
    alu_op => alu_op,
    jump => jump,
    branch => branch,
	branch_g => branch_g,
	branch_l => branch_l,
    mem_read => mem_read,
    mem_write => mem_write,
    alu_src => alu_src,
    reg_write => reg_write
    );
-- multiplexer regdest
  reg_write_dest <= 
        instr(5 downto 3) when  reg_dst= '1' else
        instr(8 downto 6);
-- register file instantiation of the MIPS Processor in VHDL
 reg_read_addr_1 <= instr(11 downto 9);
 reg_read_addr_2 <= instr(8 downto 6);
register_file: register_file_VHDL   -- --done
 port map
 (
 clk => clk,
 rst => reset,
 reg_write_en => reg_write,
 reg_write_dest => reg_write_dest,
 reg_write_data => reg_write_data,
 reg_read_addr_1 => reg_read_addr_1,
 reg_read_data_1 => reg_read_data_1,
 reg_read_addr_2 => reg_read_addr_2,
 reg_read_data_2 => reg_read_data_2
 );
-- sign extend
 sign_ext_im <= "0000000000" & instr(5 downto 0);  

-- ALU control unit of the MIPS Processor in VHDL
ALUControl:ALU_Control_VHDL port map
  (
   ALUOp => alu_op,
   ALU_Funct => instr(2 downto 0),
   ALU_Control => ALU_Control
   );
-- multiplexer alu_src
 read_data2 <= sign_ext_im when alu_src='1' else reg_read_data_2;
-- ALU unit of the MIPS Processor in VHDL
aalu: ALU port map
  (
   inp_a => reg_read_data_1,
   inp_b => read_data2,
   alu_control => ALU_Control,
   alu_result => ALU_out,
   zero_flag => zero_flag,
   sign_flag=>sign_flag
   );
   
-- PC beq
 PC_branch <=sign_ext_im(3 downto 0) ;
-- PC_beq
f1<=((branch and zero_flag) or (branch_g and (not sign_flag)) or (branch_l and sign_flag));
 PC_4branch <= PC_branch when f1='1' else pc2;
-- PC_j
 PC_j <= sign_ext_im(3 downto 0);
-- PC_4beqj
 PC_4beqj <= PC_j when jump = '1' else  PC_4branch;
-- PC_next
 pc_next <= PC_4beqj;
-- data memory of the MIPS Processor in VHDL
ssram: sRam port map
  (
  clk => clk,
  Addr => ALU_out(2 downto 0),
  Data_in => reg_read_data_2,
  Write => mem_write,
  read => mem_read,
  Data_out => mem_read_data
  );
-- write back of the MIPS Processor in VHDL
 reg_write_data <=  mem_read_data when (mem_to_reg = '1') else ALU_out;
-- output
 pc_out <= pc_current;
 alu_result <= ALU_out;

end Behavioral;