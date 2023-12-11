library IEEE;
use IEEE.STD_LOGIC_1164.all; 
use IEEE.NUMERIC_STD.ALL;

-- Sign Extension
entity signext is
	port(	sign_in : in std_logic_vector(15 downto 0);
			sign_out : out std_logic_vector(31 downto 0));
end signext;

--Architecture of Sign Extension
architecture signext_arch of signext is
begin
	sign_out <= X"0000"&sign_in when(sign_in(15) = '0') else X"FFFF"&sign_in;
end signext_arch;