library ieee;
use ieee.std_logic_1164.all;
use work.basic_components.all;

entity CONTROL_CIRCUIT is
	port(opcode:in std_logic_vector(2 downto 0);
		  Ainvert,Binvert,CarryIn:out std_logic;
		  Operation:				  out std_logic_vector(1 downto 0));
end CONTROL_CIRCUIT;
architecture model_conc3 of CONTROL_CIRCUIT is
begin
process(opcode)
begin
case opcode is 
		when "000" => Operation<="00";Ainvert<='0';Binvert<='0';CarryIn<='0';
		when "001" => Operation<="01";Ainvert<='0';Binvert<='0';CarryIn<='0';
		when "011" => Operation<="10";Ainvert<='0';Binvert<='0';CarryIn<='0';
		when "010" => Operation<="10";Ainvert<='0';Binvert<='1';CarryIn<='1';
		when "101" => Operation<="00";Ainvert<='1';Binvert<='1';CarryIn<='0';
		when "100" => Operation<="11";Ainvert<='0';Binvert<='0';CarryIn<='0';
		when others => Operation<="00";Ainvert<='0';Binvert<='0';CarryIn<='0';
end case;
end process;
end model_conc3;