library IEEE;
use IEEE.STD_LOGIC_1164.all; 
use IEEE.NUMERIC_STD.ALL;

-- MUX_1
entity mux_1 is 
	port( m1_a, m1_b: in STD_LOGIC_VECTOR (31 downto 0);
			m1_sel: in STD_LOGIC;
			m1_out: out STD_LOGIC_VECTOR (31 downto 0));
end mux_1;

-- Architecture of MUX_1
architecture mux_1_arch of mux_1 is
begin
	m1_out <= m1_a when (m1_sel = '0') else m1_b;
end mux_1_arch;