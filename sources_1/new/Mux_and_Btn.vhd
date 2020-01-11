----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11.01.2020 17:50:39
-- Design Name: 
-- Module Name: Mux_and_Btn - Behavioral
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

entity Mux_and_Btn is
    Port ( 
           -- Input
           Hex : in STD_LOGIC; -- Est-ce qu'il faut calculer la valeur du Hex ici ou s'est vraiment un input comme ça semble le dire dans le guide (mais pas dans le schema)?
           
           Dizaine : in STD_LOGIC_VECTOR (3 downto 0);
           Unite_ns : in STD_LOGIC_VECTOR (3 downto 0);
           Code_signe : in STD_LOGIC_VECTOR (3 downto 0);
           Unite_s : in STD_LOGIC_VECTOR (3 downto 0);
           
           -- Control
           erreur : in STD_LOGIC;
           BTN : in STD_LOGIC_VECTOR (1 downto 0);
           S2 : in STD_LOGIC;
           
           -- Output
           AFF0 : out STD_LOGIC_VECTOR (3 downto 0);
           AFF1 : out STD_LOGIC_VECTOR (3 downto 0));
end Mux_and_Btn;

architecture Behavioral of Mux_and_Btn is
    
    signal got_err : STD_LOGIC := '0';
begin
    
    mux : process(erreur, BTN, S2)
    begin
        got_err <= '0'; -- Reinitialize
        
        -- Update buttons
        if BTN(0) = '0' and BTN(1) = '0' then
            -- BCD 1
            AFF0 <= Unite_ns;
            AFF1 <= Dizaine;
        elsif BTN(0) = '1' and BTN(1) = '0' then
            -- Hexadecimal
            -- ?? on calcul ici ou ailleurs?
        elsif BTN(0) = '0' and BTN(1) = '1' then
            -- BCD -5
            AFF0 <= Unite_s;
            AFF1 <= Code_signe;
        else
            got_err <= '1'; -- new error
        end if;
        
        -- Update S2 button
        if S2 = '1' then
            got_err <= '1'; -- new error
        end if;
        
        --Update error code
        if erreur = '1' then
            got_err <= '1'; -- new error
        end if;
        
        if got_err = '1' then
            -- Send error code
            
        end if;
        
    end process;


end Behavioral;
