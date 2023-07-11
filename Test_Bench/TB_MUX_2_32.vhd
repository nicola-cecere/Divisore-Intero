LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
 
ENTITY TB_MUX_2_32 IS
END TB_MUX_2_32;
 
ARCHITECTURE behavior OF TB_MUX_2_32 IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT MUX_2_32
    PORT(
         SEL : IN  std_logic;
         X : IN  std_logic_vector(31 downto 0);
         Y : IN  std_logic_vector(31 downto 0);
         Z : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal SEL : std_logic := '0';
   signal X : std_logic_vector(31 downto 0) := (others => '0');
   signal Y : std_logic_vector(31 downto 0) := (others => '0');

 	--Outputs
   signal Z : std_logic_vector(31 downto 0);
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: MUX_2_32 PORT MAP (
          SEL => SEL,
          X => X,
          Y => Y,
          Z => Z
        );
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;

      -- insert stimulus here 
			
		SEL <= '1';
		X <= (others => '1');
		Y <= (others => '0');

      wait for 12 ns;

		
		SEL <= '0';
		X <= (others => '1');
		Y <= (others => '0');
		
		
      wait;
   end process;

END;
