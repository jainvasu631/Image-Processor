----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 29.09.2018 15:38:45
-- Design Name: 
-- Module Name: timing_circuit - Behavioral
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
--Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity timing_circuit is
    Port ( reset : in STD_LOGIC;
           rx_empty : in STD_LOGIC;
           tx_empty : in STD_LOGIC;
           clock : in STD_LOGIC;
           uld_rx : inout STD_LOGIC;
           ld_tx : out STD_LOGIC;
           wea : out STD_LOGIC;
           enb: out std_logic;
           addra: out std_logic_vector(8 downto 1); 
           addrb: out std_logic_vector(8 downto 1));
end timing_circuit;

architecture Behavioral of timing_circuit is
SIGNAL Load_State : STD_LOGIC_VECTOR(2 DOWNTO 1) := "11";
signal addrt : std_logic_vector(8 downto 1):= "00000000";
signal temp : std_logic_vector(8 downto 1) := "00000000";
signal isfull : std_logic := '0'; 
begin
    Process(clock,reset) begin
        IF (reset = '1') THEN
            uld_rx<='0';
            ld_tx<='0';
        ELSE
        IF rising_edge(clock) THEN
            IF(tx_empty = '1') THEN
            ld_tx<='1';
            enb <= '1';
            addrb <= temp;
            temp <=  temp+1;
            ELSE
            enb<= '0'; 
            ld_tx <= '0';
            END IF; 
            
            IF (rx_empty='0')THEN
            load_state <="01";
            
            END IF;
            
            if (load_state="01") THEN
            load_state<= "00";
            uld_rx<='1';
            wea <= '1';
            addra <= addrt ;
            addrt <= addrt + 1;
            ELSIF (load_state="00") THEN
            uld_rx<='0';
            END IF;    
        
            if(addrt = "11111111" and isfull = '0') then
                isfull <= '1';
            end if;
            
            if(isfull = '0' and temp = addrt) then
                temp <= "00000000";
            end if;
        END IF;
        END IF;
    end process;
end Behavioral;
