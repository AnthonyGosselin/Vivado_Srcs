----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08.01.2020 14:13:04
-- Design Name: 
-- Module Name: Add4bitsA - Behavioral
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

entity Add4bitsA is
    Port ( A : in STD_LOGIC_VECTOR(3 downto 0);
           B : in STD_LOGIC_VECTOR(3 downto 0);
           Cin : in STD_LOGIC;
           Sum : out STD_LOGIC_VECTOR(3 downto 0);
           Cout : inout STD_LOGIC);
end Add4bitsA;

architecture Behavioral of Add4bitsA is
    component Add1bitA
        Port ( A : in STD_LOGIC;
               B : in STD_LOGIC;
               Cin : in STD_LOGIC;
               Sum : out STD_LOGIC;
               Cout : out STD_LOGIC);
    end component;
    
    component Add1bitB
        Port ( A : in STD_LOGIC;
               B : in STD_LOGIC;
               Cin : in STD_LOGIC;
               Sum : out STD_LOGIC;
               Cout : out STD_LOGIC);
    end component;

signal C : STD_LOGIC_VECTOR(3 downto 1); 		
begin
    addMod1 : Add1bitA
        Port map (
            A       =>      A(0),
            B       =>      B(0),
            Cin     =>      Cin,
            Sum     =>      Sum(0),
            Cout    =>      C(1)
        );
        
     addMod2 : Add1bitA
        Port map (
            A       =>      A(1),
            B       =>      B(1),
            Cin     =>      C(1),
            Sum     =>      Sum(1),
            Cout    =>      C(2)
        );
        
     addMod3 : Add1bitB
        Port map (
            A       =>      A(2),
            B       =>      B(2),
            Cin     =>      C(2),
            Sum     =>      Sum(2),
            Cout    =>      C(3)
        );
        
     addMod4 : Add1bitB
        Port map (
            A       =>      A(3),
            B       =>      B(3),
            Cin     =>      C(3),
            Sum     =>      Sum(3),
            Cout    =>      Cout
        );

end Behavioral;
