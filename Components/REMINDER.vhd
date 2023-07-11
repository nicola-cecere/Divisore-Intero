library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity REMINDER is
	port(
		CLK: in std_logic;
		RESET: in std_logic;
		EN: in std_logic;
		LS: in std_logic; -- 1 PER LOAD, 0 PER SHIFT
		D32: in std_logic_vector(31 downto 0);
		DSH: in std_logic; -- INGRESSO DI SHIFT
		Q32N: out std_logic_vector(31 downto 0);
		--QSHN: out std_logic; -- USCITA DI SHIFR
		Q32R: out std_logic_vector(31 downto 0)
		--QSHR: out std_logic -- USCITA DI SHIFR
	);
end REMINDER;

architecture Rtl of REMINDER is

	component REG_PS_32 is
		port(
			CLK: in std_logic;
			RESET: in std_logic;
			EN: in std_logic;
			LS: in std_logic; -- 1 PER LOAD, 0 PER SHIFT
			D32: in std_logic_vector(31 downto 0);
			DSH: in std_logic; -- INGRESSO DI SHIFT
			Q32: out std_logic_vector(31 downto 0)
			--QSH: out std_logic -- USCITA DI SHIFT
		);
	end component;
	
	signal N_Q32: std_logic_vector(31 downto 0);

begin

	

	N : REG_PS_32 port map(
		CLK => CLK,
		RESET => RESET,
		EN => EN,
		LS => LS,
		D32 => D32,
		DSH => DSH,
		Q32 => N_Q32
		--QSH => N_QSH
	);
	
	R : REG_PS_32 port map(
		CLK => CLK,
		RESET => RESET,
		EN => EN,
		LS => LS,
		D32 => (others => '0'),
		DSH =>	N_Q32(31),
		Q32 => Q32R
		--QSH => QSHR
	);
	
	Q32N <= N_Q32;

end Rtl;

