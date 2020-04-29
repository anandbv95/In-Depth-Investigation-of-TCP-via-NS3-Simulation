----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:08:32 10/19/2019 
-- Design Name: 
-- Module Name:    fourbitrca - Structural 
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
use IEEE.STD_LOGIC_1164.ALL;                     -- Using STD_LOGIC_LIBRARY_1164 package

entity fourbitrca is
port(
		A:IN STD_LOGIC_VECTOR(3 downto 0);         -- Declaring A as four bit input port
		B:IN STD_LOGIC_VECTOR(3 downto 0);         -- Declaring B as four bit input port
		Cin:IN STD_LOGIC;                          -- Declaring Cin as four bit input port
		S:out STD_LOGIC_VECTOR(3 downto 0);        -- Declaring S as four bit output port
		Carryout:out std_logic                     -- Declaring Carryout as output port
		);
end fourbitrca;

architecture Structural of fourbitrca is          -- architecture declaration
component fa is                                   --Component declaration
port(
      a,b,c:in std_logic;                          -- Declaring a, b and c as inputs                       
		Cout:out std_logic;                          --  Declaring Cout as output  
		s:out std_logic                              --  Declaring s as output
		);
end component;

signal carry : STD_LOGIC_VECTOR (3 downto 0);

begin
-- port mapping
fa0:fa port map(a=>A(0), b=>B(0), c=>Cin, Cout=>carry(0), s=>S(0));
fa1:fa port map(a=>A(1), b=>B(1), c=>carry(0), Cout=>carry(1), s=>S(1));
fa2:fa port map(a=>A(2), b=>B(2), c=>carry(1), Cout=>carry(2), s=>S(2));
fa3:fa port map(a=>A(3), b=>B(3), c=>carry(2), Cout=>Carryout, s=>S(3));
end Structural;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;             -- Using STD_LOGIC_LIBRARY_1164 package

entity fa is 
port(
     a,b,c:in std_logic;                  --  Declaring a, b and c as inputs
	  Cout:out std_logic;                  --  Declaring Cout as output  
	  s:out std_logic                      --  Declaring s as output
	  );
end fa;

architecture fa_architecture of fa is        -- architecture declaration
begin
s<=a xor b xor c;                           -- Sum result expression
Cout<=(a and b) or (c and a) or (c and b);  -- Cout expression
end fa_architecture;                       

