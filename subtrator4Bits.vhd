library IEEE;
use IEEE.STD_LOGIC_1164.all;

ENTITY subtrator4Bits IS
	PORT(
		a1,b1				:in  std_logic_vector(3 downto 0);
		result			:out std_logic_vector(3 downto 0);
		negativeFLAG	:out std_logic;
		zeroFLAG			:out std_logic
		
	);
END subtrator4Bits;

ARCHITECTURE main OF subtrator4Bits IS

		COMPONENT adder4Bits IS
			PORT(
				a1,b1					:in  std_logic_vector(3 downto 0);
				result				:out std_logic_vector(3 downto 0);
				zeroFLAG				:out std_logic;
				carryOutFLAG		:out std_logic;
				overFlowFLAG		:out std_logic
			);
		END COMPONENT adder4Bits;

		SIGNAL addOne,invert								:std_logic_vector(3 downto 0);
		SIGNAL overFlowFlagSubtator					:std_logic;
		SIGNAL carryOut1,overFlow1,zero1				:std_logic;
		SIGNAL carryOut2,overFlow2,zero2				:std_logic;
		SIGNAL auxResult									:std_logic_vector(3 downto 0);
 
		
BEGIN
	invert <= not b1;
	
	fullAdderOne : adder4Bits port map(invert,"0001",addOne,zero1,carryOut1,overFlow1);
	
	finalAdder : adder4Bits port map(a1,addOne,auxResult,zero2,carryOut2,overFlow2);
	
	result<=auxResult;
	negativeFlag<='1' WHEN auxResult(3)='1' ELSE '0';
	zeroFLAG<=zero2;
	

END main;