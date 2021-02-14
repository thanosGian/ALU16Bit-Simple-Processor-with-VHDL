library ieee;
use ieee.std_logic_1164.all;
use work.basic_components.all;

entity ALU is 
	port(Cin,a,b,Ainvert,Binvert :in std_logic;
		  op_code 					  :in std_logic_vector(1 downto 0);
		  Cout,Result 		        :out std_logic);
end ALU;

architecture Structural of ALU is
		signal and_output,or_output,add_output,bMuxOutput,aMuxOutput,xor_output:std_logic;
begin
	stage_a   :MUX2TO1    port map(a,Ainvert,aMuxOutput);
	stage_b   :MUX2TO1    port map(b,Binvert,bMuxOutput);
	stage_and :AND2IN 	 port map(aMuxOutput,bMuxOutput,and_output);
	stage_or  :OR2IN		 port map(aMuxOutput,bMuxOutput,or_output);
	stage_add :FULLADDER1 port map(Cin,aMuxOutput,bMuxOutput,add_output,Cout);
	stage_xor :XOR2IN     port map(aMuxOutput,bMuxOutput,xor_output);
	stage_last:MUX4TO1    port map(and_output,or_output,add_output,xor_output,op_code,Result);
end Structural;