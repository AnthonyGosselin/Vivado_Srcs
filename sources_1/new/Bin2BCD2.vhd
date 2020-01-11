----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/11/2020 03:24:01 PM
-- Design Name: 
-- Module Name: Bin2BCD2 - Behavioral
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

entity Bin2BCD2 is
    Port ( Moins5 : in STD_LOGIC_VECTOR (3 downto 0);
           Moins : out STD_LOGIC_VECTOR (3 downto 0);
           Unit5 : out STD_LOGIC_VECTOR (3 downto 0));
end Bin2BCD2;

architecture Behavioral of Bin2BCD2 is

begin

ADC_to_BCD_S: process (Moins5)
begin

    case Moins5 is
        when "0000" => Moins <= "0000";   Unit5 <= "0000";
        when "0001" => Moins <= "0000";   Unit5 <= "0001";
        when "0010" => Moins <= "0000";   Unit5 <= "0010";
        when "0011" => Moins <= "0000";   Unit5 <= "0011";
        when "0100" => Moins <= "0000";   Unit5 <= "0100";
        when "0101" => Moins <= "0000";   Unit5 <= "0101";
        when "0110" => Moins <= "0000";   Unit5 <= "0110";
        when "0111" => Moins <= "0000";   Unit5 <= "0111";
        when "1000" => Moins <= "0001";   Unit5 <= "0100";
        when "1001" => Moins <= "0001";   Unit5 <= "0111";
        when "1010" => Moins <= "0001";   Unit5 <= "0110";
        when "1011" => Moins <= "0001";   Unit5 <= "0101";
        when "1100" => Moins <= "0001";   Unit5 <= "0100";
        when "1101" => Moins <= "0001";   Unit5 <= "0011";
        when "1110" => Moins <= "0001";   Unit5 <= "0010";
        when "1111" => Moins <= "0001";   Unit5 <= "0001";
        when others => Moins <= "1111";   Unit5 <= "0000";
    end case;

end process;

end Behavioral;
