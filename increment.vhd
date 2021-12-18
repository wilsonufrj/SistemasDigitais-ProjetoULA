ENTITY increment IS
	PORT(
		a1,b1			:in  BIT_VECTOR(3 downto 0);
		carryIn		:in  BIT;
		result		:out BIT_VECTOR(3 downto 0);
		carryOut		:out BIT
	);
END increment;

ARCHITECTURE main OF increment IS

	COMPONENT fullAdder IS
		PORT( a1,b1 		: in  BIT;
				carryIn		: in  BIT;
				result		: out BIT;
				carryOut		: out BIT
		);
	END COMPONENT fullAdder;
	
	SIGNAL carryOutSignal : BIT_VECTOR(3 downto 0);
	
BEGIN
	-- adiciona um bit ao numero
	firstFullAdder: fullAdder
		port map(a1(0),'0','1',result(0),carryOutSignal(0));
	
	secondFullAdder: fullAdder
		port map(a1(1),'0',carryOutSignal(0),result(1),carryOutSignal(1));
	
	thirdFullAdder: fullAdder
		port map(a1(2),'0',carryOutSignal(1), result(2),carryOutSignal(2));
	
	fourthFullAdder: fullAdder
		port map(a1(3),'0',carryOutSignal(2),result(3),carryOutSignal(3));
		
		
	SIGN <= result(3); 
	OVERFLOW <= carryOutSignal(2) XOR carryOutSignal(3);
	COUT <= carryOutSignal(3);
	
END main;