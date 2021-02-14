library ieee;
use ieee.std_logic_1164.all;
use work.basic_components.all;

entity ALU16 is
	port (opcode:in std_logic_vector(2 downto 0);
			a, b 	:in std_logic_vector(15 downto 0);
			Result:out std_logic_vector(15 downto 0);
			OVF 	:out std_logic);
end ALU16;

architecture Structural of ALU16 is
	signal carries:std_logic_vector(0 to 16);
	signal Ainvert,Binvert,CarryIn:std_logic;
	signal Operation:std_logic_vector(1 downto 0);
	
begin
	Control: CONTROL_CIRCUIT port map (opcode,Ainvert,Binvert,Carries(0),Operation);
	G1:for i in 0 to 15 generate
			ALU1bit:ALU port map(Carries(i),a(i),b(i),Ainvert,Binvert,Operation,Carries(i+1),Result(i));
	end generate;
	OVF <= carries(16);
end Structural;