library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

ENTITY ula_4Bits_tb IS
END ENTITY;

ARCHITECTURE main OF ula_4Bits_tb  IS

	SIGNAL counter1_tb,counter2_tb		:unsigned(3 downto 0):="0000";

	SIGNAL a1_tb,b1_tb						: std_logic_vector(3 downto 0);
	SIGNAL result_tb							: std_logic_vector(3 downto 0);
	SIGNAL s0_tb,s1_tb,s2_tb				:std_logic:='0';
	SIGNAL carryOut_tb,overFlow_tb		:std_logic;
	SIGNAL negative_tb						:std_logic;
	SIGNAL zero_tb								:std_logic;			
	
	
	
 
BEGIN
	DUT: ENTITY work.ula_4bits PORT MAP( a1=> a1_tb, b1=> b1_tb,s0=>s0_tb, s1=>s1_tb, s2=>s2_tb, result => result_tb,
													 zeroFLAG=>zero_tb,negativeFLAG=>negative_tb,carryOutFLAG=>carryOut_tb, overFlowFLAG=> overFlow_tb);
		
	Adder:PROCESS
	BEGIN
	testAdder:FOR x IN 0 to 15 LOOP
			a1_tb<=std_logic_vector(counter1_tb);
			inLoop:FOR y in 0 to 15 LOOP
					a1_tb<=std_logic_vector(counter1_tb);
					b1_tb<=std_logic_vector(counter2_tb);
					counter2_tb<=counter2_tb+1;
					WAIT FOR 5ns;
				END LOOP inLoop;
			counter1_tb<=counter1_tb+1;
		END LOOP testAdder;
		
	
	s0_tb<='0';
	s1_tb<='1';
	counter1_tb<="0000";
	b1_tb<="0000";
	testAdderOne: FOR x IN 0 to 15 LOOP
			a1_tb<=std_logic_vector(counter1_tb);
			counter1_tb<=counter1_tb+1;
			WAIT FOR 5ns;	
		END LOOP testAdderOne;
		
		
	s0_tb<='1';
	s1_tb<='0';
	counter1_tb<="0000";
	testChangeSignal: FOR x IN 0 to 15 LOOP
			a1_tb<=std_logic_vector(counter1_tb);
			counter1_tb<=counter1_tb+1;
			WAIT FOR 5ns;	
		END LOOP testChangeSignal;	
		
	s0_tb<='1';
	s1_tb<='1';
	counter1_tb<="0000";
	counter2_tb<="0000";
	testSubtrator:FOR x IN 0 to 15 LOOP
			a1_tb<=std_logic_vector(counter1_tb);
			inLoopSubtrator:FOR y in 0 to 15 LOOP
					a1_tb<=std_logic_vector(counter1_tb);
					b1_tb<=std_logic_vector(counter2_tb);
					counter2_tb<=counter2_tb+1;
					WAIT FOR 5ns;
				END LOOP inLoopSubtrator;
			counter1_tb<=counter1_tb+1;
		END LOOP testSubtrator;
	
	WAIT;
	END PROCESS;
	
	
	

END main;