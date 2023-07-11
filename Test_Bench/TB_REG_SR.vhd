LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY TB_REG_SR IS
END TB_REG_SR;
 
ARCHITECTURE behavior OF TB_REG_SR IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT REG_SR
    PORT(
         CLK : IN  std_logic;
         RESET : IN  std_logic;
         S : IN  std_logic;
         R : IN  std_logic;
         Q : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal CLK : std_logic;
   signal RESET : std_logic;
   signal S : std_logic;
   signal R : std_logic;

 	--Outputs
   signal Q : std_logic;

   -- Clock period definitions
   constant CLK_period : time := 11 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: REG_SR PORT MAP (
          CLK => CLK,
          RESET => RESET,
          S => S,
          R => R,
          Q => Q
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
		
		-- insert stimulus here 
		
		RESET <= '0';
		S <= '1';
		R <= '0';

      wait for CLK_period;
		
		S <= '0';
		
		wait for CLK_period;
		
		R <= '1';

		wait for CLK_period;

      R <= '0';
		
		wait for CLK_period;
		
		S <= '1';
		
		wait for CLK_period;
		
		S <= '0';

      wait;
   end process;

END;
