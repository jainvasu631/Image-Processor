----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 24.09.2018 16:19:37
-- Design Name: 
-- Module Name: receiver - Behavioral
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
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
library UNISIM;
use UNISIM.VComponents.all;

entity Receiver is
 Port ( rx_en : in STD_LOGIC;
        uld_rx : in STD_LOGIC;
        reset : in STD_LOGIC;
        rxclk : in STD_LOGIC;
        rx_in : in STD_LOGIC;
        rx_data :out STD_LOGIC_VECTOR (8 downto 1);
        rx_empty :out STD_LOGIC);
end Receiver;

architecture receive of Receiver is
SIGNAL rx_register: STD_LOGIC_VECTOR( 8 DOWNTO 1):="00000000";
SIGNAL state: STD_LOGIC_VECTOR(4 DOWNTO 1):="1010";
SIGNAL count: INTEGER :=1;
SIGNAL mini_register : STD_LOGIC_VECTOR( 8 DOWNTO 1):="11111111";
--SIGNAL empty : STD_LOGIC;
BEGIN
PROCESS(reset,rxclk) BEGIN
--rx_empty <= empty;
IF(reset = '1') THEN
    rx_data <="00000000";
    rx_empty <= '1';
ELSE
    IF rising_edge(rxclk)THEN
    IF(uld_rx='1' and state = "1010") THEN
        rx_data <= rx_register;
        rx_empty <='1';
    END IF;
    
    IF(count = 16) THEN
        count <= 1;
       ELSE
        count <= count+1;
     END IF;
     
     IF(rx_en = '1') THEN
        IF(state = "1010" and rx_in='0') THEN
            state <= "0000";
            count<=0;
            mini_register<= "11111111";
        ELSIF (state = "0000") THEN
            mini_register(8 downto 2) <= mini_register(7 downto 1);
            mini_register(1)<= rx_in;
            IF(mini_register ="00000000") THEN
                state <= "0001";
            ELSIF (rx_in='1') THEN 
                state<="1010";
            END IF;
        ELSIF(state < 9 and count = 8) THEN
            rx_register(8 - to_integer(unsigned(state)))<= rx_in;
            state <= state +1 ;
        ELSIF(state = "1001"and count = 8)THEN
            IF(rx_in = '0') THEN
                rx_empty <= '1';
                rx_register <="00000000";
            ELSE 
                rx_empty <= '0';
            END IF;
            state<="1010"; 
        END IF;
     END IF;
END IF;   
END IF;
END PROCESS;
end receive;
