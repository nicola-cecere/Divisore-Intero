LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
 
ENTITY TB_REMINDER IS
END TB_REMINDER;
 
ARCHITECTURE behavior OF TB_REMINDER IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT REMINDER
    PORT(
         CLK : IN  std_logic;
         RESET : IN  std_logic;
         EN : IN  std_logic;
         LS : IN  std_logic;
         D32 : IN  std_logic_vector(31 downto 0);
         DSH : IN  std_logic;
         Q32N : OUT  std_logic_vector(31 downto 0);
         --QSHN : OUT  std_logic;
         Q32R : OUT  std_logic_vector(31 downto 0)
         --QSHR : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal CLK : std_logic;
   signal RESET : std_logic;
   signal EN : std_logic;
   signal LS : std_logic;
   signal D32 : std_logic_vector(31 downto 0);
   signal DSH : std_logic;

 	--Outputs
   signal Q32N : std_logic_vector(31 downto 0);
   --signal QSHN : std_logic;
   signal Q32R : std_logic_vector(31 downto 0);
   --signal QSHR : std_logic;

   -- Clock period definitions
   constant CLK_period : time := 17 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: REMINDER PORT MAP (
          CLK => CLK,
          RESET => RESET,
          EN => EN,
          LS => LS,
          D32 => D32,
          DSH => DSH,
          Q32N => Q32N,
         -- QSHN => QSHN,
          Q32R => Q32R
         -- QSHR => QSHR
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
	
		RESET <= '1';
      -- hold reset state for 100 ns.
      wait for 100 ns;
		
		-- insert stimulus here 
		RESET <= '0';
		
		LS <= '1';
		EN <= '1';
		D32 <= "10101010101010101011100000000000";
		DSH <= '1';

      wait for CLK_period;
		
		LS <= '0';
		
		wait for CLK_period;
		
		DSH <= '0';
		
		wait for CLK_period;

      DSH <= '1';

      wait;
   end process;

END;
