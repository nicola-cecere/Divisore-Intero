LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 

ENTITY TB_CLA32 IS
END TB_CLA32;
 
ARCHITECTURE behavior OF TB_CLA32 IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT CLA32
    PORT(
         X : IN  std_logic_vector(31 downto 0);
         Y : IN  std_logic_vector(31 downto 0);
         C_IN : IN  std_logic;
         C_OUT : OUT  std_logic;
         SUM : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal X : std_logic_vector(31 downto 0);
   signal Y : std_logic_vector(31 downto 0);
   signal C_IN : std_logic;

 	--Outputs
   signal C_OUT : std_logic;
   signal SUM : std_logic_vector(31 downto 0);
  
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: CLA32 PORT MAP (
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
		
		X <= (others => '0');
		Y <= (others => '1');
		C_IN <= '0';
		
		wait for 52 ns;
		
		X <= (others => '1');
		Y <= (others => '0');
		C_IN <= '0';
		
		wait for 52 ns;
		
		X <= (others => '1');
		Y <= (others => '1');
		C_IN <= '0';
		
		wait for 52 ns;
		
		X <= (others => '1');
		Y <= (others => '0');
		C_IN <= '1';
		
		wait for 52 ns;
		
		X <= "00000000000000000000000000000111";
		Y <= "00000000000000000000000000000010";
		C_IN <= '1';

      wait;
   end process;

END;
