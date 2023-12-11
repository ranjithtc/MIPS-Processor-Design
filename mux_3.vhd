library IEEE;
use IEEE.STD_LOGIC_1164.all; 
use IEEE.NUMERIC_STD.ALL;

-- MUX_3
entity mux_3 is 
	port( m3_a, m3_b: in STD_LOGIC_VECTOR (31 downto 0);
			m3_sel: in STD_LOGIC;
			m3_out: out STD_LOGIC_VECTOR (31 downto 0));
end mux_3;

-- Architecture of MUX_3
architecture mux_3_arch of mux_3 is
begin
	m3_out <= m3_a when (m3_sel = '0') else m3_b;
end mux_3_arch;