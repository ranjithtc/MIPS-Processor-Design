library IEEE;
use IEEE.STD_LOGIC_1164.all; 
use IEEE.NUMERIC_STD.ALL;

-- Single cycle MIPS processor
entity mips is 
	port (clk, reset: in STD_LOGIC;
			readdata, instr: in STD_LOGIC_VECTOR (31 downto 0);
			memwrite: buffer STD_LOGIC;
			aluout, writedata: out STD_LOGIC_VECTOR (31 downto 0);
			pc_out: out STD_LOGIC_VECTOR (31 downto 0));
end;

--MIPS Architecture Implementation..(Containing DataPath and Controller)
architecture mips_arch of mips is

component controller is
	port (op, funct: in STD_LOGIC_VECTOR (5 downto 0);
			zero: in STD_LOGIC;
			memtoreg, memwrite, pcsrc, alusrc, regdst, regwrite, jump: out STD_LOGIC;
			alucontrol: out STD_LOGIC_VECTOR (2 downto 0)); 
end component;

component datapath is
	port (clk, reset, jump, regdst, regwrite, memtoreg, memwrite, pcsrc, alusrc: in STD_LOGIC;
			instr, read_data: in STD_LOGIC_VECTOR (31 downto 0);
			alucontrol: in STD_LOGIC_VECTOR (2 downto 0);
			zero: out STD_LOGIC;
			pc_out: out STD_LOGIC_VECTOR (31 downto 0);
			alu_result, write_data : out  STD_LOGIC_VECTOR (31 downto 0));
end component;

signal zero, memtoreg, pcsrc, alusrc, regdst, jump, regwrite: STD_LOGIC;
signal alucontrol : STD_LOGIC_VECTOR (2 downto 0);

begin

--Port Mapping for Controller and DataPath

controller1: controller
port map (op => instr(31 downto 26),
			funct => instr(5 downto 0),
			zero => zero,
			memtoreg => memtoreg,
			memwrite => memwrite,
			pcsrc => pcsrc,
			alusrc => alusrc,
			regdst => regdst,
			jump => jump,
			alucontrol=>alucontrol,
			regwrite=>regwrite
			);

datapath1: datapath
port map (
			clk => clk,
			reset => reset,
			read_data => readdata,
			zero => zero,
			instr => instr,
			memtoreg => memtoreg,
			memwrite=>memwrite,
			pcsrc => pcsrc,
			alusrc => alusrc,
			regdst => regdst,
			jump => jump,
			alucontrol => alucontrol,
			regwrite => regwrite,
			pc_out => pc_out,
			alu_result => aluout,
			write_data => writedata
			);

end mips_arch;