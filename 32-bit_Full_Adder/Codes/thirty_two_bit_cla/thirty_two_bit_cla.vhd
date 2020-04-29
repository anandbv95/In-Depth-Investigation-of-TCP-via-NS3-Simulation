----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    02:37:21 11/02/2019 
-- Design Name: 
-- Module Name:    thirty_two_bit_cla - Behavioral 
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
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;                         -- Use Library IEEE_STD_LOGIC_1164 package

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity thirty_two_bit_cla is                                                   -- entity declaration
PORT
        (a      :  IN   STD_LOGIC_VECTOR(31 DOWNTO 0);              -- a is used as input port
         b      :  IN   STD_LOGIC_VECTOR(31 DOWNTO 0);              -- b is used as input port
         carry_in  :  IN   STD_LOGIC;                               -- carry_in is used as input port
         sum       :  OUT  STD_LOGIC_VECTOR(31 DOWNTO 0);           -- sum is used as output port
         carry_out :  OUT  STD_LOGIC                                -- carry_out is used as output port
        );

end thirty_two_bit_cla;
--architecture declaration
architecture Behavioral of thirty_two_bit_cla is
--signal declaration
SIGNAL    sum_new            :    STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL    g                  :    STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL    p                  :    STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL    carry              :    STD_LOGIC_VECTOR(31 DOWNTO 1);
	

begin
sum_new <= a XOR b;           -- sum_new signal logic equation
    g <= a AND b;             -- generate signal logic equation
    p <= a OR b;              -- propagate signal logic equation
    PROCESS (g,p,carry)
    BEGIN	
    carry(1) <= g(0) OR (p(0) AND carry_in);
        inst: FOR i IN 1 TO 30 LOOP                   -- for loop
              carry(i+1) <= g(i) OR (p(i) AND carry(i));
              END LOOP;
    carry_out <= g(31) OR (p(31) AND carry(31));
    END PROCESS;

    sum(0) <= sum_new(0) XOR carry_in;
    sum(31 DOWNTO 1) <= sum_new(31 DOWNTO 1) XOR carry(31 DOWNTO 1);


end Behavioral;

