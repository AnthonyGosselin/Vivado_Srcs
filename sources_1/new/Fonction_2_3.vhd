----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10.01.2020 11:24:29
-- Design Name: 
-- Module Name: Fonction_2_3 - Behavioral
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

entity Fonction_2_3 is
    Port ( ADCBin : in STD_LOGIC_VECTOR (3 downto 0);
           A2_3 : out STD_LOGIC_VECTOR (2 downto 0));
end Fonction_2_3;

architecture Behavioral of Fonction_2_3 is

  component Add4bitsB is
    Port ( A : in STD_LOGIC_VECTOR (3 downto 0);
           B : in STD_LOGIC_VECTOR (3 downto 0);
           Cin : in STD_LOGIC;
           Sum : out STD_LOGIC_VECTOR (3 downto 0);
           Cout : inout STD_LOGIC);
    end component;
    
    signal A : STD_LOGIC_VECTOR (3 downto 0);
    signal B : STD_LOGIC_VECTOR (3 downto 0);
    signal Sum : STD_LOGIC_VECTOR (3 downto 0);
    signal Cout: STD_LOGIC;

begin
    
    inst_Adder : Add4bitsB
        port map ( A => A, B => B, Cin => '0', Sum => Sum, Cout => Cout);
        
    ADCBin_Recieve : Process ( ADCBin )
    begin
        A <= "000" & ADCBin(3);
        B <= '0' & ADCBin(3 downto 1);
        
        -- Add done
        A2_3 <= Sum(2 downto 0);
    end process;
    
end Behavioral;
