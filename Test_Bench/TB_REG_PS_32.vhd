LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY TB_REG_PS_32 IS
END TB_REG_PS_32;
 
ARCHITECTURE behavior OF TB_REG_PS_32 IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT REG_PS_32
    PORT(
         CLK : IN  std_logic;
         RESET : IN  std_logic;
         EN : IN  std_logic;
         LS : IN  std_logic;
         D32 : IN  std_logic_vector(31 downto 0);
         DSH : IN  std_logic;
         Q32 : OUT  std_logic_vector(31 downto 0)
         --QSH : OUT  std_logic
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
   signal Q32 : std_logic_vector(31 downto 0);
   --signal QSH : std_logic;

   -- Clock period definitions
   constant CLK_period : time := 15 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: REG_PS_32 PORT MAP (
          CLK => CLK,
          RESET => RESET,
          EN => EN,
          LS => LS,
          D32 => D32,
          DSH => DSH,
          Q32 => Q32
          --QSH => QSH
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
		LS <= '1';
		D32 <= "01010100000000000000000000001010";
		
		wait for CLK_period;
		
		LS <= '0';
		DSH <= '0';
		
		wait for CLK_period;
		
		LS <= '0';
		DSH <= '1';
		
		wait for CLK_period;
		
		EN <= '0';
		LS <= '0';
		DSH <= '1';
		
		wait for CLK_period;

		EN <= '1';
		LS <= '1';
		D32 <= (others => '0');
		
		wait for CLK_period;
		
		LS <= '1';
		D32 <= (others => '1');
		
		wait for CLK_period;
		
		LS <= '1';
		D32 <= "01111111111111111111111111111110";
		
		wait for CLK_period;
		
		LS <= '0';
		DSH <= '1';
		
		wait for CLK_period;
		
		EN <= '0';
      wait;
   end process;

END;
