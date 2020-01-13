----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 13.01.2020 10:30:24
-- Design Name: 
-- Module Name: Thermo2Bin - Behavioral
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

entity Thermo2Bin is
    Port ( ADC : in STD_LOGIC_VECTOR(11 downto 0);
           ADCbin : out STD_LOGIC_VECTOR (3 downto 0);
           erreur : out STD_LOGIC);
end Thermo2Bin;

architecture Behavioral of Thermo2Bin is
begin 
    convertBin : process(ADC)
    begin
    
        -- group0 : ADC(3 downto 0)
        -- group1 : ADC(7 downto 4)
        -- group2 : ADC(11 downto 8)

        if ADC(11 downto 8) = "0000" and ADC(7 downto 4) = "0000" and (ADC(3 downto 0) = "0000" or ADC(3 downto 0) = "0001" or ADC(3 downto 0) = "0011" or ADC(3 downto 0) = "0111" or ADC(3 downto 0) = "1111") then
            -- First case
              
            ADCbin(3) <= '0';
            ADCbin(2) <= ADC(3);
            ADCbin(1) <= ADC(1) AND (NOT ADC(3));
            ADCbin(0) <= ((NOT ADC(3)) AND ADC(2)) OR ((NOT ADC(1)) AND ADC(0)); 
            
            erreur <= '0';
        elsif ADC(11 downto 8) = "0000" and ADC(3 downto 0) = "1111" and (ADC(7 downto 4) = "0001" or ADC(7 downto 4) = "0011" or ADC(7 downto 4) = "0111" or ADC(7 downto 4) = "1111") then
            -- Second case

            ADCbin(3) <= ADC(7);
            ADCbin(2) <= NOT ADC(7);
            ADCbin(1) <= ADC(5) AND (NOT ADC(7));
            ADCbin(0) <= ((NOT ADC(7)) AND ADC(6)) OR ((NOT ADC(5)) AND ADC(4)); 
            
            erreur <= '0';
        elsif ADC(7 downto 4) = "1111" and ADC(3 downto 0) = "1111" and (ADC(11 downto 8) = "0001" or ADC(11 downto 8) = "0011" or ADC(11 downto 8) = "0111" or ADC(11 downto 8) = "1111") then

            ADCbin(3) <= ADC(8);
            ADCbin(2) <= ADC(11);
            ADCbin(1) <= ADC(9) AND (NOT ADC(11));
            ADCbin(0) <= ((NOT ADC(11)) AND ADC(10)) OR ((NOT ADC(9)) AND ADC(8)); 
            
            erreur <= '0';
        else
            ADCbin <= "1111";
            erreur <= '1';
        end if;
    end process;

end Behavioral;
