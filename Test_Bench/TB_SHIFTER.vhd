LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
  
ENTITY TB_SHIFTER IS
END TB_SHIFTER;
 
ARCHITECTURE behavior OF TB_SHIFTER IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT SHIFTER
    PORT(
         D32 : IN  std_logic_vector(31 downto 0);
         DSH : IN  std_logic;
         EN : IN  std_logic;
         Q : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal D32 : std_logic_vector(31 downto 0);
   signal DSH : std_logic;
   signal EN : std_logic;

 	--Outputs
   signal Q : std_logic_vector(31 downto 0); 

 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: SHIFTER PORT MAP (
          D32 => D32,
          DSH => DSH,
          EN => EN,
          Q => Q
        );
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      -- insert stimulus here 
		
		D32 <= (others => '1');
		DSH <= '0';
		EN <= '1';

      wait for 12 ns;
		
		D32 <= (others => '0');
		DSH <= '1';
		EN <= '0';

      wait for 12 ns;
		
		D32 <= (others => '0');
		DSH <= '1';
		EN <= '1';

      wait for 12 ns;
		
		D32 <= (others => '1');
		DSH <= '0';
		EN <= '0';

      wait for 12 ns;

      wait;
   end process;

END;
