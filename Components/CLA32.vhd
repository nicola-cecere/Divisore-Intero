library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity CLA32 is
	port(
		X : in std_logic_vector(31 downto 0);
		Y : in std_logic_vector(31 downto 0);
		C_IN : in std_logic;
		C_OUT : out std_logic;
		SUM : out std_logic_vector(31 downto 0)
	);
end CLA32;

architecture Rtl of CLA32 is

	component CLA8 is
		port(
		X : in std_logic_vector(7 downto 0);
		Y : in std_logic_vector(7 downto 0);
		C_IN : in std_logic;
		C_OUT : out std_logic;
		SUM : out std_logic_vector(7 downto 0)
	);
	end component;
	
	signal C : std_logic_vector(4 downto 0);

begin

	C(0) <= C_IN;

	G : for I in 0 to 3 generate
		U : CLA8
			port map(
				X => X(((I+1)*7 + I) downto 8*I),
				Y => Y(((I+1)*7 + I) downto 8*I),
				C_IN => C(I),
				C_OUT =>C(I+1),
				SUM => SUM(((I+1)*7 + I) downto 8*I)
			);
	end generate;
	
	C_OUT <= C(4);

end Rtl;

