LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY TB_REG_PP_32 IS
END TB_REG_PP_32;
 
ARCHITECTURE behavior OF TB_REG_PP_32 IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT REG_PP_32
    PORT(
         CLK : IN  std_logic;
         RESET : IN  std_logic;
         EN : IN  std_logic;
         D : IN  std_logic_vector(31 downto 0);
         Q : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal CLK : std_logic;
   signal RESET : std_logic;
   signal EN : std_logic;
   signal D : std_logic_vector(31 downto 0);

 	--Outputs
   signal Q : std_logic_vector(31 downto 0);

   -- Clock period definitions
   constant CLK_period : time := 15 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: REG_PP_32 PORT MAP (
          CLK => CLK,
          RESET => RESET,
          EN => EN,
          D => D,
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
		
		RESET <= '0';

      -- insert stimulus here 
		 EN <= '1';
        D <= "00000000000000000000000000000010";

        wait for CLK_period;

        EN <= '0';
        D <= "00000000000000000000000000000111";

        wait for CLK_period;

        EN <= '1';
        D <= "01110000000000000000000000000111";

        wait for CLK_period;

        EN <= '1';
        D <= (others => '0');

        wait for CLK_period;

        EN <= '1';
        D <= (others => '1');

        wait for CLK_period;

        EN <= '1';
        D <= (others => '0');


        wait;
		  
   end process;

END;
