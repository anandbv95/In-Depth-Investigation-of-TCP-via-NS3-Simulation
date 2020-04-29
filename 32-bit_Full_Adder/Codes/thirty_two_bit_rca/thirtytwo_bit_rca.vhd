----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    22:39:43 10/21/2019 
-- Design Name: 
-- Module Name:    thirtytwo_bit_rca - Structural 
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
USE ieee.std_logic_arith.ALL;                    -- Using STD_LOGIC_LIBRARY_arith package

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity thirtytwo_bit_rca is                       -- Entity declaration
port(	
		A:IN STD_LOGIC_VECTOR(31 downto 0);         -- Declaring A as 32 bit input port
		B:IN STD_LOGIC_VECTOR(31 downto 0);         -- Declaring B as 32 bit input port
		Cin:IN STD_LOGIC;                           -- Declaring Cin as input port
		S:OUT STD_LOGIC_VECTOR(31 downto 0);        -- Declaring S as 32 bit output port
		Carryout:OUT std_logic
		);
end thirtytwo_bit_rca;

architecture Structural of thirtytwo_bit_rca is
--Component Declaration
component fa is 
port(	
      a,b,c:in std_logic;                         -- a,b and c is used as input port
		Cout:out std_logic;                         -- Cout is used as output port
		s:out std_logic                             -- s is used as output port
		);
end component;
signal carry : STD_LOGIC_VECTOR (30 downto 0);
begin
-- port mapping
fa0:fa port map(a=>A(0), b=>B(0), c=>Cin, Cout=>carry(0), s=>S(0));
fa1:fa port map(a=>A(1), b=>B(1), c=>carry(0), Cout=>carry(1), s=>S(1));
fa2:fa port map(a=>A(2), b=>B(2), c=>carry(1), Cout=>carry(2), s=>S(2));
fa3:fa port map(a=>A(3), b=>B(3), c=>carry(2), Cout=>Carry(3), s=>S(3));
fa4:fa port map(a=>A(4), b=>B(4), c=>carry(3), Cout=>Carry(4), s=>S(4));
fa5:fa port map(a=>A(5), b=>B(5), c=>carry(4), Cout=>Carry(5), s=>S(5));
fa6:fa port map(a=>A(6), b=>B(6), c=>carry(5), Cout=>Carry(6), s=>S(6));
fa7:fa port map(a=>A(7), b=>B(7), c=>carry(6), Cout=>Carry(7), s=>S(7));
fa8:fa port map(a=>A(8), b=>B(8), c=>carry(7), Cout=>Carry(8), s=>S(8));
fa9:fa port map(a=>A(9), b=>B(9), c=>carry(8), Cout=>Carry(9), s=>S(9));
fa10:fa port map(a=>A(10), b=>B(10), c=>carry(9), Cout=>Carry(10), s=>S(10));
fa11:fa port map(a=>A(11), b=>B(11), c=>carry(10), Cout=>Carry(11), s=>S(11));
fa12:fa port map(a=>A(12), b=>B(12), c=>carry(11), Cout=>Carry(12), s=>S(12));
fa13:fa port map(a=>A(13), b=>B(13), c=>carry(12), Cout=>Carry(13), s=>S(13));
fa14:fa port map(a=>A(14), b=>B(14), c=>carry(13), Cout=>Carry(14), s=>S(14));
fa15:fa port map(a=>A(15), b=>B(15), c=>carry(14), Cout=>Carry(15), s=>S(15));
fa16:fa port map(a=>A(16), b=>B(16), c=>carry(15), Cout=>Carry(16), s=>S(16));
fa17:fa port map(a=>A(17), b=>B(17), c=>carry(16), Cout=>Carry(17), s=>S(17));
fa18:fa port map(a=>A(18), b=>B(18), c=>carry(17), Cout=>Carry(18), s=>S(18));
fa19:fa port map(a=>A(19), b=>B(19), c=>carry(18), Cout=>Carry(19), s=>S(19));
fa20:fa port map(a=>A(20), b=>B(20), c=>carry(19), Cout=>Carry(20), s=>S(20));
fa21:fa port map(a=>A(21), b=>B(21), c=>carry(20), Cout=>Carry(21), s=>S(21));
fa22:fa port map(a=>A(22), b=>B(22), c=>carry(21), Cout=>Carry(22), s=>S(22));
fa23:fa port map(a=>A(23), b=>B(23), c=>carry(22), Cout=>Carry(23), s=>S(23));
fa24:fa port map(a=>A(24), b=>B(24), c=>carry(23), Cout=>Carry(24), s=>S(24));
fa25:fa port map(a=>A(25), b=>B(25), c=>carry(24), Cout=>Carry(25), s=>S(25));
fa26:fa port map(a=>A(26), b=>B(26), c=>carry(25), Cout=>Carry(26), s=>S(26));
fa27:fa port map(a=>A(27), b=>B(27), c=>carry(26), Cout=>Carry(27), s=>S(27));
fa28:fa port map(a=>A(28), b=>B(28), c=>carry(27), Cout=>Carry(28), s=>S(28));
fa29:fa port map(a=>A(29), b=>B(29), c=>carry(28), Cout=>Carry(29), s=>S(29));
fa30:fa port map(a=>A(30), b=>B(30), c=>carry(29), Cout=>Carry(30), s=>S(30));
fa31:fa port map(a=>A(31), b=>B(31), c=>carry(30), Cout=>Carryout, s=>S(31));
end Structural;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;                 -- Using STD_LOGIC_LIBRARY_1164 package
-- Entity declaration	
entity fa is 
port(
     a,b,c:in std_logic;                    -- a,b and c are used as inputs
	  Cout:out std_logic;                    --  Cout used as output
	  s:out std_logic                        --  s used as output
	  );
end fa;

architecture fa_architecture of fa is             -- architecture declaration
begin
s<=a xor b xor c;                                  -- Sum output equation
Cout<=(a and b) or (c and a) or (c and b);         -- Cout output equation
end fa_architecture;


