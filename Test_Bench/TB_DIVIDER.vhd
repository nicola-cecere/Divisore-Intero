LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

 
ENTITY TB_DIVIDER IS
END TB_DIVIDER;
 
ARCHITECTURE behavior OF TB_DIVIDER IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT DIVIDER
    PORT(
         CLK : IN  std_logic;
         RESET : IN  std_logic;
         START : IN  std_logic;
         N_IN : IN  std_logic_vector(31 downto 0);
         D_IN : IN  std_logic_vector(31 downto 0);
         Q_OUT : OUT  std_logic_vector(31 downto 0);
         R_OUT : OUT  std_logic_vector(31 downto 0);
         ERROR : OUT  std_logic;
         END_READY : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal CLK : std_logic;
   signal RESET : std_logic;
   signal START : std_logic;
   signal N_IN : std_logic_vector(31 downto 0);
   signal D_IN : std_logic_vector(31 downto 0);

 	--Outputs
   signal Q_OUT : std_logic_vector(31 downto 0);
   signal R_OUT : std_logic_vector(31 downto 0);
   signal ERROR : std_logic;
   signal END_READY : std_logic;

   -- Clock period definitions
   constant CLK_period : time := 58 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: DIVIDER PORT MAP (
          CLK => CLK,
          RESET => RESET,
          START => START,
          N_IN => N_IN,
          D_IN => D_IN,
          Q_OUT => Q_OUT,
          R_OUT => R_OUT,
          ERROR => ERROR,
          END_READY => END_READY
        );

   -- Clock process definitions
   CLK_process :process
   begin
		CLK <= '0';
		wait for CLK_period/2;
		CLK <= '1';
		wait for CLK_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
		RESET <= '1';
		
      wait for 100 ns;
		
		RESET <= '0';

      -- insert stimulus here 
		
		------------------------------------------- N < D --------------------------------------------------------
		
		START <= '1';
		N_IN <= (2 => '1', others => '0'); -- 4
		D_IN <= (2 => '1', 1 => '1', 0 => '1', others => '0'); -- 7
		
		-- R = 4, Q = 0
		
		wait for CLK_period;
		
		START <= '0';
		
		wait for CLK_period*33;
		
		START <= '1';
		N_IN <= (others => '0'); -- 0
		D_IN <= (3 => '1', others => '0'); -- 8
		
		-- R = 0, Q = 0
		
		wait for CLK_period;
		
		START <= '0';
		
		wait for CLK_period*33;
		
		START <= '1';
		N_IN <= (31 => '0', others => '1') ; -- 2.147.483.647
		D_IN <= (others => '1'); -- 4.294.967.295
		
		-- R = 2.147.483.647, Q = 0
		
		wait for CLK_period;
		
		START <= '0';
		
		wait for CLK_period*33;
		
		START <= '1';
		N_IN <= (0 => '0', others => '1') ; -- 4.294.967.294
		D_IN <= (others => '1'); -- 4.294.967.295
		
		-- R = 4.294.967.294, Q = 0
		
		wait for CLK_period;
		
		START <= '0';
		
		wait for CLK_period*33;
		
		------------------------------------------- N > D --------------------------------------------------------
		
		START <= '1';
		N_IN <= (2 => '1', others => '0'); -- 4
		D_IN <= (1 => '1', 0 => '1', others => '0'); -- 3
		
		-- R = 1, Q = 1
		
		wait for CLK_period;
		
		START <= '0';
		
		wait for CLK_period*33;

		START <= '1';
		N_IN <= (4 => '1', 3 => '1', 2 => '1', others => '0'); -- 28
		D_IN <= (2 => '1', 0 => '1', others => '0') ; -- 5
		
		-- R = 3, Q = 5
		
		wait for CLK_period;
		
		START <= '0';
		
		wait for CLK_period*33;
		
		START <= '1';
		N_IN <= (others => '1'); -- 4.294.967.295
		D_IN <= (1 => '1', others => '0'); -- 2
		
		-- R = 1, Q = 2147483647  
		  
		wait for CLK_period;
		
		START <= '0';
		
		wait for CLK_period*33;
		
		START <= '1';
		N_IN <= (9 => '1', 8 => '1', 6 => '1', 5 => '1', 3 => '1', 2 => '1', others => '0'); --876
		D_IN <= (6 => '1' ,2 => '1', 1 => '1', 0 => '1', others => '0'); --71
		
		-- R = 24 , Q = 12
		  
		wait for CLK_period;
		
		START <= '0';
		
		wait for CLK_period*33;
		
		------------------------------------------- D = 0 --------------------------------------------------------
		
		START <= '1';
		N_IN <= (others => '1'); -- 4.294.967.295  
		D_IN <= (others => '0'); -- 0
		
		-- error
		
		wait for CLK_period;
		
		START <= '0';
		
		wait for CLK_period*33;
		
		
		START <= '1';
		N_IN <= (others => '0'); -- 0
		D_IN <= (others => '0'); -- 0
		
		-- error
		
		wait for CLK_period;
		
		START <= '0';
		
		wait for CLK_period*33;
		

		------------------------------------------- N = D --------------------------------------------------------
		
		START <= '1';
		N_IN <= (22 => '1', 21 => '1', 19 => '1',18 => '1', 15 => '1', 14 => '1', 13 => '1', 
					10 => '1', 9 => '1', 7 => '1', 6 => '1', 4 => '1', 2 => '1', 1 => '1', others => '0'); --7136982
		D_IN <= (22 => '1', 21 => '1', 19 => '1',18 => '1', 15 => '1', 14 => '1', 13 => '1', 
					10 => '1', 9 => '1', 7 => '1', 6 => '1', 4 => '1', 2 => '1', 1 => '1', others => '0'); --7136982
		
		-- R = 0 , Q = 1
		  
		wait for CLK_period;
		
		START <= '0';
		
		wait for CLK_period*33;
		
		START <= '1';
		D_IN <= (others => '1'); -- 4.294.967.295
		N_IN <= (others => '1'); -- 4.294.967.295
		
		-- R = 0, Q = 1
		
		wait for CLK_period;
		
		START <= '0';

      wait;
   end process;

END;
