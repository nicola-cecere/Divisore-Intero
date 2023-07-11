library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ERROR_CHECK is
	port(
		D : in std_logic_vector(31 downto 0);
		Q : out std_logic
	);
end ERROR_CHECK;

architecture Rtl of ERROR_CHECK is

	signal ZERO_SIG : std_logic_vector(31 downto 0);

begin
	
	ZERO_SIG <= (others => '0');
	Q <= '1' when (D = ZERO_SIG) else '0';

end Rtl;

