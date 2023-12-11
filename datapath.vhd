library IEEE;
use IEEE.STD_LOGIC_1164.all; 
use IEEE.NUMERIC_STD.ALL;

--DataPath Entity Containing all other Required Components..
entity datapath is
	port (clk, reset, jump, regdst, regwrite, memtoreg, memwrite, pcsrc, alusrc: in STD_LOGIC;
			instr, read_data: in STD_LOGIC_VECTOR (31 downto 0);
			alucontrol: in STD_LOGIC_VECTOR (2 downto 0);
			zero: out STD_LOGIC;
			pc_out: buffer STD_LOGIC_VECTOR (31 downto 0);
			alu_result, write_data : buffer  STD_LOGIC_VECTOR (31 downto 0));
end datapath;


architecture datapath_arch of datapath is

-- Register PC
component pc_register is 
	port (clk, reset: in STD_LOGIC;
			pc_in: in STD_LOGIC_VECTOR (31 downto 0);
			pc_out: buffer STD_LOGIC_VECTOR (31 downto 0));
end component;

-- PCBranch Adder
component pc_branch_adder is
	port( pcb_a, pcb_b: in STD_LOGIC_VECTOR (31 downto 0);
			pcb_out: out STD_LOGIC_VECTOR (31 downto 0));
end component;

-- PCPlus4 Adder
component pc_plus4_adder is
port ( pc4_a, pc4_b : in std_logic_vector(31 downto 0);
		 pc4_out : out std_logic_vector(31 downto 0));
end component;

--ALU
component alu is
	port( alu_a, alu_b: in STD_LOGIC_VECTOR (31 downto 0);
			alu_control: in STD_LOGIC_VECTOR (2 downto 0);
			alu_result: buffer STD_LOGIC_VECTOR (31 downto 0);
			zero: out STD_LOGIC);
end component;

-- MUX_1
component mux_1 is 
	port( m1_a, m1_b: in STD_LOGIC_VECTOR (31 downto 0);
			m1_sel: in STD_LOGIC;
			m1_out: out STD_LOGIC_VECTOR (31 downto 0));
end component;

-- MUX_2
component mux_2 is 
	port( m2_a, m2_b: in STD_LOGIC_VECTOR (4 downto 0);
			m2_sel: in STD_LOGIC;
			m2_out: out STD_LOGIC_VECTOR (4 downto 0));
end component;

-- MUX_3
component mux_3 is 
	port( m3_a, m3_b: in STD_LOGIC_VECTOR (31 downto 0);
			m3_sel: in STD_LOGIC;
			m3_out: out STD_LOGIC_VECTOR (31 downto 0));
end component;

-- MUX_4
component mux_4 is 
	port( m4_a, m4_b: in STD_LOGIC_VECTOR (31 downto 0);
			m4_sel: in STD_LOGIC;
			m4_out: out STD_LOGIC_VECTOR (31 downto 0));
end component;

-- MUX_5 is the input to MUX_1
component mux_5 is 
	port( m5_a, m5_b: in STD_LOGIC_VECTOR (31 downto 0);
			m5_sel: in STD_LOGIC;
			m5_out: out STD_LOGIC_VECTOR (31 downto 0));
end component;

-- Sign Extension
component signext is
	port( sign_in : in STD_LOGIC_VECTOR (15 downto 0);
			sign_out : out STD_LOGIC_VECTOR (31 downto 0));
end component;

-- Left Shift by 2 Block 1
component leftshift_1 is
	port( lf1_in: in STD_LOGIC_VECTOR (25 downto 0);
			lf1_out: out STD_LOGIC_VECTOR (27 downto 0));
end component;

-- Left Shift by 2 Block 2
component leftshift_2 is
	port( lf2_in: in STD_LOGIC_VECTOR (31 downto 0);
			lf2_out: out STD_LOGIC_VECTOR (31 downto 0));
end component;

-- Register File
component register_file is
    Port ( clk, we3 : in  STD_LOGIC;
           A1, A2, A3 : in  STD_LOGIC_VECTOR (4 downto 0);
           RD1, RD2 : out  STD_LOGIC_VECTOR (31 downto 0);
           WD3 : in  STD_LOGIC_VECTOR (31 downto 0));
end component;

signal pc4_out,concat_out,m1_out,RD2,sign_out,m3_out,m4_out: STD_LOGIC_VECTOR (31 downto 0);
signal lf1_out: STD_LOGIC_VECTOR (27 downto 0);
signal m2_out: STD_LOGIC_VECTOR (4 downto 0);
signal pcb_b, pcb_out, m5_out,lf2_out,alu_result1,RD1: STD_LOGIC_VECTOR (31 downto 0);

begin

write_data <= RD2;
alu_result1 <= alu_result;

-- PC Port Mapping
pc_register1: pc_register 
port map (clk => clk,
			reset => reset,
			pc_in => m1_out,
			pc_out => pc_out
			);

-- PC Branch Adder Port Mapping
pc_branch_adder1: pc_branch_adder
port map (pcb_a => lf2_out,
			pcb_b => pc4_out,
			pcb_out => pcb_out
			);

-- PC Plus 4 Adder
pc_plus4_adder1: pc_plus4_adder
port map (pc4_a => pc_out,
			pc4_b => X"00000004",
			pc4_out => pc4_out
			);

--ALU Port Mapping
alu1: alu
port map (alu_a => RD1,
			alu_b => m3_out,
			alu_control => alucontrol,
			alu_result => alu_result,
			zero => zero
			);

--MUX 1 Port Mapping
concat_out <= pc4_out(31 downto 28) & lf1_out;
mux_11: mux_1
port map (m1_a => m5_out,
			m1_b => concat_out,
			m1_sel => jump,
			m1_out => m1_out
			);

--MUX 2 Port Mapping
mux_21: mux_2
port map (m2_a => instr(20 downto 16),
			m2_sel => regdst,
			m2_b => instr(15 downto 11),
			m2_out => m2_out
			);

--MUX 3 Port Mapping
mux_31: mux_3
port map (m3_a => RD2,
			m3_b => sign_out,
			m3_sel => alusrc,
			m3_out => m3_out
			);

--MUX 4 Port Mapping
mux_41: mux_4
port map (m4_a => alu_result1,
			m4_b => read_data,
			m4_sel => memtoreg,
			m4_out => m4_out
			);

--MUX 5 Port Mapping
mux_51: mux_5
port map (m5_a => pc4_out,
			m5_b => pcb_out,
			m5_sel => pcsrc,
			m5_out => m5_out
			);

-- Sign Extension Port Mapping
signext1: signext
port map (sign_in => instr(15 downto 0),sign_out => sign_out);

-- Left Shift 1 Port Mapping
leftshift_11: leftshift_1
port map (lf1_in => instr(25 downto 0),lf1_out => lf1_out);

-- Left Shift 2 Port Mapping
leftshift_21: leftshift_2
port map (lf2_in => sign_out,lf2_out => lf2_out);

-- Register File Port Mapping
register_file1: register_file
port map (clk => clk,
			A1 => instr(25 downto 21),
			A2 => instr(20 downto 16),
			A3 => m2_out,
			WD3 => m4_out,
			RD1 => RD1,
			RD2 => RD2,
			we3 => regwrite
			);

end datapath_arch;