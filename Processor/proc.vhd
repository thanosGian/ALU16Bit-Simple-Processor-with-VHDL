LIBRARY ieee; 
USE ieee.std_logic_1164.all; 
USE ieee.std_logic_signed.all; 
use work.basic_components.all;

ENTITY proc IS 
    PORT ( DIN : IN STD_LOGIC_VECTOR(15 DOWNTO 0); 
           Resetn, Clock, Run : IN STD_LOGIC; 
           Done : BUFFER STD_LOGIC; 
           BusWires : BUFFER STD_LOGIC_VECTOR(15 DOWNTO 0)); 
END proc; 

ARCHITECTURE Behavior OF proc IS 

SIGNAL Xreg, Yreg, Rin, Rout:STD_LOGIC_VECTOR(0 TO 7) ;
SIGNAL Clear, High : STD_LOGIC ;
SIGNAL ALUop:STD_LOGIC_VECTOR(2 DOWNTO 0);
SIGNAL Extern, Ain, Gin, IRin, Gout , DINout : STD_LOGIC ;
SIGNAL I : STD_LOGIC_VECTOR(2 DOWNTO 0) ;
SIGNAL Tstep_Q: STD_LOGIC_VECTOR(1 DOWNTO 0) ;--antistoixos counter,T se poio stadio eimaste
SIGNAL R0, R1, R2, R3, R4, R5, R6, R7 : STD_LOGIC_VECTOR(15 DOWNTO 0) ;--oi registers
SIGNAL A, Sum, G : STD_LOGIC_VECTOR(15 DOWNTO 0) ;
SIGNAL IR : STD_LOGIC_VECTOR(0 TO 8);
SIGNAL Sel : STD_LOGIC_VECTOR(1 TO 10);
SIGNAL DINinput :STD_LOGIC_VECTOR(8 DOWNTO 0);

BEGIN 
  High <= '1'; 
  Clear <= Resetn OR Done OR(NOT Run AND NOT Tstep_Q(1) AND NOT Tstep_Q(0));

  Tstep: upcount PORT MAP (Clear, Clock, Tstep_Q);
  --IRin <= Run; --AND NOT Tstep_Q(1) AND NOT Tstep_Q(0);
  
  DINinput <= DIN(15 DOWNTO 7);
  
  reg_IR: regn GENERIC MAP(n =>9)
			PORT MAP (DINinput,IRin,Clock,IR);
  I <= IR(0 TO 2);
  decX: dec3to8 PORT MAP (IR(3 TO 5), High, Xreg);--Xreg to antistoixizoume me to Rin
  decY: dec3to8 PORT MAP (IR(6 TO 8), High, Yreg);--Yreg to antistoixizoume me to Rout

  controlsignals: PROCESS (Tstep_Q, I, Xreg, Yreg) 

  BEGIN 
  --Reset signals
  Done <= '0';Ain <= '0';Gin <= '0'; IRin <= '0'; DINout <= '0';
  Gout <= '0';ALUop <= "000";Rin <= "00000000"; Rout <= "00000000";
  
    CASE Tstep_Q IS 
      WHEN "00" =>  --store DIN in IR as long as Tstep_Q = 0 
        IRin <= '1';
      WHEN "01" =>  --define signals in time step T1 
		  --IRin <= '0';
        CASE I IS 
			WHEN "000" =>--mv
				Rout <= Yreg; Rin <= Xreg; Done <= '1';
			WHEN "001" =>--mvi
				DINout <= '1'; Rin <= Xreg; Done <= '1';
			WHEN OTHERS =>--and,or,add,sub,xor,nor
				Rout <= Xreg; Ain <= '1';
        END CASE; 
      WHEN "10" =>  --define signals in time step T2 
        CASE I IS
			WHEN "000" =>--mv
			WHEN "001" =>--mvi
			WHEN "010" =>--and
				Rout <= Yreg; ALUop <= "010"; Gin <= '1';
			WHEN "011" =>--or
				Rout <= Yreg; ALUop <= "011"; Gin <= '1';
			WHEN "100" =>--add
				Rout <= Yreg; ALUop <= "100"; Gin <= '1';
			WHEN "101" =>--sub
				Rout <= Yreg; ALUop <= "101"; Gin <= '1';
			WHEN "110" =>--xor
				Rout <= Yreg; ALUop <= "110"; Gin <= '1';
			WHEN "111" =>--nor
				Rout <= Yreg; ALUop <= "111"; Gin <= '1';
        END CASE; 
      WHEN "11" =>  --define signals in time step T3 
        CASE I IS 
			WHEN "000" =>--mv
			WHEN "001" =>--mvi
			WHEN OTHERS =>--and,or,add,sub,xor,nor
				Gout <= '1'; Rin <= Xreg; Done <= '1';	
        END CASE; 
    END CASE; 
  END PROCESS; 

  reg_0: regn PORT MAP (BusWires, Rin(0), Clock, R0); 
  reg_1: regn PORT MAP (BusWires, Rin(1), Clock, R1);
  reg_2: regn PORT MAP (BusWires, Rin(2), Clock, R2);
  reg_3: regn PORT MAP (BusWires, Rin(3), Clock, R3);
  reg_4: regn PORT MAP (BusWires, Rin(4), Clock, R4);
  reg_5: regn PORT MAP (BusWires, Rin(5), Clock, R5);
  reg_6: regn PORT MAP (BusWires, Rin(6), Clock, R6);
  reg_7: regn PORT MAP (BusWires, Rin(7), Clock, R7);
  reg_A: regn PORT MAP (BusWires, Ain, Clock, A);
  
  alu16: alu PORT MAP (ALUop, A, BusWires, Sum);
  reg_G: regn PORT MAP (Sum, Gin, Clock, G);
  
  Sel <= Rout&Gout&DINout;
  WITH Sel SELECT
		BusWires <= R0 WHEN	"1000000000",
			     R1 WHEN "0100000000",
				 R2 WHEN "0010000000",
				 R3 WHEN "0001000000",
				 R4 WHEN "0000100000",
				 R5 WHEN "0000010000",
				 R6 WHEN "0000001000",
				 R7 WHEN "0000000100",
				 G WHEN "0000000010",
				 DIN WHEN OTHERS;
END Behavior; 