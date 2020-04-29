----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:39:01 10/19/2019 
-- Design Name: 
-- Module Name:    onebitrca - Behavioral 
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
use IEEE.STD_LOGIC_1164.ALL;                         -- Using STD_LOGIC_1164 package

entity onebitrca is
port (a : in STD_LOGIC;                     -- a is used as input port
      b : in STD_LOGIC;                     -- b is used as input port
		Carryin : in STD_LOGIC;               -- Carryin is used as input port
		Sum : out STD_LOGIC;                  -- Sum is used as output port
		Carryout : out STD_LOGIC);            -- Carryout is used as output port
end onebitrca;

architecture Behavioral of onebitrca is
begin
Sum <= a xor b xor Carryin;                                    -- Sum logic Equation
Carryout <= (a and b) or (Carryin and b) or (Carryin and a);   -- Carryout equation
end Behavioral;

