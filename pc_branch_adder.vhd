library IEEE;
use IEEE.STD_LOGIC_1164.all; 
use IEEE.NUMERIC_STD.ALL;

-- PCBranch Adder
entity pc_branch_adder is
	port(	pcb_a, pcb_b: in STD_LOGIC_VECTOR (31 downto 0);
			pcb_out: out STD_LOGIC_VECTOR (31 downto 0));
end pc_branch_adder;


-- Architecture of PC_Branch_Adder
architecture pc_branch_adder_arch of pc_branch_adder is
begin
	pcb_out <= std_logic_vector((unsigned(pcb_a))+(unsigned(pcb_b)));
end pc_branch_adder_arch;
