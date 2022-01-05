library IEEE;
use IEEE.STD_LOGIC_1164.all;


ENTITY adder4Bits IS
	PORT(
		a1,b1					:in  std_logic_vector(3 downto 0);
		result				:out std_logic_vector(3 downto 0);
		zeroFLAG				:out std_logic;
		carryOutFLAG		:out std_logic;
		overFlowFLAG		:out std_logic
	);
END adder4Bits;

ARCHITECTURE main OF adder4Bits IS

	COMPONENT fullAdder IS
		PORT( a1,b1 		: in  std_logic;
				carryIn		: in  std_logic;
				result		: out std_logic;
				carryOut		: out std_logic
		);
	END COMPONENT fullAdder;
	
	SIGNAL carryOutSignal : std_logic_vector(3 downto 0);
	SIGNAL verifyOVERFLOW :	std_logic;
	SIGNAL verifyZERO		 : std_logic;
	SIGNAL auxResult		 :std_logic_vector(3 downto 0);
	
	
BEGIN
	--Usar um for nessas intereções
	firstFullAdder: fullAdder
		port map(a1(0),b1(0),'0',auxResult(0),carryOutSignal(0));
	
	secondFullAdder: fullAdder
		port map(a1(1),b1(1),carryOutSignal(0),auxResult(1),carryOutSignal(1));
	
	thirdFullAdder: fullAdder
		port map(a1(2),b1(2),carryOutSignal(1), auxResult(2),carryOutSignal(2));
	
	fourthFullAdder: fullAdder
		port map(a1(3),b1(3),carryOutSignal(2),auxResult(3),carryOutSignal(3));
		
	
	 
	verifyOVERFLOW <= carryOutSignal(2) XOR carryOutSignal(3);
	--Saidas
	result<=auxResult;
	zeroFLAG <= '1' WHEN auxResult = "0000" ELSE '0';
	overFlowFLAG<= verifyOVERFLOW WHEN verifyOVERFLOW = '1' ELSE '0';
	carryOutFLAG<=carryOutSignal(3);
	
END main;
