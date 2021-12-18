ENTITY adder4Bits IS
	PORT(
		a1,b1			:in  BIT_VECTOR(3 downto 0);
		carryIn		:in  BIT;
		result		:out BIT_VECTOR(3 downto 0);
		carryOut		:out BIT
	);
END adder4Bits;

ARCHITECTURE main OF adder4Bits IS

	COMPONENT fullAdder IS
		PORT( a1,b1 		: in  BIT;
				carryIn		: in  BIT;
				result		: out BIT;
				carryOut		: out BIT
		);
	END COMPONENT fullAdder;
	
	SIGNAL carryOutSignal : BIT_VECTOR(3 downto 0);
	
BEGIN
	--Usar um for nessas intereções
	firstFullAdder: fullAdder
		port map(a1(0),b1(0),carryIn,result(0),carryOutSignal(0));
	
	secondFullAdder: fullAdder
		port map(a1(1),b1(1),carryOutSignal(0),result(1),carryOutSignal(1));
	
	thirdFullAdder: fullAdder
		port map(a1(2),b1(2),carryOutSignal(1), result(2),carryOutSignal(2));
	
	fourthFullAdder: fullAdder
		port map(a1(3),b1(3),carryOutSignal(2),result(3),carryOut);
		
		
	ZERO <= '1' when (result = "0000") else '0';
	SIGN <= result(3); 
	OVERFLOW <= carryOutSignal(2) XOR carryOutSignal(3);
	COUT <= carryOutSignal(3);
	
END main;
