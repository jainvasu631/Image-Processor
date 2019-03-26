----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 24.09.2018 14:43:08
-- Design Name: 
-- Module Name: transmitter - Behavioral
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

-- Company: 
-- Engineer: 
-- 
-- Create Date: 24.09.2018 13:41:53
-- Design Name: 
-- Module Name: Transmitter - Transmit
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
--library UNISIM;
--use UNISIM.VComponents.all;

entity Transmitter is
    Port ( tx_en : in STD_LOGIC;
           ld_tx : in STD_LOGIC;
           reset : in STD_LOGIC;
           txclk : in STD_LOGIC;
           tx_data : in STD_LOGIC_VECTOR (8 downto 1);
           tx_out : out STD_LOGIC;
           tx_empty : inout STD_LOGIC);
end Transmitter;

architecture Transmit of Transmitter is
SIGNAL tx_register : STD_LOGIC_VECTOR(8 DOWNTO 1):="00000000";
CONSTANT start_bit : STD_LOGIC := '0';
CONSTANT stop_bit : STD_LOGIC := '1';
SIGNAL state : STD_LOGIC_VECTOR(3 DOWNTO 0):= "0000";
begin
PROCESS(reset,txclk) begin

IF(reset = '1') THEN
tx_out<='1';
tx_empty <= '1';
tx_register <= "00000000";
state <= "1001";
ELSE
   if rising_edge(txclk) then
    IF(ld_tx='1' and state = "1001") THEN
    tx_register <= tx_data;
    tx_empty <='0';
    END IF;
    
    IF(tx_en = '1') THEN
        IF(state < 8 ) THEN
            tx_out <= tx_register(8 - to_integer(unsigned(state)));
            state <= state + 1;
        ELSIF (state = "1000") THEN
            tx_out <= stop_bit;
            state <= "1001";
            tx_empty <= '1';
        ELSIF(state = "1001") THEN
            IF (tx_empty='0') THEN
                state <= "0000";
                tx_out<=start_bit;
            END IF;
        END IF;
    end if;
   END IF;
END IF;    
end process;
end Transmit;