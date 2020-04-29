--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   01:44:29 11/02/2019
-- Design Name:   
-- Module Name:   C:/Users/anand/Desktop/Anand/project1.1/four_bit_cla_tb.vhd
-- Project Name:  project1.1
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: four_bit_cla
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
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY four_bit_cla_tb IS
END four_bit_cla_tb;
 
ARCHITECTURE behavior OF four_bit_cla_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT four_bit_cla
    PORT(
         a : IN  std_logic_vector(3 downto 0);
         b : IN  std_logic_vector(3 downto 0);
         carry_in : IN  std_logic;
         sum : OUT  std_logic_vector(3 downto 0);
         carry_out : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal a : std_logic_vector(3 downto 0) := (others => '0');
   signal b : std_logic_vector(3 downto 0) := (others => '0');
   signal carry_in : std_logic := '0';

 	--Outputs
   signal sum : std_logic_vector(3 downto 0);
   signal carry_out : std_logic;
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: four_bit_cla PORT MAP (
          a => a,
          b => b,
          carry_in => carry_in,
          sum => sum,
          carry_out => carry_out
        );

  

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
     carry_in <= '0'; 
   a <= "0001";
	wait for 10 ns;	
	b <= "0001";
	wait for 10 ns;
	carry_in <= '1';	
	wait for 10 ns;
	a <= "1000";
	wait for 10 ns;
	b <= "1000";
	wait for 10 ns;
	a <= "0101";
	wait for 10 ns;
	b <= "0101";

		


      -- insert stimulus here 

      wait;
   end process;

END;
