--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   20:51:37 10/19/2019
-- Design Name:   
-- Module Name:   C:/Users/anand/Desktop/Anand/project1.1/fourbitrca_tb.vhd
-- Project Name:  project1.1
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: fourbitrca
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;                         -- Using STD_LOGIC_LIBRARY_1164 package
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY fourbitrca_tb IS                             -- fourbit rca Entity declaration
END fourbitrca_tb;
 
ARCHITECTURE behavior OF fourbitrca_tb IS           -- architecture declaration
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT fourbitrca
    PORT(
         A : IN  std_logic_vector(3 downto 0);              -- A is used as input port
         B : IN  std_logic_vector(3 downto 0);              -- B is used as input port
         Cin : IN  std_logic;                               -- Cin is used as input port
         S : OUT  std_logic_vector(3 downto 0);             -- S is used as output port
         Carryout : OUT  std_logic                          -- Carryout is used as output port
        );
    END COMPONENT;
    

   --Inputs
   signal A : std_logic_vector(3 downto 0) := (others => '0');
   signal B : std_logic_vector(3 downto 0) := (others => '0');
   signal Cin : std_logic := '0';

 	--Outputs
   signal S : std_logic_vector(3 downto 0);
   signal Carryout : std_logic;
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 

 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: fourbitrca PORT MAP (
          A => A,
          B => B,
          Cin => Cin,
          S => S,
          Carryout => Carryout
        ); 

   -- Stimulus process
   stim_proc_A: process
   begin		
      A<="1000";
      wait for 100 ns;	
		A<="0001";
		wait;
	end process;
	
	stim_proc_B: process
	begin
	   B<="1110";
		wait for 100 ns;
		B<="0010";
		wait;
	end process;
		
	stim_proc_Cin: process
	begin
	Cin<='0';
	wait for 100 ns;
	Cin<='1';
	wait;
	
   end process;

END;
