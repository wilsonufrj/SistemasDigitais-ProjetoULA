ENTITY sub4Bits IS
	PORT(
		a1,b1			:in  BIT_VECTOR(3 downto 0);
		carryIn		:in  BIT;
		result		:out BIT_VECTOR(3 downto 0);
		carryOut		:out BIT
	);
END sub4Bits;



ARCHITECTURE main OF sub4Bits IS

	COMPONENT fullAdder IS
		PORT( a1,b1 		: in  BIT;
				carryIn		: in  BIT;
				result		: out BIT;
				carryOut		: out BIT
		);
	END COMPONENT fullAdder;
	
	SIGNAL bufer, buferResult,buferCarryOut : BIT_VECTOR (3 downto 0);
	SIGNAL carryOutSignal : BIT_VECTOR(3 downto 0);
	
BEGIN

	-- Aplica o complemento de 2 em b
	
	bufer <= not b1;
	
	bFirstFAdder: fullAdder
		port map(bufer(0),'1','0',buferResult(0),buferCarryOut (0));
	
	bSecondFAdder: fullAdder
		port map(bufer(1),'0',buferCarryOut (0), buferResult(1),buferCarryOut (1));
	
	bThirdFAdder: fullAdder
		port map(bufer(2),'0',buferCarryOut (1), buferResult(2),buferCarryOut (2));
	
	bFourthFAdder: fullAdder
		port map(bufer(3),'0',buferCarryOut (2), buferResult(3), buferCarryOut(3));
		
	
	-- Realiza a subtracao
	
	
	sumFirstFullAdder: fullAdder
		port map(buferResult(0),a1(0),carryIn,result(0),carryOutSignal(0));
	
	sumSecondFullAdder: fullAdder
		port map(buferResult(1),a1(1),carryOutSignal(0),result(1),carryOutSignal(1));
	
	sumThirdFullAdder: fullAdder
		port map(buferResult(2),a1(2),carryOutSignal(1), result(2),carryOutSignal(2));
	
	sumFourthFullAdder: fullAdder
		port map(buferResult(3),a1(3),carryOutSignal(2),result(3),carryOutSignal(3));
		
		
	SIGN <= result(3); 
	OVERFLOW <= carryOutSignal(2) XOR carryOutSignal(3);
	COUT <= carryOutSignal(3);
	ZERO <= '1' when (result = "0000") else '0';
	
END main;