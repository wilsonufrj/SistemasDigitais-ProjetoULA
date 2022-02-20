library IEEE;
use ieee.std_logic_1164.all;
use IEEE.NUMERIC_STD.all;


entity Projeto2 is
	port(
		frontSensor,backSensor 	 :in std_logic;
		clk,dinheiro,reset		 :in std_logic;
		senha 						 :in std_logic_vector(3 downto 0);
		
		ledVerde						 :out std_logic; 
		ledVermelho					 :out std_logic;
		valorAPAgar					 :out std_logic_vector(6 downto 0)
		
	
	);
end Projeto2;

architecture main of Projeto2 is
	
	type estados is (inicial,esperaSenha,recebeCinco,recebeSete,esperaSaida);
	
	signal estadoAtual,proximoEstado	:estados;
	signal vermelhoAux,verdeAux		:std_logic:='0';
	signal contaEspera					:unsigned(1 downto 0):="00";
	
	signal dinheiroTotal					:unsigned(3 downto 0):="0000";
	signal podeSair						:std_logic:='0';
	signal resetAux						:std_logic:='0';
	signal valorAPAgarAux				:std_logic_vector(3 downto 0);

	
begin
	--Process que defini a logica principal do estacionamento
	estadosProjeto: process(estadoAtual,senha,frontSensor,backSensor,contaEspera,podeSair)
							begin
								case estadoAtual is
									when inicial=>
											if(frontSensor='1') then
												proximoEstado<=esperaSenha;
												
											else
												proximoEstado<=inicial;
												
												
											end if;
											
									when esperaSenha=>
											if(contaEspera < 2)then
												proximoEstado<=esperaSenha;
											
											else
												if(senha="1010") then
													proximoEstado<=recebeCinco; 
													valorAPAgarAux<="0101";
												
												else
													proximoEstado<=recebeSete;
													valorAPAgarAux<="0111";
												
												end if;
											end if;
											
									when recebeCinco=> 
												if(podeSair = '1') then
													proximoEstado<=esperaSaida;
												else
													proximoEstado<=recebeCinco;
												end if;
										
									
									when recebeSete=> 
												if(podeSair = '1') then
														proximoEstado<=esperaSaida;
													else
														proximoEstado<=recebeSete;
												end if;
										
									when esperaSaida=> 
										if(backSensor='1' or frontSensor='1') then
											proximoEstado<=esperaSaida;
										else
											proximoEstado<=inicial; --Ver depois
										end if;
										
								end case;
									
						end process;
						

	receberCinco: process(clk)
							begin
								if(estadoAtual = recebeCinco) then
									if(dinheiroTotal>=5) then
										podeSair<='1';		
									else
										if(dinheiro='0') then
											dinheiroTotal<= dinheiroTotal + 1;
										else 
											dinheiroTotal<= dinheiroTotal + 2;
										end if;
									end if;
									
								elsif(estadoAtual = recebeSete) then
									if(dinheiroTotal>=7) then
											podeSair<='1';		
										else
											if(dinheiro='0') then
												dinheiroTotal<= dinheiroTotal + 1;
											else 
												dinheiroTotal<= dinheiroTotal + 2;
											end if;
										end if;
										
								elsif(estadoAtual = inicial) then
									dinheiroTotal<="0000";
							end if;
									
						end process;
			
	--Process que espera um tempo pra receber a senha
	incrementaContador: process(clk,reset)
									begin
										if(reset='1') then
											contaEspera<=(others=>'0');
											
										elsif(clk'event and clk='1') then
											if(estadoAtual = esperaSenha) then
												contaEspera<= contaEspera+1;
												
											else
												contaEspera<=(others=>'0');
											
											end if;
											
										end if;
								end process;
	
	--Process do estado atual para o proximo
	mudancaEstado: process(clk,reset)
							begin
								if(reset='1') then
									estadoAtual<=inicial;
									
								elsif(clk'event and clk='1') then
									estadoAtual<=proximoEstado;
								
								end if;
						end process;
						
	--Process que declara o valor dos leds de saida
	saidaLeds:process(clk)
					begin
						case estadoAtual is
							when inicial=>
								verdeAux<='0';
								vermelhoAux<='1';
							
							when esperaSenha=>
								verdeAux<='0';
								vermelhoAux<='1';
								
							when recebeCinco=>
								verdeAux<='0';
								vermelhoAux<='1';
								
							when recebeSete=> 
								verdeAux<='0';
								vermelhoAux<='1';
							
							when esperaSaida=>
								verdeAux<='1';
								vermelhoAux<= not vermelhoAux;
							
						end case;
				end process;
	
	with valorAPAgarAux select
			valorAPAgar<= "0100100" when "0101",
							  "0001111" when "0111", 
							  "0000000" when others;
		
	
	ledVerde<=verdeAux;
	ledVermelho<=vermelhoAux;
	
end main;
