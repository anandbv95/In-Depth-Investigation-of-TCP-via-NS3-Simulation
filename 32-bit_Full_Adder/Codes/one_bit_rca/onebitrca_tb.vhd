--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   01:08:10 11/02/2019
-- Design Name:   
-- Module Name:   C:/Users/anand/Desktop/Anand/project1.1/onebitrca_tb.vhd
-- Project Name:  project1.1
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: onebitrca
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
USE ieee.std_logic_1164.ALL; -- Using STD_LOGIC_1164 package
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY onebitrca_tb IS            -- Entity declaration
END onebitrca_tb;
 
ARCHITECTURE behavior OF onebitrca_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT onebitrca                                 -- Component declaration
    PORT(
         a : IN  std_logic;                             -- a is declared as input port
         b : IN  std_logic;                             -- b is declared as input port
         Carryin : IN  std_logic;                       -- Carryin is declared as input port
         Sum : OUT  std_logic;                          -- Sum is declared as output port
         Carryout : OUT  std_logic                      -- Carryput is declared as output port
        );
    END COMPONENT;
    

   --Inputs
   signal a : std_logic := '0';
   signal b : std_logic := '0';
   signal Carryin : std_logic := '0';

 	--Outputs
   signal Sum : std_logic;
   signal Carryout : std_logic;
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
   
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: onebitrca PORT MAP (
          a => a,
          b => b,
          Carryin => Carryin,
          Sum => Sum,
          Carryout => Carryout
        );

  

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      a <= '0'; 
       b <= '0';
       Carryin <= '0';
       wait for 10 ns;

       a <= '0';
       b <= '0';
      Carryin <= '1';
      wait for 10 ns;

      a <= '0';
      b <= '1';
      Carryin <= '0';
      wait for 10 ns;

      a <= '0';
      b <= '1';
      Carryin <= '1';
      wait for 10 ns;

      a <= '1';
      b <= '0';
      Carryin <= '0';
      wait for 10 ns;

      a <= '1';
      b <= '0';
      Carryin <= '1';
      wait for 10 ns;

      a <= '1';
      b <= '1';
      Carryin <= '0';
     wait for 10 ns;

     a <= '1';
     b <= '1';
     Carryin <= '1';
     wait for 10 ns;

     end process;
     END;
