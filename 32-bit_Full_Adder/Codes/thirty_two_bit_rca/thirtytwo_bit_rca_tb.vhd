--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   14:31:11 10/22/2019
-- Design Name:   
-- Module Name:   C:/Users/anand/Desktop/Anand/project1.1/thirtytwo_bit_rca_tb.vhd
-- Project Name:  project1.1
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: thirtytwo_bit_rca
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
USE ieee.std_logic_1164.ALL;                  -- Using STD_LOGIC_LIBRARY_1164 package
USE ieee.std_logic_arith.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
-- Entity declaration
ENTITY thirtytwo_bit_rca_tb IS
END thirtytwo_bit_rca_tb;
 
ARCHITECTURE behavior OF thirtytwo_bit_rca_tb IS         -- architecture declaration
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT thirtytwo_bit_rca
    PORT(
         A : IN  std_logic_vector(31 downto 0);           -- A is used as input port
         B : IN  std_logic_vector(31 downto 0);           -- B is used as input port
         Cin : IN  std_logic;                             -- Cin is used as input port
         S : OUT  std_logic_vector(31 downto 0);          -- S is used as output port
         Carryout : OUT  std_logic                        -- Carryout is used as input port
        );
    END COMPONENT;
    

   --Inputs
   signal A : std_logic_vector(31 downto 0) := (others => '0');
   signal B : std_logic_vector(31 downto 0) := (others => '0');
   signal Cin : std_logic := '0';

 	--Outputs
   signal S : std_logic_vector(31 downto 0);
   signal Carryout : std_logic;
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: thirtytwo_bit_rca PORT MAP (
          A => A,
          B => B,
          Cin => Cin,
          S => S,
          Carryout => Carryout
        );
stim_proc: process
   begin	
	Cin <= '1';
	wait for 10 ns;
	A <= "00000000000000000000000000000000";
	wait for 10 ns;	
	B <= "00000000000000000000000000000000";
	wait for 10 ns;
	Cin <= '0';
	wait for 10 ns;
	A <= "00000000000000000000000000000010";
	wait for 10 ns;
	B <= "00000000000000000000000000001000";
	wait for 10 ns;
	A <= "11000000000000000000000000000010";
	wait for 10 ns;
	B <= "11000000000000000000000000001000";
	wait for 10 ns;
	A <= x"0AF70000";
	wait for 10 ns;
	B <= x"23640000";
	wait for 10 ns;
   end process;
	END;
