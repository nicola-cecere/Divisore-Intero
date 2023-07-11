library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity SUBTRACTOR is
	port(
		SUBTRAHEND : in std_logic_vector(31 downto 0);
		MINUEND : in std_logic_vector(31 downto 0);
		DIFFERENCE : out std_logic_vector(31 downto 0);
		C_OUT : out std_logic
	);
end SUBTRACTOR;

architecture Rtl of SUBTRACTOR is

	component CLA32 is
		port(
			X : in std_logic_vector(31 downto 0);
			Y : in std_logic_vector(31 downto 0);
			C_IN : in std_logic;
			C_OUT : out std_logic;
			SUM : out std_logic_vector(31 downto 0)
		);
	end component;
	
	signal Y_NEG: std_logic_vector(31 downto 0);

begin

	Y_NEG <= not MINUEND;

	SUB : CLA32 port map(
		X => SUBTRAHEND,
		Y => Y_NEG,
		C_IN => '1',
		C_OUT => C_OUT,
		SUM => DIFFERENCE
	);

end Rtl;