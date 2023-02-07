library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
USE IEEE.numeric_std.all;  

--------------------------------------------------------------

entity sRam is
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
end sRam;

--------------------------------------------------------------

architecture behav of sRam is

-- use array to define the bunch of internal temparary signals

type ram_type is array (0 to depth-1) of  std_logic_vector(width-1 downto 0);
signal tmp_ram: ram_type;

begin	
	 -- Write Functional Section
    process(clk)
    begin
	if(rising_edge(clk)) then
	  if (Write='1' )then
		    tmp_ram(conv_integer(Addr)) <= Data_in;
		
		elsif (Read='1') then
		    Data_out <= tmp_ram(conv_integer(Addr)); 
		else
		    Data_out <= (Data_out'range => 'Z');
	  end if;
	end if;
	
    end process;
	   
   	
	
	
   
end behav;
----------------------------------------------------------------