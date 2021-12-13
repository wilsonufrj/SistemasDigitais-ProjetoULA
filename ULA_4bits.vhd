--Sistemas Digitais - Projeto 1: Desenvolver uma ULA
--Authors: Rodrigo e Wilson Ramos
--Data: 12/12/2021

ENTITY ULA_4bits IS
	PORT(
		a1,b1				:in  BIT_VECTOR(3 downto 0); --Talvez ter um bit de sinal
		S0,s1,s2			:in  BIT;
		carryIn			:in  BIT;
		result			:out BIT_VECTOR(3 downto 0);
		zero				:out BIT;
		negative			:out BIT;
		carryOut			:out BIT;
		overFlow			:out BIT
		);
		
END ULA_4bits;

--O que falta implementar e testar?
-- Implementar a saida carryOut para ser 1 quando houver um carry out
-- Implementar a saida overflow quando a soma estourar os 4 bits de entrada
-- Implementar quando o negativo que vai sinalizar quando o numero é negativo

ARCHITECTURE main of ULA_4bits IS

		--Declaração do somador de 4 bits
		COMPONENT adder4Bits IS
			PORT(
				a1,b1			:in  BIT_VECTOR(3 downto 0);
				carryIn		:in  BIT;
				result		:out BIT_VECTOR(3 downto 0);
				carryOut		:out BIT
			);
		END COMPONENT adder4Bits;
	
		--Sinais internos da ULA
		SIGNAL arithmetic, logic 			:BIT_VECTOR(3 downto 0);
		SIGNAL selector						:BIT_VECTOR(1 downto 0);
		SIGNAL adderOne,addBits				:BIT_VECTOR(3 downto 0);
		SIGNAL carryOne, carryBits			:BIT;
		
			
BEGIN
	
	firstAdder: adder4Bits port map(a1,b1,carryIn,addBits,carryBits);
	adderPluOne: adder4Bits port map(a1,"0001",carryIn,adderOne,carryOne);
	
	selector<= s0 & s1;
	
	WITH selector SELECT
			arithmetic <= 	addBits					WHEN "00", --Ver o que fazer com o carryOut e o overflow
								--a1 + (NOT(b1)+"0001") 	WHEN "01", -- Refazer não é tao simples assim
								adderOne					WHEN OTHERS;
								-- Falta implementar a troca de sinal que eu nao sei ainda
								
	WITH selector select
		logic <= "1111" 		WHEN "00", -- Preset
					a1 AND b1   WHEN "01",
					"0000"	   WHEN "10", --clear
					a1 OR b1		WHEN "11";
				
		
	result<= arithmetic WHEN s2 = '0' ELSE logic;
	
							
								
								
END main;