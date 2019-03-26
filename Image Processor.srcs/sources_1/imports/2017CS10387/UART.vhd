----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 29.09.2018 16:44:56
-- Design Name: 
-- Module Name: UART - Behavioral
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

entity UART is
    Port ( reset : in STD_LOGIC;
           clk : in STD_LOGIC;
           rx_in : in STD_LOGIC;
           tx_out : out STD_LOGIC;
           LED : out STD_LOGIC_VECTOR (8 downto 1);
           tx_en : in STD_LOGIC;
           rx_en : in STD_LOGIC);
end UART;

architecture Behavioral of UART is
SIGNAL  txclk, rxclk, ld_tx, uld_rx, rx_empty , tx_empty : STD_LOGIC;
SIGNAL tx_data, rx_data: STD_LOGIC_VECTOR (8 DOWNTO 1);
begin
CG: entity work.clock_generator(behavioral)
    port map (clk=>clk,
               reset=>reset, 
               txclk =>txclk, 
               rxclk =>rxclk);
TC: entity work.timing_circuit(behavioral)
                   port map (reset => reset,
           rx_empty => rx_empty,
           tx_empty => tx_empty,
           clock => clk,
           uld_rx =>uld_rx,
           ld_tx => ld_tx);
TX: entity work.transmitter(transmit)
      port map (
           tx_en =>tx_en,
           ld_tx =>ld_tx,
           reset =>reset,
           txclk =>txclk, 
           tx_data => tx_data,
           tx_out =>tx_out,
           tx_empty =>tx_empty);
RX: entity work.receiver(receive)
         port map (rx_en =>rx_en,
           uld_rx =>uld_rx,
           reset =>reset,
           rxclk =>rxclk, 
           rx_data => rx_data,
           rx_in =>rx_in,
           rx_empty =>rx_empty);
  tx_data<= rx_data;
  led<=rx_Data;


end Behavioral;
