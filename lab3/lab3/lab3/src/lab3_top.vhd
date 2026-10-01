-------------------------------------------------------------------------------
-- Cameron Marsh
-- Top level for seven segment display counter
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;      

entity lab3_top is
	port(
	clk		: in std_logic;
	reset	: in std_logic;
	SSD_out	: out std_logic_vector(6 downto 0)
	);
end entity lab3_top;  

architecture beh of lab3_top  is
-- declarative
	component seven_seg is
	  port (
		clk             : in std_logic; 
		reset           : in std_logic;
		bcd             : in std_logic_vector(3 downto 0);
		seven_seg_out   : out std_logic_vector(6 downto 0)
	  );  
	end component; 

	component generic_adder is
	  generic (
		bits    : integer := 4
	  );
	  port (
		a       : in  std_logic_vector(bits-1 downto 0);
		b       : in  std_logic_vector(bits-1 downto 0);
		cin     : in  std_logic;
		sum     : out std_logic_vector(bits-1 downto 0);
		cout    : out std_logic
	  );
	end component;

	component generic_counter is
	  generic (
		max_count       : integer := 50000000 -- for 50MHz clock, 50 million clocks
	  );									  -- = 1 count per second			
	  port (
		clk             : in  std_logic; 
		reset           : in  std_logic;
		out_flag          : out std_logic
	  );  
	end component;  

	signal sum : std_logic_vector(3 downto 0);
	signal sum_sig : std_logic_vector(3 downto 0) := "0000";
	signal enable : std_logic;

begin
-- instantiation
	adder : generic_adder
	generic map(
	bits => 4
	)
	port map(
	a => sum_sig,
	b => "0001",
	sum => sum,
	cin => '0',
	cout => open
	);
	counter : generic_counter
	generic map(
		max_count => 5
	)
	port map(
		clk		=> clk,
		reset	=> reset,
		out_flag	=> enable
	);
	displayer : seven_seg
	port map(
		clk => clk,
		reset => reset,
		bcd => sum_sig,
		seven_seg_out => SSD_out
	);
-- sum_register process
	sum_register: process(clk,enable,sum)
	begin
		if rising_edge(clk) and enable='1' then
			if sum_sig = "1001" then
				sum_sig <= "0000";
			else
				sum_sig <= sum;
			end if;
		end if;
	end process;
end beh;