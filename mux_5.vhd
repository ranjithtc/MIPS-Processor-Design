library IEEE;
use IEEE.STD_LOGIC_1164.all; 
use IEEE.NUMERIC_STD.ALL;

-- MUX_5 is the input to MUX_1
entity mux_5 is 
	port( m5_a, m5_b: in STD_LOGIC_VECTOR (31 downto 0);
			m5_sel: in STD_LOGIC;
			m5_out: out STD_LOGIC_VECTOR (31 downto 0));
end mux_5;

-- Architecture of MUX_5
architecture mux_5_arch of mux_5 is
begin
	m5_out <= m5_a when (m5_sel = '0') else m5_b;
end mux_5_arch;