library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity CNT is
	port(
		 RESET:		in std_logic;
		 CLK:  		in std_logic;
		 EN:   		in std_logic;
		 TC:  		out std_logic
		);
end CNT;

architecture Rtl of CNT is

	component CLA8 is
		port(
		X : in std_logic_vector(7 downto 0);
		Y : in std_logic_vector(7 downto 0);
		C_IN : in std_logic;
		C_OUT : out std_logic;
		SUM : out std_logic_vector(7 downto 0)
	);
	end component;

	component REG_PP_8 is
		port(
			CLK: 	 in std_logic;
		  	RESET: in std_logic;
		  	EN: 	 in std_logic;
		  	D: 	 in std_logic_vector(7 downto 0);
		  	Q: 	 out std_logic_vector(7 downto 0)
		);
	end component;

	signal TC_SIG: std_logic_vector(7 downto 0);
	signal Q_SIG: std_logic_vector(7 downto 0);
	signal SUM_SIG: std_logic_vector(7 downto 0);

begin


	LOOP8 : CLA8 port map(
		X => Q_SIG,
		Y => "00000001", 
		C_IN => '0',
		SUM => SUM_SIG
		);

	PP_8 : REG_PP_8 port map(
			CLK => CLK,
			RESET => RESET,
			EN => EN,
			D => SUM_SIG,
			Q => Q_SIG
		);
		

	TC_SIG <= "00011111";
		
	process(CLK)
	begin
		if(CLK'event and CLK = '1') then 
			if (Q_SIG = TC_SIG) then
				TC <= '1';
			else
				TC <= '0';
			end if;
		end if;
	end process;
	

end Rtl;



