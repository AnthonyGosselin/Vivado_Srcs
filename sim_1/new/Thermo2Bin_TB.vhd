----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/11/2020 09:18:45 PM
-- Design Name: 
-- Module Name: File_TestBench - Behavioral
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


LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
LIBRARY UNISIM;
USE UNISIM.Vcomponents.ALL;

--> L'entity du test bench est vide et elle doit le demeurer
--> L'entity peut porter le nom que vous voulez mais il est de bonne pratique 
--> d'utiliser le nom du module à tester avec un suffixe par exemple.

entity Thermo2Bin_TB is        --> Remarquez que l'ENTITY est vide et doit le demeurer pour un test bench !!!  
end Thermo2Bin_TB;

architecture Behavioral of Thermo2Bin_TB is

--> Remplacer ce COMPONENT par celui de votre COMPONENT à tester 
    -- Note: vous pouvez copier la partie PORT ( .. ) de l'entity de votre code VHDL 
    -- et l'insérer dans la déclaration COMPONENT.
--> Si vous voulez comparer 2 modules VHDL, vous pouvez déclarer 2 COMPONENTS 
    -- distincts avec leurs PORT MAP respectif. 
   
   COMPONENT Thermo2Bin
    Port ( ADC : in STD_LOGIC_VECTOR(11 downto 0);
           ADCbin : out STD_LOGIC_VECTOR (3 downto 0);
           erreur : out STD_LOGIC);
    END COMPONENT;
   
--> Générez des signaux internes au test bench avec des noms associés et les même types que dans le port
    -- Note: les noms peuvent être identiques, dans l'exemple on a ajouté un suffixe pour
    -- identifier clairement le signal qui appartient au test bench

   SIGNAL ADC_sim           : STD_LOGIC_VECTOR (11 downto 0);
   SIGNAL ADCbin_sim        : STD_LOGIC_VECTOR (3 downto 0);
   SIGNAL erreur_sim        : STD_LOGIC;

--> S'il y a plusieurs bits en entrée pour lesquels il faut définir des valeurs de test, 
    -- par exemple a, b, c dans l'exemple présent, on recommande de créer un vecteur de test,
    -- ce qui facilitera l'écriture du test et la lisibilité du code,
    -- notamment en faisant apparaître clairement une structure de table de vérité

   SIGNAL Thermometrique : STD_LOGIC_VECTOR (11 downto 0);  -- Création d'un signal interne (3 bits)
   
--> Déclarez la constante PERIOD qui est utilisée pour la simulation

   CONSTANT PERIOD    : time := 10 ns;                  --  *** à ajouter avant le premier BEGIN

--> Il faut faire un port map entre vos signaux internes et le component à tester
--> NOTE: Si vous voulez comparer 2 modules VHDL, vous devez génréer 2 port maps 


begin

  -- Par le "port-map" suivant, cela revient à connecter le composant aux signaux internes du tests bench
  -- UUT Unit Under Test: ce nom est habituel mais non imposé.
  -- Si on simule deux composantes, on pourrait avoir UUT1, UUT2 par exemple
  
  UUT: Thermo2Bin PORT MAP(
      ADC => ADC_sim,
      ADCBin => ADCBin_sim, 
      erreur => erreur_sim
   );

    --> on assigne les signaux du vecteur de test vers les signaux connectés au port map. 
    ADC_sim <= Thermometrique;
 
-- *** Test Bench - User Defined Section ***
-- l'intérêt de cette structure de test bench est que l'on recopie la table de vérité.

   tb : PROCESS
   BEGIN
         
         -- Codes normaux
         wait for PERIOD; Thermometrique <="000000000000";
         wait for PERIOD; Thermometrique <="000000000001";
         
         wait for PERIOD; Thermometrique <="000000000011";
         wait for PERIOD; Thermometrique <="000000000111";
         wait for PERIOD; Thermometrique <="000000001111";
         wait for PERIOD; Thermometrique <="000000011111";
         wait for PERIOD; Thermometrique <="000000111111";
         wait for PERIOD; Thermometrique <="000001111111";
         wait for PERIOD; Thermometrique <="000011111111";
         wait for PERIOD; Thermometrique <="000111111111";
         wait for PERIOD; Thermometrique <="001111111111";
         wait for PERIOD; Thermometrique <="011111111111";
         wait for PERIOD; Thermometrique <="111111111111";
         
         -- Codes avec erreur
         wait for PERIOD; Thermometrique <="000000000010";
         wait for PERIOD; Thermometrique <="000000101111";
         wait for PERIOD; Thermometrique <="111100001111";
                  
         WAIT; -- will wait forever
   END PROCESS;


end Behavioral;
