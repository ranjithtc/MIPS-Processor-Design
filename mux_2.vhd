library IEEE;
use IEEE.STD_LOGIC_1164.all; 
use IEEE.NUMERIC_STD.ALL;

-- MUX_2
entity mux_2 is 
	port( m2_a, m2_b: in STD_LOGIC_VECTOR (4 downto 0);
			m2_sel: in STD_LOGIC;
			m2_out: out STD_LOGIC_VECTOR (4 downto 0));
end mux_2;

-- Architecture of MUX_2
architecture mux_2_arch of mux_2 is
begin
	m2_out <= m2_a when (m2_sel = '0') else m2_b;
end mux_2_arch;
