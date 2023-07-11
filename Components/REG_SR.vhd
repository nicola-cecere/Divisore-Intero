library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity REG_SR is
	port(
		  CLK: 	 in std_logic;
		  RESET: in std_logic;
		  S: 	 in std_logic;
		  R: 	 in std_logic;
		  Q: 	 out std_logic
		);
end REG_SR;

architecture Rtl of REG_SR is

	signal Q_SIG : std_logic;

begin
	
	process(CLK)
		begin
			if(CLK'event and CLK = '1') then
				if(RESET = '1') then
					Q_SIG <= '0';
				else
					if(S = '1' and R = '0') then
						Q_SIG <= '1';
					elsif (S = '0' and R = '1') then
						Q_SIG <= '0';
					elsif ( S = '0' and R = '0') then
						Q_SIG <= Q_SIG;
					elsif ( S = '1' and R = '1') then
						Q_SIG <= 'X';
					end if;
				end if;
			end if;
		end process;

	Q <= Q_SIG;

end Rtl;

