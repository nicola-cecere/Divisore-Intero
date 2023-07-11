library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity SHIFTER is
	port(
		D32 : in std_logic_vector(31 downto 0);
		DSH : in std_logic; --shift input
		EN : in std_logic; 
		Q : out std_logic_vector(31 downto 0)
	);
end  SHIFTER;

architecture Rtl of  SHIFTER is

begin

	with EN select
		Q(31 downto 0) <= D32(30 downto 0) & DSH  when '1',
								D32 when others;

end Rtl;

