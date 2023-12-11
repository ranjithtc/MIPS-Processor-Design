library IEEE;
use IEEE.STD_LOGIC_1164.all; 
use IEEE.NUMERIC_STD.ALL;

-- Left Shift by 2 Block 1
entity leftshift_1 is
	port( lf1_in: in STD_LOGIC_VECTOR (25 downto 0);
			lf1_out: out STD_LOGIC_VECTOR (27 downto 0));
end leftshift_1;

--Architecture of Left Shift
architecture leftshift_1_arch of leftshift_1 is
begin
	lf1_out <= std_logic_vector(lf1_in & B"00");
end leftshift_1_arch;