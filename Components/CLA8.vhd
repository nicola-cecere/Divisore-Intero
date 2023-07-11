library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity CLA8 is
	port(
		X : in std_logic_vector(7 downto 0);
		Y : in std_logic_vector(7 downto 0);
		C_IN : in std_logic;
		C_OUT : out std_logic;
		SUM : out std_logic_vector(7 downto 0)
	);
end CLA8;

architecture Rtl of CLA8 is

	signal GENERATION : std_logic_vector(7 downto 0);
	signal PROPAGATION : std_logic_vector(7 downto 0);
	signal C : std_logic_vector(8 downto 0);

begin

	GENERATION <= X and Y;
	
	PROPAGATION <= X or Y;
	
	C(0) <= C_IN;
	
	CarryLoop: for I in 0 to 7 generate
		C(I+1) <= GENERATION(I) or ( PROPAGATION(I) and C(I) );
	end generate CarryLoop;
	
	SUM <= X xor Y xor C(7 downto 0);
	
	C_OUT <= C(8);


end Rtl;