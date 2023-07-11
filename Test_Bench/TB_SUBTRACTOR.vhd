LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
  
ENTITY TB_SUBTRACTOR IS
END TB_SUBTRACTOR;
 
ARCHITECTURE behavior OF TB_SUBTRACTOR IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT SUBTRACTOR
    PORT(
         SUBTRAHEND : IN  std_logic_vector(31 downto 0);
         MINUEND : IN  std_logic_vector(31 downto 0);
         DIFFERENCE : OUT  std_logic_vector(31 downto 0);
         C_OUT : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal SUBTRAHEND : std_logic_vector(31 downto 0);
   signal MINUEND : std_logic_vector(31 downto 0);

 	--Outputs
   signal DIFFERENCE : std_logic_vector(31 downto 0);
   signal C_OUT : std_logic;
 
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: SUBTRACTOR PORT MAP (
          SUBTRAHEND => SUBTRAHEND,
          MINUEND => MINUEND,
          DIFFERENCE => DIFFERENCE,
          C_OUT => C_OUT
        );

 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      -- insert stimulus here 
		
		SUBTRAHEND <= "00000000000000000000000000000111";
		MINUEND <=    "00000000000000000000000000000010";
		
      wait for 58 ns;
		
		SUBTRAHEND <= "00000000000000000000000000000010";
		MINUEND <=    "00000000000000000000000000000111"; 
		
		wait for 58 ns;
		
		SUBTRAHEND <= "00000000000000000000000000000111";
		MINUEND <=    "00000000000000000000000000000111";
		
      wait for 58 ns;
		
		SUBTRAHEND <= (others => '1');
		MINUEND <=    (others => '1');
		
		wait for 58 ns;
		
		SUBTRAHEND <= (others => '0');
		MINUEND <=    (others => '0');
		
		wait for 58 ns;
		
		SUBTRAHEND <= "00000000010000000000000000000111";
		MINUEND <=    "00000000010000000000000000000110";


      wait;
   end process;

END;
