library IEEE;
use IEEE.STD_LOGIC_1164.all;

ENTITY changeSignal IS
	PORT(
			a1						:in  std_logic_vector(3 downto 0); 
			result				:out std_logic_vector(3 downto 0);
			negativeFLAG		:out std_logic
			);
END changeSignal;

ARCHITECTURE main OF changeSignal IS

	COMPONENT adder4Bits IS
			PORT(
				a1,b1					:in  std_logic_vector(3 downto 0);
				result				:out std_logic_vector(3 downto 0);
			--	zeroFLAG				:out std_logic;
				carryOutFLAG		:out std_logic;
				overFlowFLAG		:out std_logic
			);
	END COMPONENT adder4Bits;

	SIGNAL invert					:std_logic_vector(3 downto 0);
	SIGNAL auxResult				:std_logic_vector(3 downto 0);
	SIGNAL carry,overFlow		:std_logic;
	
BEGIN
	
	

	invert<= not a1;
	addOne: 	adder4Bits port map(invert,"0001",auxResult,carry,overFlow);
	result<=auxResult;
	negativeFlag<='1' WHEN auxResult(3)='1' ELSE '0';
END main;