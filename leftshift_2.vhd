library IEEE;
use IEEE.STD_LOGIC_1164.all; 
use IEEE.NUMERIC_STD.ALL;

-- Left Shift by 2 Block 2
entity leftshift_2 is
	port( lf2_in: in STD_LOGIC_VECTOR (31 downto 0);
			lf2_out: out STD_LOGIC_VECTOR (31 downto 0));
end leftshift_2;

architecture leftshift_2_arch of leftshift_2 is
begin
	lf2_out <= std_logic_vector(shift_left(unsigned(lf2_in), 2));
end leftshift_2_arch; 
