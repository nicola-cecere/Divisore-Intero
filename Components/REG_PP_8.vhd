library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity REG_PP_8 is
	port( 
		  CLK: 	 in std_logic;
		  RESET: in std_logic;
		  EN: 	 in std_logic;
		  D: 	 in std_logic_vector(7 downto 0);
		  Q: 	 out std_logic_vector(7 downto 0)
		);
end REG_PP_8;

architecture Rtl of REG_PP_8 is

	signal Q_SIG : std_logic_vector(7 downto 0);

begin

	process(CLK)
	begin
		if(CLK'event and CLK = '1') then
			if(RESET = '1') then
				Q_SIG <= (others => '0');
			else
				if(EN = '1') then
					Q_SIG <= D;
				else
					Q_SIG <= Q_SIG;
				end if;
			end if;
		end if;
	end process;

	Q <= Q_SIG;

end Rtl;

