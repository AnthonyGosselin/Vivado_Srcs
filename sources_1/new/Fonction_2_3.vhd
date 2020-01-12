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
    
    
    signal A : STD_LOGIC_VECTOR (7 downto 0);
    signal B : STD_LOGIC_VECTOR (7 downto 0);
    
    signal Sum : STD_LOGIC_VECTOR (7 downto 0);
    signal SumPlus1 : STD_LOGIC_VECTOR (3 downto 0);
    
    signal Cin : STD_LOGIC;
    signal Cout: STD_LOGIC;
    

begin
    
    unit_Adder : Add4bitsB
        port map ( A => A(7 downto 4), B => B(7 downto 4), Cin => Cin, Sum => Sum(7 downto 4), Cout => Cout);
        
    decimal_Adder : Add4bitsB
        port map ( A => A(3 downto 0), B => B(3 downto 0), Cin => '0', Sum => Sum(3 downto 0), Cout => Cin);
        
    add1 : Add4bitsB
        port map ( A => Sum(7 downto 4), B => "0001", Cin => '0', Sum => SumPlus1, Cout => Cout);
        
    ADCBin_Recieve : Process ( ADCBin )
    begin
    
        A <= "000" & ADCBin(3 downto 0) & '0';
        B <= '0' & ADCBin(3 downto 0) & "000";
        
        -- Add done, select if we need to add +1 in edge cases
        
        
    end process;
    
    A2_3 <= SumPlus1(2 downto 0) when Sum(3) = '1'
    else Sum(6 downto 4);
    
end Behavioral;
