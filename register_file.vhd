library IEEE;
use IEEE.STD_LOGIC_1164.all; 
use IEEE.NUMERIC_STD.ALL;

-- Register File
entity register_file is
    Port ( clk, we3 : in  STD_LOGIC;
           A1, A2, A3 : in  STD_LOGIC_VECTOR (4 downto 0);
           RD1, RD2 : out  STD_LOGIC_VECTOR (31 downto 0);
           WD3 : in  STD_LOGIC_VECTOR (31 downto 0));
end register_file;

architecture register_file_arch of register_file is

type ram is array(0 to 31) of std_logic_vector(31 downto 0);
signal ram1 : ram;

begin
	process(clk)
	begin
		if(clk'event and clk='1') then
			if (we3='1') then
				ram1(to_integer(unsigned(A3)))<=WD3;
			end if;
		end if;
	end process;

	RD1<=ram1(to_integer(unsigned(A1)));

	RD2<=ram1(to_integer(unsigned(A2)));

end register_file_arch;