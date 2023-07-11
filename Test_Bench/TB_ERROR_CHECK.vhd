LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

 
ENTITY TB_ERROR_CHECK IS
END TB_ERROR_CHECK;
 
ARCHITECTURE behavior OF TB_ERROR_CHECK IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT ERROR_CHECK
    PORT(
         D : IN  std_logic_vector(31 downto 0);
         Q : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal D : std_logic_vector(31 downto 0);

 	--Outputs
   signal Q : std_logic;
 
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: ERROR_CHECK PORT MAP (
          D => D,
          Q => Q
        );

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

     -- insert stimulus here 
	  
	  D <= "00000010010000000110000000001001";
	  
	  wait for 12 ns;
	  
	  D <= (others => '0');
	  
	  wait for 12 ns;
	  
	  D <= "00000000000000000000000000000001";

     wait;
   end process;

END;
