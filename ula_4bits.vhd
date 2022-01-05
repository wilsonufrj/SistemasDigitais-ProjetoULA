--Sistemas Digitais - Projeto 1: Desenvolver uma ULA
--Authors: Rodrigo Pinto e Wilson Ramos
--Data: 12/12/2021

library IEEE;
use IEEE.STD_LOGIC_1164.all;


ENTITY ULA_4bits IS
	
	PORT(
		a1,b1				:in  std_logic_vector(3 downto 0); 
		S0,s1,s2			:in  std_logic;
		result			:out std_logic_vector(3 downto 0);
		zeroFLAG			:out std_logic;			 	
		negativeFLAG	:out std_logic;		 
		carryOutFLAG	:out std_logic; 
		overFlowFLAG	:out std_logic	
		);								
		
END ULA_4bits;


ARCHITECTURE main of ULA_4bits IS

		--Declaração do somador de 4 bits 
		COMPONENT adder4Bits IS
			PORT(
				a1,b1					:in  std_logic_vector(3 downto 0);
				result				:out std_logic_vector(3 downto 0);
				zeroFLAG				:out std_logic;
				carryOutFLAG		:out std_logic;
				overFlowFLAG		:out std_logic
			);
		END COMPONENT adder4Bits;
		
		COMPONENT changeSignal IS
			PORT(
			a1						:in  std_logic_vector(3 downto 0); 
			result				:out std_logic_vector(3 downto 0);
			negativeFLAG		:out std_logic
			);
		END COMPONENT changeSignal;
		
		COMPONENT subtrator4Bits IS
			PORT(
				a1,b1				:in  std_logic_vector(3 downto 0);
				result			:out std_logic_vector(3 downto 0);
				negativeFLAG	:out std_logic;
				zeroFLAG			:out std_logic
				
			);
		END COMPONENT subtrator4Bits;
		
		
		
		--Sinais internos da ULA
		--Sinais internos para o resultado
		SIGNAL arithmetic, logic 												:std_logic_vector(3 downto 0); --Resultado Final da ULA
		SIGNAL selector															:std_logic_vector(1 downto 0); --Seletor do resultado
		SIGNAL addBits,addOne,changeSignalResult,subtratorBits		:std_logic_vector(3 downto 0); --Sinais internos que armazenam o resultado
		--Sinais Internos para as Flags
		--FLAG CarryOut
		SIGNAL flagCarry													:std_logic;
		SIGNAL carry4Bits,carryAddOne									:std_logic;
		--FLAG OverFlow
		SIGNAL flagOverFlow												:std_logic;
		SIGNAL overFlow4Bits, overFlowAddOne						:std_logic;
		--FLAG negative
		SIGNAL flagNegative												:std_logic;
		SIGNAL negativeSubtrator, negativeChangeSignal			:std_logic;
		--FLAG zero
		SIGNAL flagZero													:std_logic;
		SIGNAL zeroAdder4Bits,zeroAddOne,zeroSubtrator			:std_logic;
		
			
BEGIN
	
	firstAdder: 			adder4Bits port map(a1,b1,addBits,zeroAdder4Bits,carry4Bits,overFlow4Bits);
	adderPluOne: 			adder4Bits port map(a1,"0001",addOne,zeroAddOne,carryAddOne,overFlowAddOne);
	subtrator:				subtrator4Bits port map(a1,b1,subtratorBits,negativeSubtrator,zeroSubtrator);
	changeSignals:			changeSignal port map(a1,changeSignalResult,negativeChangeSignal);			
	
	selector<= s0 & s1;
	
	WITH selector SELECT
			arithmetic <= 	addBits					WHEN "00",
								addOne					WHEN "01",
								changeSignalResult	WHEN "10",
								subtratorBits			WHEN OTHERS;
							
	
	WITH selector SELECT
		logic <= "1111" 		WHEN "00", -- Preset
					a1 AND b1   WHEN "01",
					"0000"	   WHEN "10", --clear
					a1 OR b1		WHEN OTHERS;
					
				
	--Resultado Final	
	result<= arithmetic WHEN s2 = '0' ELSE logic;	
	
	--Flag Carry Out
	WITH selector SELECT
		flagCarry <= carry4Bits 		WHEN "00",
						 carryAddOne		WHEN "01",
						 '0'					WHEN OTHERS;
									  
	carryOutFLAG<=flagCarry WHEN s2='0' ELSE '0';
	
	--Flag OverFlow
	WITH selector SELECT
		flagOverFlow <= overFlow4Bits 		WHEN "00",
							 overFlowAddOne		WHEN "01",
							 '0'						WHEN OTHERS;
									  
	overFlowFLAG<=flagOverFlow WHEN s2='0' ELSE '0';
	
	--Flag Negative
	WITH selector SELECT
		flagNegative<= negativeSubtrator 		WHEN "11",
							negativeChangeSignal		WHEN "10",
							'0'							WHEN OTHERS;
	
	negativeFLAG<=flagNegative WHEN s2='0' ELSE '0';
	
	---Flag zero
	WITH selector SELECT
		flagZero<= zeroAdder4Bits	WHEN "00",
					  zeroAddOne		WHEN "01",
					  zeroSubtrator	WHEN "11",
					  '0'					WHEN OTHERS;
					  
	zeroFLAG<=flagZero WHEN s2='0' ELSE '0';
	

END main;
