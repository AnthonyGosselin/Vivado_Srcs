----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/11/2020 02:34:34 PM
-- Design Name: 
-- Module Name: Add_Sub4bits - Behavioral
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

entity Add_Sub4bits is
    Port ( A : in STD_LOGIC_VECTOR (3 downto 0);
           B : in STD_LOGIC_VECTOR (3 downto 0);
           Cin : in STD_LOGIC;
           Sum : out STD_LOGIC_VECTOR (3 downto 0);
           Cout : inout STD_LOGIC);
end Add_Sub4bits;

architecture Behavioral of Add_Sub4bits is

  component Add4bitsB is
    Port ( A : in STD_LOGIC_VECTOR (3 downto 0);
           B : in STD_LOGIC_VECTOR (3 downto 0);
           Cin : in STD_LOGIC;
           Sum : out STD_LOGIC_VECTOR (3 downto 0);
           Cout : inout STD_LOGIC);
    end component;

    signal BComp: STD_LOGIC_VECTOR (3 downto 0);
    signal tempBComp: STD_LOGIC_VECTOR (3 downto 0);
    signal CoutComp: STD_LOGIC;

begin

        tempBComp(0) <= '1' when B(0) = '0'
        else '0';

        tempBComp(1) <= '1' when B(1) = '0'
        else '0';
        
        tempBComp(2) <= '1' when B(2) = '0'
        else '0';
        
        tempBComp(3) <= '1' when B(3) = '0'
        else '0';
    
    add1: Add4bitsB
        port map ( A => tempBComp, B => "0001", Cin => '0', Sum => BComp, Cout => CoutComp);

    inst_Adder : Add4bitsB
        port map ( A => A, B => BComp, Cin => Cin, Sum => Sum, Cout => Cout);

end Behavioral;
