----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 22.10.2018 13:24:40
-- Design Name: 
-- Module Name: memory - Behavioral
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
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity memory is
    Port ( addra : in STD_LOGIC_VECTOR (8 downto 1);
           addrb : in STD_LOGIC_VECTOR (8 downto 1);
           enb : in STD_LOGIC;
           wena : in STD_LOGIC;
           dina : in STD_LOGIC_VECTOR (8 downto 1);
           doutb : out STD_LOGIC_VECTOR (8 downto 1);
           clk : in STD_LOGIC);
end memory;

architecture Behavioral of memory is
type storage is array(0 to 255) of std_logic_vector(8 downto 1);
signal data : storage ;
signal address : std_logic_vector(8 downto 1);
--signal temp : integer;
begin
process(clk, wena)
begin
if(wena = '1' and rising_edge(clk)) then
data(to_integer(unsigned(addra)))<= dina;
end if;
end process;

process(clk, enb)
begin
if(enb = '1' and rising_edge(clk) )then
    address <= addrb;
end if;

if(enb = '1' and rising_edge(clk) )then
    doutb <= data(to_integer(unsigned(address)));
end if;        
    
end process;

end Behavioral;
