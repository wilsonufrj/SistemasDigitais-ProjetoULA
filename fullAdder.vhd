library IEEE;
use IEEE.STD_LOGIC_1164.all;

ENTITY fullAdder IS
	PORT( a1,b1 		: in  std_logic;
			carryIn		: in  std_logic;
			result		: out std_logic;
			carryOut		: out std_logic
	);
	
END fullAdder;

ARCHITECTURE main OF fullAdder IS
	
	COMPONENT halfAdder IS 
		PORT(
			a1,b1				:in std_logic;
			result			:out std_logic;
			carryOut			:out std_logic
		);
	END COMPONENT halfAdder;
	
	SIGNAL outFirstAdder, carryFirstAdder, carrySecondAdder : std_logic;
		
BEGIN 
	half1: halfAdder
		port map(a1, b1, outFirstAdder, carryFirstAdder);
		
	halfFinal: halfAdder
		port map(outFirstAdder,carryIn, result,carrySecondAdder);
		
	carryOut<= carrySecondAdder or carryFirstAdder;
	
	
	
END main;