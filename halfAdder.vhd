ENTITY halfAdder IS 
	PORT(
		a1,b1				:in BIT;
		result			:out BIT;
		carryOut			:out BIT
	);
END halfAdder;

ARCHITECTURE main OF halfAdder IS
BEGIN
	result	<= a1 xor b1;
	carryOut		<= a1 and b1;
	
END main;