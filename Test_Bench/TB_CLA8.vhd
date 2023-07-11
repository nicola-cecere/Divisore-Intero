LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
 
ENTITY TB_CLA8 IS
END TB_CLA8;
 
ARCHITECTURE behavior OF TB_CLA8 IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT CLA8
    PORT(
         X : IN  std_logic_vector(7 downto 0);
         Y : IN  std_logic_vector(7 downto 0);
         C_IN : IN  std_logic;
         C_OUT : OUT  std_logic;
         SUM : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal X : std_logic_vector(7 downto 0);
   signal Y : std_logic_vector(7 downto 0);
   signal C_IN : std_logic;

 	--Outputs
   signal C_OUT : std_logic;
   signal SUM : std_logic_vector(7 downto 0);
   
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: CLA8 PORT MAP (
          X => X,
          Y => Y,
          C_IN => C_IN,
          C_OUT => C_OUT,
          SUM => SUM
        );

  

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;

		-- insert stimulus here 		

      X <= "00000000";
		Y <= "11111111";
		C_IN <= '0';
		
		wait for 21 ns;
		
		X <= "11111111";
		Y <= "00000000";
		C_IN <= '0';
		
		wait for 21 ns;
		
		X <= "11111111";
		Y <= "00000000";
		C_IN <= '1';
		
		wait for 21 ns;
		
		
		X <= "11111111";
		Y <= "11111111";
		C_IN <= '0';
		
		wait for 21 ns;
		
		X <= "00000011"; 
		Y <= "00000110";
		C_IN <= '1';
		
		wait for 21 ns;
		
		X <= "00011111"; 
		Y <= "00000000";
		C_IN <= '0';
		
		wait for 21 ns;
		
		Y <= "00011111";
		
		wait for 21 ns;
		
		X <= "00000001";
		Y <= "00011111";
		
		wait for 21 ns;
		
		X <= "00000000";
		Y <= "00011111";
		
      wait;
   end process;

END;
