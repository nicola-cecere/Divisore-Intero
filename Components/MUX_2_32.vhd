library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



entity MUX_2_32 is
	port(
		SEL: in std_logic;
		X: in std_logic_vector(31 downto 0); -- SELEZIONATO CON 1
		Y: in std_logic_vector(31 downto 0); -- SELEZIONATO CON 0
		Z: out std_logic_vector(31 downto 0)
	);
end MUX_2_32;

architecture Rtl of MUX_2_32 is

begin

	with SEL select
			Z <= X when '1',
				  Y when others;

end Rtl;

