-- Bibliotecas e pacotes

-- Entidade
entity logic_or is
    port(
        a, b    :   in  bit;
        z       :   out bit
    );
end logic_or;

-- Arquitetura
architecture main of logic_or is
begin

    z <= a or b;
    
end architecture main;