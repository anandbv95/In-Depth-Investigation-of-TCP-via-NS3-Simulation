----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:45:53 10/24/2019 
-- Design Name: 
-- Module Name:    four_bit_cla - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;                             -- Using STD_LOGIC_LIBRARY_1164 package

-- entity declaration
ENTITY four_bit_cla IS
    PORT
        (a      :  IN   STD_LOGIC_VECTOR(3 DOWNTO 0);     -- a is used as input port
         b      :  IN   STD_LOGIC_VECTOR(3 DOWNTO 0);     -- b is used as input port
         carry_in  :  IN   STD_LOGIC;                     -- carry_in is used as input port
         sum       :  OUT  STD_LOGIC_VECTOR(3 DOWNTO 0);  -- sum is used as input port
         carry_out :  OUT  STD_LOGIC                      -- carry_out is used as output port                                                                   
        );
END four_bit_cla ;

ARCHITECTURE behavioral OF four_bit_cla  IS                         -- architecture declaration                    
--Signal declaration
SIGNAL    sum_new            :    STD_LOGIC_VECTOR(3 DOWNTO 0); 
SIGNAL    g                  :    STD_LOGIC_VECTOR(3 DOWNTO 0);
SIGNAL    p                  :    STD_LOGIC_VECTOR(3 DOWNTO 0);
SIGNAL    carry              :    STD_LOGIC_VECTOR(3 DOWNTO 1);

BEGIN
    sum_new <= a XOR b;              -- sum_new signal equation
    g <= a AND b;                    -- generate signal equation 
    p <= a OR b;                     -- propagate signal equation
    PROCESS (g,p,carry)
    BEGIN
    carry(1) <= g(0) OR (p(0) AND carry_in);
        inst: FOR i IN 1 TO 2 LOOP                           -- for loop
              carry(i+1) <= g(i) OR (p(i) AND carry(i));
              END LOOP;
    carry_out <= g(3) OR (p(3) AND carry(3));
    END PROCESS;

    sum(0) <= sum_new(0) XOR carry_in;
    sum(3 DOWNTO 1) <= sum_new(3 DOWNTO 1) XOR carry(3 DOWNTO 1);
END behavioral;