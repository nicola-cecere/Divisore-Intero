LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY TB_CNT IS
END TB_CNT;
 
ARCHITECTURE behavior OF TB_CNT IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT CNT
    PORT(
         RESET : IN  std_logic;
         CLK : IN  std_logic;
         EN : IN  std_logic;
         TC : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal RESET : std_logic;
   signal CLK : std_logic;
   signal EN : std_logic;

 	--Outputs
   signal TC : std_logic;

   -- Clock period definitions
   constant CLK_period : time := 14 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: CNT PORT MAP (
          RESET => RESET,
          CLK => CLK,
          EN => EN,
          TC => TC
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
		EN <= '1';

      wait for CLK_period*32;
		
		EN <= '0';
		
		wait for CLk_period;
		
		RESET <= '1';
		
		wait for CLk_period;
		
		RESET <= '0';
		EN <= '1';

      wait for CLK_period*32;
		
		EN <= '0';
			
		
      wait;
   end process;

END;
