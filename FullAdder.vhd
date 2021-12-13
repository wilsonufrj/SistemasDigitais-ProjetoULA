ENTITY fullAdder IS
	PORT( a1,b1 		: in  BIT;
			carryIn		: in  BIT;
			result		: out BIT;
			carryOut		: out BIT
	);
	
END fullAdder;

ARCHITECTURE main OF fullAdder IS
	
	COMPONENT halfAdder IS 
		PORT(
			a1,b1				:in BIT;
			result			:out BIT;
			carryOut			:out BIT
		);
	END COMPONENT halfAdder;
	
	SIGNAL outFirstAdder, carryFirstAdder, carrySecondAdder : BIT;
		
BEGIN 
	half1: halfAdder
		port map(a1, b1, outFirstAdder, carryFirstAdder);
		
	halfFinal: halfAdder
		port map(outFirstAdder,carryIn, result,carrySecondAdder);
		
	carryOut<= carrySecondAdder or carryFirstAdder;
	
	
	
END main;