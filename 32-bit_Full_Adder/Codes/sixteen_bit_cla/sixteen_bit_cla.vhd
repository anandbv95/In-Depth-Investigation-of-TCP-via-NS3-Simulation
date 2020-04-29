----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    01:52:15 11/02/2019 
-- Design Name: 
-- Module Name:    sixteen_bit_cla - Behavioral 
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
USE ieee.std_logic_1164.ALL;                                        -- Using STD_LOGIC_LIBRARY_1164 package
ENTITY sixteen_bit_cla IS                                             -- entity declaration
    PORT
        ( a      :  IN   STD_LOGIC_VECTOR(15 DOWNTO 0);               -- a is used as input port
         b      :  IN   STD_LOGIC_VECTOR(15 DOWNTO 0);                -- b is used as input port
         carry_in  :  IN   STD_LOGIC;                                 -- carry_in is used as input port
         sum       :  OUT  STD_LOGIC_VECTOR(15 DOWNTO 0);             -- sum is used as output port
         carry_out :  OUT  STD_LOGIC                                  -- carry_out is used as input port
        );
END sixteen_bit_cla ;
--Architecture declaration
ARCHITECTURE behavioral OF sixteen_bit_cla  IS
--Signal declaration
SIGNAL    sum_new   :    STD_LOGIC_VECTOR(15 DOWNTO 0);
SIGNAL    g                  :    STD_LOGIC_VECTOR(15 DOWNTO 0);
SIGNAL    p                  :    STD_LOGIC_VECTOR(15 DOWNTO 0);
SIGNAL    carry            :    STD_LOGIC_VECTOR(15 DOWNTO 1);

BEGIN
    sum_new <= a XOR b;                          -- sum_new signal logic equation 
    g <= a AND b;                                -- generate signal logic equation
    p <= a OR b;                                 -- propagate signal logic equation
    PROCESS (g,p,carry)
    BEGIN
    carry(1) <= g(0) OR (p(0) AND carry_in);
        inst: FOR i IN 1 TO 14 LOOP                         -- for loop
              carry(i+1) <= g(i) OR (p(i) AND carry(i));
              END LOOP;
    carry_out <= g(15) OR (p(15) AND carry(15));
    END PROCESS;

    sum(0) <= sum_new(0) XOR carry_in;
    sum(15 DOWNTO 1) <= sum_new(15 DOWNTO 1) XOR carry(15 DOWNTO 1);
    END behavioral;

