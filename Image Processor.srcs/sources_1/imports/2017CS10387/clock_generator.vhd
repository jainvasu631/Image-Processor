----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 29.09.2018 16:02:58
-- Design Name: 
-- Module Name: clock_generator - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity clock_generator is
    Port ( reset : in STD_LOGIC;
           clk : in STD_LOGIC;
           txclk : inout STD_LOGIC := '1';
           rxclk : inout STD_LOGIC := '1'
          );
end clock_generator;

architecture Behavioral of clock_generator is
signal count1 : INTEGER := 1;
signal count2 : INTEGER := 1;
begin
PROCESS(reset,clk) BEGIN
    IF(reset = '1') THEN
        txclk<='0';
        rxclk<='0';
    ELSE
    IF rising_edge(clk) THEN
        IF (count1 = 325) THEN
            count1 <= 1;
            rxclk <= NOT rxclk;
        ELSE    
            count1 <= count1 +1;
        END IF;
         IF (count2 = 5208) THEN
             count2 <= 1;
             txclk <= NOT txclk;
         ELSE    
             count2 <= count2 +1;
         END IF;     
    END IF;
END IF;
end process;
end Behavioral;
