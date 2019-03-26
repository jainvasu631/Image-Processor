----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05.11.2018 16:42:57
-- Design Name: 
-- Module Name: filter - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
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
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity filter is
  Port (
  mode:in std_logic;
  a00:in std_logic_vector(7 downto 0); 
  a01:in std_logic_vector(7 downto 0);
  a02:in std_logic_vector(7 downto 0);
  a10:in std_logic_vector(7 downto 0);
  a11:in std_logic_vector(7 downto 0); 
  a12:in std_logic_vector(7 downto 0);
  a20:in std_logic_vector(7 downto 0);
  a21:in std_logic_vector(7 downto 0);
  a22:in std_logic_vector(7 downto 0);  
  output: out std_logic_vector(7 downto 0)
    );
end filter;

architecture Behavioral of filter is
signal smooth00:integer := 8;
signal smooth01:integer := 16;
signal smooth02:integer := 8;
signal smooth10:integer := 16;
signal smooth11:integer := 32;
signal smooth12:integer := 16;
signal smooth20:integer := 8;
signal smooth21:integer := 16;
signal smooth22:integer := 8;
signal sharp00:integer := -16;
signal sharp01:integer := -16;
signal sharp02:integer := -16;
signal sharp10:integer := -16;
signal sharp11:integer := 240;
signal sharp12:integer := -16;
signal sharp20:integer := -16;
signal sharp21:integer := -16;
signal sharp22:integer := -16;
signal output_18 : integer:=0;
signal output_18bit: std_logic_vector(18 DOWNTO 1);
begin
process(mode,a00,a01,a11,a20,a21,a22,a10,a12,a02)
begin
if(mode='0') Then
--Smooth image
output_18 <= smooth00*to_integer(unsigned(a00))+smooth01*to_integer(unsigned(a01))+smooth02*to_integer(unsigned(a02))+smooth10*to_integer(unsigned(a10))+smooth11*to_integer(unsigned(a11))+smooth12*to_integer(unsigned(a12))+smooth20*to_integer(unsigned(a20))+smooth21*to_integer(unsigned(a21))+smooth22*to_integer(unsigned(a22));
else 
output_18 <= sharp00*to_integer(unsigned(a00))+sharp01*to_integer(unsigned(a01))+sharp02*to_integer(unsigned(a02))+sharp10*to_integer(unsigned(a10))+sharp11*to_integer(unsigned(a11))+sharp12*to_integer(unsigned(a12))+sharp20*to_integer(unsigned(a20))+sharp21*to_integer(unsigned(a21))+sharp22*to_integer(unsigned(a22));
end if;
output_18bit <= std_logic_vector(to_unsigned(output_18,18));
output <= output_18bit(14 DOWNTO 7);
end process;
end Behavioral;
