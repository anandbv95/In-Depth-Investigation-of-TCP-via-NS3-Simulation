--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   02:40:25 11/02/2019
-- Design Name:   
-- Module Name:   C:/Users/anand/Desktop/Anand/project1.1/thirty_two_bit_cla_tb.vhd
-- Project Name:  project1.1
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: thirty_two_bit_cla
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
USE ieee.std_logic_1164.ALL;                          -- Use Library IEEE_STD_LOGIC_1164 package
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
-- entity declaration
ENTITY thirty_two_bit_cla_tb IS
END thirty_two_bit_cla_tb;
 
ARCHITECTURE behavior OF thirty_two_bit_cla_tb IS                      --architecture declaration
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT thirty_two_bit_cla
    PORT(
         a : IN  std_logic_vector(31 downto 0);                   -- a is used as input port
         b : IN  std_logic_vector(31 downto 0);                   -- b is used as input port
         carry_in : IN  std_logic;                                -- carry_in is used as input port
         sum : OUT  std_logic_vector(31 downto 0);                -- sum is used as output port
         carry_out : OUT  std_logic                               -- carry_out is used as output port
        );
    END COMPONENT;
    

   --Inputs
   signal a : std_logic_vector(31 downto 0) := (others => '0');
   signal b : std_logic_vector(31 downto 0) := (others => '0');
   signal carry_in : std_logic := '0';

 	--Outputs
   signal sum : std_logic_vector(31 downto 0);
   signal carry_out : std_logic;
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
   BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: thirty_two_bit_cla PORT MAP (
          a => a,
          b => b,
          carry_in => carry_in,
          sum => sum,
          carry_out => carry_out
        );

 

   -- Stimulus process
   stim_proc: process
   begin		
      
carry_in <= '0'; 
   a <= "00000000000000000000000000000000";
	wait for 10 ns;	
	b <= "00000000000000000000000000000000";
	wait for 10 ns;
	carry_in <= '1';	
	wait for 10 ns;
	a <= "00000000000000000000000000000010";
	wait for 10 ns;
	b <= "00000000000000000000000000001000";
	wait for 10 ns;
	a <= "11000000000000000000000000000010";
	wait for 10 ns;
	b <= "11000000000000000000000000001000";
	wait for 10 ns;
	A <= x"0AF70000";
	wait for 10 ns;
	B <= x"23640000";
	wait for 10 ns;

	
   end process;
END;

