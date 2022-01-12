library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity interfaceULA is
    port (
        SW              :in std_logic_vector(0 to 10);
        G_LED           :out std_logic_vector(0 to 3);
        G_HEX3          :out std_logic_vector(0 to 6);
        G_HEX7          :out std_logic_vector(0 to 6);
        G_HEX5          :out std_logic_vector(0 to 6)
    );
end interfaceULA;

architecture main of interfaceULA is
    component ula_4bits is
        port (
            a1,b1				:in  std_logic_vector(3 downto 0); 
    		S0,s1,s2			:in  std_logic;
    		result		    	:out std_logic_vector(3 downto 0);
    		zeroFLAG			:out std_logic;			 	
    		negativeFLAG    	:out std_logic;		 
    		carryOutFLAG     	:out std_logic; 
    		overFlowFLAG    	:out std_logic
        );
    end component;
    
    --TEM QUE TERMINAR ISSO AQUI
    signal auxResult: std_logic_vector(0 to 3);
    signal a1_aux   :std_logic_vector(0 to 3);
    signal b1_aux   :std_logic_vector(0 to 3);
    signal s0_aux   :std_logic:=SW(8);
    signal s1_aux   :std_logic:=SW(9);
    signal s2_aux   :std_logic:=SW(10);

begin
    
    a1_aux<=SW(0 to 3);
    b1_aux<=SW(4 to 7);
    s0_aux<=SW(8);
    s1_aux<=SW(9);
    s2_aux<=SW(10);

    ulaOficial:     ula_4bits port map(a1_aux,b1_aux,s0_aux,s1_aux,s2_aux,auxResult,G_LED(0),G_LED(1),G_LED(2),G_LED(3));


        --ENTRADA A      
        with a1_aux select
        G_HEX7<="0000001" when "0000", -- '0'
                "1001111" when "0001", -- '1'
                "0010010" when "0010", -- '2'
                "0000110" when "0011", -- '3'
                "1001100" when "0100", -- '4'
                "0100100" when "0101", -- '5'
                "0100000" when "0110", -- '6'
                "0001111" when "0111", -- '7'
                "0000000" when "1000", -- '8'
                "0000100" when "1001", -- '9'
                "0001000" when "1010", -- 'A'
                "1100000" when "1011", -- 'B'
                "0110001" when "1100", -- 'C'
                "1000010" when "1101", -- 'D'
                "0110000" when "1110", -- 'E'
                "0111000" when "1111", -- 'F'
                "1111111" when others;
    
    --ENTRADA B      
        with b1_aux select
        G_HEX5<="0000001" when "0000", -- '0'
                "1001111" when "0001", -- '1'
                "0010010" when "0010", -- '2'
                "0000110" when "0011", -- '3'
                "1001100" when "0100", -- '4'
                "0100100" when "0101", -- '5'
                "0100000" when "0110", -- '6'
                "0001111" when "0111", -- '7'
                "0000000" when "1000", -- '8'
                "0000100" when "1001", -- '9'
                "0001000" when "1010", -- 'A'
                "1100000" when "1011", -- 'B'
                "0110001" when "1100", -- 'C'
                "1000010" when "1101", -- 'D'
                "0110000" when "1110", -- 'E'
                "0111000" when "1111", -- 'F'
                "1111111" when others;
        
     ---SAIDA
    with auxResult select
        G_HEX3<="0000001" when "0000", -- '0'
                "1001111" when "0001", -- '1'
                "0010010" when "0010", -- '2'
                "0000110" when "0011", -- '3'
                "1001100" when "0100", -- '4'
                "0100100" when "0101", -- '5'
                "0100000" when "0110", -- '6'
                "0001111" when "0111", -- '7'
                "0000000" when "1000", -- '8'
                "0000100" when "1001", -- '9'
                "0001000" when "1010", -- 'A'
                "1100000" when "1011", -- 'B'
                "0110001" when "1100", -- 'C'
                "1000010" when "1101", -- 'D'
                "0110000" when "1110", -- 'E'
                "0111000" when "1111", -- 'F'
                "1111111" when others;
    
        
end main;