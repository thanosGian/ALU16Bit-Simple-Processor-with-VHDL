LIBRARY ieee; 
USE ieee.std_logic_1164.all; 
USE ieee.std_logic_signed.all; 

PACKAGE basic_components IS

	COMPONENT alu IS
		PORT (ALUct1 : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
      A,B: IN STD_LOGIC_VECTOR (15 DOWNTO 0);
      ALUout: OUT STD_LOGIC_VECTOR (15 DOWNTO 0));
	END COMPONENT;
	
	COMPONENT upcount 
			PORT ( Clear, Clock : IN STD_LOGIC; 
			Q : OUT STD_LOGIC_VECTOR(1 DOWNTO 0)); 
	END COMPONENT;
	
	COMPONENT dec3to8 IS
	     PORT ( W : IN STD_LOGIC_VECTOR(2 DOWNTO 0); 
	     En : IN STD_LOGIC; 
	     Y : OUT STD_LOGIC_VECTOR(0 TO 7)); 
	END COMPONENT; 
	
	COMPONENT regn IS
	    GENERIC (n : INTEGER := 16); 
	    PORT ( R : IN STD_LOGIC_VECTOR(n-1 DOWNTO 0); 
	    Rin, Clock : IN STD_LOGIC; 
       Q : BUFFER STD_LOGIC_VECTOR(n-1 DOWNTO 0));
	END COMPONENT; 
	
END basic_components;

LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_signed.all;


ENTITY upcount IS 
  PORT ( Clear, Clock : IN STD_LOGIC; 
  Q : OUT STD_LOGIC_VECTOR(1 DOWNTO 0)); 
END upcount; 

ARCHITECTURE Behavior1 OF upcount IS 
 SIGNAL Count : STD_LOGIC_VECTOR(1 DOWNTO 0); 

BEGIN 
  PROCESS (Clock) 
  BEGIN 

    IF (Clock'EVENT AND Clock = '1') THEN 

     IF Clear = '1' THEN 
       Count <= "00"; 
     ELSE 
       Count <= Count + 1; 
     END IF; 

   END IF; 
  END PROCESS; 
  Q <= Count; 

END Behavior1; 


LIBRARY ieee;
USE ieee.std_logic_1164.all;


ENTITY dec3to8 IS
  PORT ( W : IN STD_LOGIC_VECTOR(2 DOWNTO 0); 
  En : IN STD_LOGIC; 
  Y : OUT STD_LOGIC_VECTOR(0 TO 7)); 
END dec3to8; 

ARCHITECTURE Behavior2 OF dec3to8 IS 

BEGIN 
  PROCESS (W, En) 
  BEGIN 

    IF En = '1' THEN 
      CASE W IS 
			WHEN "000"=> Y <= "10000000"; 
			WHEN "001"=> Y <= "01000000"; 
			WHEN "010"=> Y <= "00100000"; 
			WHEN "011"=> Y <= "00010000"; 
			WHEN "100"=> Y <= "00001000"; 
			WHEN "101"=> Y <= "00000100"; 
			WHEN "110"=> Y <= "00000010"; 
			WHEN OTHERS=> Y <= "00000001"; 
      END CASE; 
    ELSE 
      Y <= "00000000"; 
    END IF; 
   END PROCESS; 
END Behavior2; 


LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY regn IS 
  GENERIC (n : INTEGER := 16); 
  PORT ( R : IN STD_LOGIC_VECTOR(n-1 DOWNTO 0); 

  Rin, Clock : IN STD_LOGIC; 

  Q : BUFFER STD_LOGIC_VECTOR(n-1 DOWNTO 0)); 
END regn; 

ARCHITECTURE Behavior3 OF regn IS 

BEGIN 
  PROCESS (Clock) 
  BEGIN 

    IF Clock'EVENT AND Clock = '1' THEN 
      IF Rin = '1' THEN 
        Q <=R; 
      END IF; 
    END IF; 
  END PROCESS; 
END Behavior3; 

LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;


ENTITY alu IS
   PORT (ALUct1 : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
         A,B: IN STD_LOGIC_VECTOR (15 DOWNTO 0);
         ALUout: OUT STD_LOGIC_VECTOR (15 DOWNTO 0));
END alu;
ARCHITECTURE Behavior4 of ALU IS
Signal temp_output: std_logic_vector (15 downto 0);
BEGIN 

    Process(ALUct1, A, B)
    BEGIN
        case Aluct1 Is
         when "010" =>
              temp_output <= A and B;
         when "011" =>
              temp_output <=  A or B;
         when "100" =>
              temp_output <= A + B;
         when "101" =>
              temp_output <= A - B;
		 when "110" =>
             temp_output <= A xor B;
         when "111" =>
             temp_output <= A nor B;
         when others =>
             temp_output <= "0000000000000000";
       End Case;
  END PROCESS;
      ALUout <= temp_output;
END Behavior4;