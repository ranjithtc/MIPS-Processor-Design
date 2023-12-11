library IEEE;
use IEEE.STD_LOGIC_1164.all; 
use IEEE.NUMERIC_STD.ALL;

-- MUX_4
entity mux_4 is 
	port( m4_a, m4_b: in STD_LOGIC_VECTOR (31 downto 0);
			m4_sel: in STD_LOGIC;
			m4_out: out STD_LOGIC_VECTOR (31 downto 0));
end mux_4;

-- Architecture of MUX_4
architecture mux_4_arch of mux_4 is
begin
	m4_out <= m4_a when (m4_sel = '0') else m4_b;
end mux_4_arch;