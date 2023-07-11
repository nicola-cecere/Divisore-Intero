library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity DIVIDER is
	port(
		  CLK: 	 	 in std_logic;
		  RESET: 	 in std_logic;
		  START: 	 in std_logic;
		  N_IN: 		 in std_logic_vector(31 downto 0);
		  D_IN: 	 	 in std_logic_vector(31 downto 0);
		  Q_OUT: 	 out std_logic_vector(31 downto 0);
		  R_OUT:	 	 out std_logic_vector(31 downto 0);
		  ERROR: 	 out std_logic;
		  END_READY: out std_logic
		);
end DIVIDER;

architecture Rtl of DIVIDER is

	component ERROR_CHECK is
		port(
			D : in std_logic_vector(31 downto 0);
			Q : out std_logic
		);
	end component;	
	
	component REG_PP_32 is
		port(
			CLK: 	 in std_logic;
			RESET: in std_logic;
			EN: 	 in std_logic;
			D: 	 in std_logic_vector(31 downto 0);
			Q: 	 out std_logic_vector(31 downto 0)
		);
	end component;
			
	component REG_PS_32 is
		port(
			CLK: in std_logic;
			RESET: in std_logic;
			EN: in std_logic;
			LS: in std_logic; -- 1 PER LOAD, 0 PER SHIFT
			D32: in std_logic_vector(31 downto 0);
			DSH: in std_logic; -- INGRESSO DI SHIFT
			Q32: out std_logic_vector(31 downto 0)
		);
	end component;
			
			
	component REG_SR is
		port(
			CLK: 	 in std_logic;
			RESET: in std_logic;
			S: 	 in std_logic;
			R: 	 in std_logic;
			Q: 	 out std_logic
		);
	end component;
	
	component CNT is
		port(
			RESET:	in std_logic;
			CLK:  	in std_logic;
			EN:   	in std_logic;
			TC:  		out std_logic
		);
	end component;
	
	component SHIFTER is
		port (
			D32: in std_logic_vector(31 downto 0);
			DSH: in std_logic; -- INGRESSO DI SHIFT
			EN: in std_logic; 
			Q: out std_logic_vector(31 downto 0)
		);
	end component;
		
	component SUBTRACTOR is
		port(
			SUBTRAHEND : in std_logic_vector(31 downto 0);
			MINUEND : in std_logic_vector(31 downto 0);
			DIFFERENCE : out std_logic_vector(31 downto 0);
			C_OUT : out std_logic
		);
	end component;
	
	component MUX_2_32 is
	port(
		SEL: in std_logic;
		X: in std_logic_vector(31 downto 0); -- SELEZIONATO CON 1
		Y: in std_logic_vector(31 downto 0); -- SELEZIONATO CON 0
		Z: out std_logic_vector(31 downto 0)
	);
	end component;
	
	signal START_SIG: std_logic;
	signal TC_SIG: std_logic;
	signal D_SIG: std_logic_vector(31 downto 0);
	signal N_SIG: std_logic_vector(31 downto 0);
	signal R_SIG: std_logic_vector(31 downto 0);
	signal Q_SIG: std_logic_vector(31 downto 0);
	signal R_END_SIG: std_logic_vector(31 downto 0);
	signal Q_END_SIG: std_logic_vector(31 downto 0);
	signal DIFFERENCE_SIG: std_logic_vector(31 downto 0);
	signal ERROR_SIG: std_logic;
	signal GRATHER_SIG: std_logic;
	signal EN_N: std_logic;
	signal RESET_SIG: std_logic;
	signal D32_R_SIG: std_logic_vector(31 downto 0);
	signal LS_R_SIG: std_logic; 
	signal LS_Q_SIG: std_logic;
	signal SHIFTER_SIG: std_logic_vector(31 downto 0);
	signal EN_R_Q_END: std_logic;
	

begin

		START_END : REG_SR port map(
			CLK => CLK,
			RESET => RESET,
			S => START,
			R => TC_SIG,
			Q => START_SIG
		);
		
		COUNTER : CNT port map(
			RESET => RESET_SIG,
			CLK => CLK,
			EN => START_SIG,
			TC => TC_SIG
		);
		
		ERROR_EXP : ERROR_CHECK port map (
			D => D_SIG,
			Q => ERROR_SIG
		);
		
		D : REG_PP_32 port map (
			CLK => CLK,
			RESET => RESET,
			EN => START,
			D => D_IN,
			Q => D_SIG
		);
		
		
		N : REG_PS_32 port map(
			CLK => CLK,
			RESET => RESET,
			EN => EN_N,
			LS => START,
			D32 => N_IN,
			DSH => '0',
			Q32 => N_SIG
		);
		
		Q_TEMP : REG_PS_32 port map(
			CLK => CLK,
			RESET => RESET_SIG,
			EN => START_SIG,
			LS => LS_Q_SIG,
			D32 => Q_SIG,
			DSH => GRATHER_SIG,
			Q32 => Q_SIG
		);
		
	
		R_TEMP : REG_PP_32 port map(
			CLK => CLK,
			RESET => RESET_SIG,
			EN => START_SIG,
			D => D32_R_SIG,
			Q => R_SIG
		);
		
		R_END : REG_PP_32 port map(
			CLK => CLK,
			RESET => RESET_SIG,
			EN => EN_R_Q_END,
			D => R_SIG,
			Q => R_END_SIG
		);
		
		Q_END : REG_PP_32 port map(
			CLK => CLK,
			RESET => RESET_SIG,
			EN => EN_R_Q_END,
			D => Q_SIG,
			Q => Q_END_SIG
		);
		
		SH : SHIFTER port map(
			D32 => R_SIG,
			DSH => N_SIG(31), --shift
			EN => LS_R_SIG,
			Q => SHIFTER_SIG
		);
		
		COMP_SUB : SUBTRACTOR port map(
			SUBTRAHEND => SHIFTER_SIG,
			MINUEND => D_SIG,
			DIFFERENCE => DIFFERENCE_SIG,
			C_OUT => GRATHER_SIG
		);
		
		MUX : MUX_2_32 port map(
			SEL => GRATHER_SIG,
			X => DIFFERENCE_SIG,
			Y => SHIFTER_SIG,
			Z => D32_R_SIG
		);

		Q_OUT <= Q_END_SIG; 
		R_OUT<= R_END_SIG; 
		ERROR <= ERROR_SIG;
		END_READY <= not START_SIG;
		EN_N <= START or START_SIG;
		RESET_SIG <= RESET or START;
		LS_R_SIG <= not (START or TC_SIG);
		LS_Q_SIG <= START or TC_SIG;
		EN_R_Q_END <= TC_SIG and not(ERROR_SIG);


end Rtl;

