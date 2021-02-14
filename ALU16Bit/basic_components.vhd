library ieee;
use ieee.std_logic_1164.all;

package basic_components is

	component AND2
			port (in1,in2	: in std_logic;	
					out1: out std_logic);
	end component;
	
	component OR2
			port (in1,in2	: in std_logic;	
					out1: out std_logic);
	end component;
	
	component FULLADDER1
			port (Cin,x,y : in std_logic;
					s,cout  : out std_logic);
	end component;
	
	component MUX4TO1
			port (w0,w1,w2,w3 : in std_logic;
					s				: in std_logic_vector(1 downto 0);
					f				: out std_logic);
	end component;
	
end basic_components;

--ylopoihsh twn component
library ieee;
use ieee.std_logic_1164.all;
--AND2
entity AND2 is
		port (in1,in2: in std_logic;
				out1	 : out std_logic);
end AND2;
architecture model_conc of AND2 is
begin	
	out<= in1 and in2;
end model_conc;

library ieee;
use ieee.std_logic_1164.all;
--OR2
entity OR2 is
		port (in1,in2: in std_logic;
				out1	 : out std_logic);
end OR2;
architecture model_conc1 of OR2 is
begin	
	out<= in1 or in2;
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
	s =< x xor y xor Cin;
	cout <= (x and y) or (Cin and x) or (Cin and y);
end LogicFunc;

library ieee;
use ieee.std_logic_1164.all;
--MUX4TO1
entity MUX4TO1 is
			port (w0,w1,w2,w3 : in std_logic;
					s				: in std_logic_vector(1 downto 0);
					f				: out std_logic);
end MUX4TO1;
architecture LogicFunc1 of MUX4TO1 is 
begin 
	with s select 
		f<= w0 when "00",
			 w1 when "01",
			 w2 when "10",
			 w3 when others;
end LogicFunc1;









