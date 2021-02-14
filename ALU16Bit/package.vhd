library ieee;
use ieee.std_logic_1164.all;

package basic_components is

	component AND2IN
			port (in1,in2	: in std_logic;	
					output   : out std_logic);
	end component;
	
	component OR2IN
			port (in1,in2	: in std_logic;	
					out1     : out std_logic);
	end component;
	
	component FULLADDER1
			port (Cin,x,y : in std_logic;
					s,cout  : out std_logic);
	end component;
	
	component MUX4TO1
			port (op_and,op_or,op_add,op_xor : in std_logic;
					op				        			: in std_logic_vector(1 downto 0);
					R			           			: out std_logic);
	end component;
	
	component MUX2TO1
			port (input   : in std_logic;
					Binvert : in std_logic;
					Result  : out std_logic);
	end component;
	
	component XOR2IN
			port(input1,input2: in std_logic;
				  Result 		: out std_logic);
	end component;
	
	component ALU 
			port(Cin,a,b,Ainvert,Binvert :in std_logic;
				  op_code 					  :in std_logic_vector(1 downto 0);
				  Cout,Result 		        :out std_logic);
	end component;
	component CONTROL_CIRCUIT
		  port(opcode:in std_logic_vector(2 downto 0);
				 Ainvert,Binvert,CarryIn:out std_logic;
				 Operation:				  out std_logic_vector(1 downto 0));
	end component;
end basic_components;

--ylopoihsh twn component
library ieee;
use ieee.std_logic_1164.all;
--AND2
entity AND2IN is
		port (in1,in2   : in std_logic;
				output	 : out std_logic);
end AND2IN;
architecture model_conc of AND2IN is
begin	
	output<= in1 and in2;
end model_conc;

library ieee;
use ieee.std_logic_1164.all;
--OR2
entity OR2IN is
		port (in1,in2: in std_logic;
				out1	 : out std_logic);
end OR2IN;
architecture model_conc1 of OR2IN is
begin	
	out1<= in1 or in2;
end model_conc1;

library ieee;
use ieee.std_logic_1164.all;
--FULLLADDER1
entity FULLADDER1 is
		port (Cin,x,y : in std_logic;
				s,cout  : out std_logic);
end FUlLADDER1;
architecture LogicFunc of FULLADDER1 is
begin 
	s <= ((x and (not y)) and (not cin)) or (((not x) and y) and (not cin)) or((not x) and (not y) and cin)or ((x and y) and cin);
	--s <= (x xor y) xor Cin;
	cout <= (x and y) or (Cin and x) or (Cin and y);
end LogicFunc;

library ieee;
use ieee.std_logic_1164.all;
--MUX4TO1
entity MUX4TO1 is
			port (op_and,op_or,op_add,op_xor : in std_logic;
					op						  : in std_logic_vector(1 downto 0);
					R				        : out std_logic);
end MUX4TO1;
architecture LogicFunc1 of MUX4TO1 is 
begin 
	with op select 
		R<= op_and when "00",
			 op_or  when "01",
			 op_add when "10",
			 op_xor when "11";
end LogicFunc1;

library ieee;
use ieee.std_logic_1164.all;

entity MUX2TO1 is
			port (input : in std_logic;
					Binvert : in std_logic;
					Result  : out std_logic);
end MUX2TO1;
architecture LogicFunc2 of MUX2TO1 is 
begin 
	with Binvert select 
		Result <= input when '0',
					 not input when others;
end LogicFunc2;	

library ieee;
use ieee.std_logic_1164.all;

entity XOR2IN is 
		 	port(input1,input2: in std_logic;
				   Result 		: out std_logic);
end XOR2IN;
architecture model_conc2 of XOR2IN is
begin 
	Result <= input1 xor input2;
end model_conc2;


