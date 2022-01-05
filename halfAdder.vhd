library IEEE;
use IEEE.STD_LOGIC_1164.all;

ENTITY halfAdder IS 
	PORT(
		a1,b1				:in std_logic;
		result			:out std_logic;
		carryOut			:out std_logic
	);
END halfAdder;

ARCHITECTURE main OF halfAdder IS
BEGIN
	result	<= a1 xor b1;
	carryOut		<= a1 and b1;
	
END main;