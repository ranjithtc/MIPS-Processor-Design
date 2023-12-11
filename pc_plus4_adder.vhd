library IEEE;
use IEEE.STD_LOGIC_1164.all; 
use IEEE.NUMERIC_STD.ALL;

-- PC_Plus4_Adder Entity
entity pc_plus4_adder is
port ( pc4_a, pc4_b : in std_logic_vector(31 downto 0);
		 pc4_out : out std_logic_vector(31 downto 0));
end pc_plus4_adder;


-- Architecture of PC_Plus4_Adder
architecture pc_plus4_adder_arch of pc_plus4_adder is
begin
	pc4_out <= std_logic_vector(unsigned(pc4_a)+ unsigned(pc4_b));
end pc_plus4_adder_arch;
