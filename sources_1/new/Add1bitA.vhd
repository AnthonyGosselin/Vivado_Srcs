----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08.01.2020 14:13:04
-- Design Name: 
-- Module Name: Add1bitA - Behavioral
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

entity Add1bitA is
    Port ( A : in STD_LOGIC;
           B : in STD_LOGIC;
           Cin : in STD_LOGIC;
           Sum : out STD_LOGIC;
           Cout : out STD_LOGIC);
end Add1bitA;

architecture Behavioral of Add1bitA is

begin

    process(A, B, Cin)
        variable x : std_logic_vector(2 downto 0);
        begin
            x := A & B & Cin;
            
           case (x) is
              when "000" =>
                 Sum <= '0';
                 Cout <= '0';
              when "001" =>
                 Sum <= '1';
                 Cout <= '0';
              when "010" =>
                 Sum <= '1';
                 Cout <= '0';
              when "011" =>
                 Sum <= '0';
                 Cout <= '1';
              when "100" =>
                 Sum <= '1';
                 Cout <= '0';
              when "101" =>
                 Sum <= '0';
                 Cout <= '1';
              when "110" =>
                 Sum <= '0';
                 Cout <= '1';
              when "111" =>
                 Sum <= '1';
                 Cout <= '1';
              when others =>
                 Sum <= '0';
                 Cout <= '0';
           end case;
    end process;
           
    

end Behavioral;
