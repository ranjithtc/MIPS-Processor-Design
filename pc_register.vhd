library IEEE;
use IEEE.STD_LOGIC_1164.all; 
use IEEE.NUMERIC_STD.ALL;

-- Register PC
entity pc_register is 
	port (clk, reset: in STD_LOGIC;
			pc_in: in STD_LOGIC_VECTOR (31 downto 0);
			pc_out: out STD_LOGIC_VECTOR (31 downto 0));
end pc_register;

-- Architecture of PC (Program Counter)
architecture pc_register_arch of pc_register is
begin
	process (clk, reset) 
	begin
		if reset = '1' then
			pc_out <= X"FFFFFFFC";
		elsif clk'event and clk = '1' then
			pc_out <= pc_in;
		end if;
	end process;

end pc_register_arch;