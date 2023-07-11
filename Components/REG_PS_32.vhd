library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity REG_PS_32 is
	port(
		CLK: in std_logic;
		RESET: in std_logic;
		EN: in std_logic;
		LS: in std_logic; -- 1 PER LOAD, 0 PER SHIFT
		D32: in std_logic_vector(31 downto 0);
		DSH: in std_logic; -- INGRESSO DI SHIFT
		Q32: out std_logic_vector(31 downto 0)
	);
end REG_PS_32;

architecture Rtl of REG_PS_32 is

	signal Q32_SIG : std_logic_vector(31 downto 0);
	signal DSH_SIG : std_logic;
	
begin

	DSH_SIG <= DSH;
	
	process(CLK)
		begin
			if(CLK'event and CLK = '1') then
				if(RESET = '1') then
					Q32_SIG <= (others => '0');
				else
					if(EN = '1') then
						if(LS = '1') then
							Q32_SIG <= D32;
						else
							Q32_SIG <= Q32_SIG(30 downto 0) & DSH_SIG;
						end if;
					else
						Q32_SIG <= Q32_SIG;
					end if;
				end if;
			end if;
		end process;

	Q32 <= Q32_SIG;

end Rtl;

