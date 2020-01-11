----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/11/2020 01:15:17 PM
-- Design Name: 
-- Module Name: Parity - Behavioral
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

entity Parity is
    Port ( ADCBin : in STD_LOGIC_VECTOR (3 downto 0);
           --i_S1: in STD_LOGIC; -- C'est les bouton S1 pour le type de parité... Pourquoi ça dit de le mettre en sortie dans l'annexe du guide?
           Parite : out STD_LOGIC);
end Parity;

architecture Behavioral of Parity is

begin

    parity_check: process (ADCBin) -- Tony 11-jan: Ajouter update lorsque bouton S1 change d'état (enfoncé/relâché)
    begin
        
        -- Tony 11-jan: il reste a détecter si le bouton S1 est enfoncé, si oui, on inverse tous ces valeurs de retours
        case ADCBin is
            when "0000" => Parite <= '0';
            when "0001" => Parite <= '1';
            when "0010" => Parite <= '1';
            when "0011" => Parite <= '0';
            when "0100" => Parite <= '1';
            when "0101" => Parite <= '0';
            when "0110" => Parite <= '0';
            when "0111" => Parite <= '1';
            when "1000" => Parite <= '1';
            when "1001" => Parite <= '0';
            when "1010" => Parite <= '0';
            when "1011" => Parite <= '1';
            when "1100" => Parite <= '0';
            when "1101" => Parite <= '1';
            when "1110" => Parite <= '1';
            when "1111" => Parite <= '0';
            when others => Parite <= '0';
        end case;
    
    end process;

end Behavioral;
