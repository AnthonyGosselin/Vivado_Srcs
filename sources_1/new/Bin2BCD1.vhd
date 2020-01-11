----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/11/2020 02:04:52 PM
-- Design Name: 
-- Module Name: Bin2BCD1 - Behavioral
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

entity Bin2BCD1 is
    Port ( ADCBin : in STD_LOGIC_VECTOR (3 downto 0);
           Diz : out STD_LOGIC_VECTOR (3 downto 0);
           Unites : out STD_LOGIC_VECTOR (3 downto 0));
end Bin2BCD1;

architecture Behavioral of Bin2BCD1 is

begin

ADC_to_BCD: process (ADCBin)
begin

    case ADCBin is
        when "0000" => Diz <= "0000";   Unites <= "0000";
        when "0001" => Diz <= "0000";   Unites <= "0001";
        when "0010" => Diz <= "0000";   Unites <= "0010";
        when "0011" => Diz <= "0000";   Unites <= "0011";
        when "0100" => Diz <= "0000";   Unites <= "0100";
        when "0101" => Diz <= "0000";   Unites <= "0101";
        when "0110" => Diz <= "0000";   Unites <= "0110";
        when "0111" => Diz <= "0000";   Unites <= "0000";
        when "1000" => Diz <= "0000";   Unites <= "0111";
        when "1001" => Diz <= "0000";   Unites <= "1001";
        when "1010" => Diz <= "0001";   Unites <= "0000";
        when "1011" => Diz <= "0001";   Unites <= "0001";
        when "1100" => Diz <= "0001";   Unites <= "0010";
        when "1101" => Diz <= "0001";   Unites <= "0011";
        when "1110" => Diz <= "0001";   Unites <= "0100";
        when "1111" => Diz <= "0001";   Unites <= "0101";
        when others => Diz <= "1111";   Unites <= "0000";
    end case;

end process;

end Behavioral;
