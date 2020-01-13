---------------------------------------------------------------------------------------------
-- Labo_adder4b.vhd   
---------------------------------------------------------------------------------------------
-- Université de Sherbrooke - Département de GEGI
-- Version         : 2.0
-- Nomenclature    : 0.8 GRAMS
-- Date            : 4 décembre 2018
-- Auteur(s)       : Réjean Fontaine, Daniel Dalle
-- Technologies    : FPGA Zynq (carte ZYBO Z7-10 ZYBO Z7-20)
--                   peripheriques: Pmod8LD PmodSSD
--
-- Outils          : vivado 2018.2 64 bits
---------------------------------------------------------------------------------------------
-- Description:
-- Circuit utilitaire pour le laboratoire de logique combinatoire
--
-- Revision:  3 décembre 2018,  R. Fontaine, D. Dalle ; Développement sur carte ZYBO-Z7
--
---------------------------------------------------------------------------------------------
-- À faire :
-- Voir le guide de l'APP
--    Insérer les modules additionneurs ("components" et "instances")
--
---------------------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.ALL;
use ieee.numeric_std.ALL;
library UNISIM;
use UNISIM.Vcomponents.ALL;

entity labo_adder4b is
  port ( 
          i_btn       : in    std_logic_vector (3 downto 0); -- Boutons de la carte Zybo
          i_sw        : in    std_logic_vector (3 downto 0); -- Interrupteurs de la carte Zybo
          sysclk      : in    std_logic;                     -- horloge systeme
          o_SSD       : out   std_logic_vector (7 downto 0); -- vers cnnecteur pmod afficheur 7 segments
          o_led       : out   std_logic_vector (3 downto 0); -- vers DELs de la carte Zybo
          o_led6_r    : out   std_logic;                     -- vers DEL rouge de la carte Zybo
          o_pmodled   : out   std_logic_vector (7 downto 0)  -- vers connecteur pmod 8 DELs
          );
end labo_adder4b;

architecture BEHAVIORAL of labo_adder4b is

   constant nbreboutons     : integer := 4;    -- Carte Zybo Z7
   constant freq_sys_MHz    : integer := 125;  -- 125 MHz 
   
   signal d_s_1Hz           : std_logic;
   signal clk_5MHz          : std_logic;
   --
   signal d_opa             : std_logic_vector (3 downto 0):= "0000";   -- operande A
   signal d_opb             : std_logic_vector (3 downto 0):= "0000";   -- operande B
   signal d_cin             : std_logic := '0';                         -- retenue entree
   signal d_sum             : std_logic_vector (3 downto 0):= "0000";   -- somme
   signal d_cout            : std_logic := '0';                         -- retenue sortie
   --
   signal d_AFF0            : std_logic_vector (3 downto 0):= "0000";
   signal d_AFF1            : std_logic_vector (3 downto 0):= "0000";
 
   
 component synchro_module_v2 is
   generic (const_CLK_syst_MHz: integer := freq_sys_MHz);
      Port ( 
           clkm        : in  STD_LOGIC;  -- Entrée  horloge maitre
           o_CLK_5MHz  : out STD_LOGIC;  -- horloge divise utilise pour le circuit             
           o_S_1Hz     : out  STD_LOGIC  -- Signal temoin 1 Hz
            );
      end component;  


 component affhexPmodSSD is
   generic (const_CLK_MHz: integer := freq_sys_MHz);
       Port (  clk      : in   STD_LOGIC;
               DA       : in   STD_LOGIC_VECTOR (7 downto 0);  -- donnee digit 1 et 0     
               JPmod    : out  STD_LOGIC_VECTOR (7 downto 0)
              );
   end component;
   
   
   -- Added component modules
   Component Thermo2Bin is
       Port ( ADC : in STD_LOGIC_VECTOR(11 downto 0);
              ADCbin : out STD_LOGIC_VECTOR (3 downto 0);
              erreur : out STD_LOGIC);
    end Component;
    
    SIGNAL s_ADC: STD_LOGIC_VECTOR (11 downto 0);
    SIGNAL s_ADCbin: STD_LOGIC_VECTOR (3 downto 0);
    SIGNAL s_erreur: STD_LOGIC;
   
   Component Fonction_2_3 is
        Port ( ADCBin : in STD_LOGIC_VECTOR (3 downto 0);
               A2_3 : out STD_LOGIC_VECTOR (2 downto 0));
    end Component;
    
    SIGNAL s_A2_3: STD_LOGIC_VECTOR (2 downto 0);
 
    Component Decodeur3_8 is
    Port ( A2_3 : in STD_LOGIC_VECTOR (2 downto 0);
           LD : out STD_LOGIC_VECTOR (7 downto 0));
    end Component;
    
    SIGNAL s_LD: STD_LOGIC_VECTOR (7 downto 0);
    
    Component Parity is
    Port ( ADCBin : in STD_LOGIC_VECTOR (3 downto 0);
           i_S1: in STD_LOGIC; -- C'est les bouton S1 pour le type de parité... Pourquoi ça dit de le mettre en sortie dans l'annexe du guide?
           Parite : out STD_LOGIC);
    end Component;
    
    SIGNAL s_i_S1: STD_LOGIC;
    SIGNAL s_Parite: STD_LOGIC;
    
    Component Bin2BCD1 is
    Port ( ADCBin : in STD_LOGIC_VECTOR (3 downto 0);
           Diz : out STD_LOGIC_VECTOR (3 downto 0);
           Unites : out STD_LOGIC_VECTOR (3 downto 0));
    end Component;
    
    SIGNAL s_Diz: STD_LOGIC_VECTOR (3 downto 0);
    SIGNAL s_Unite_ns: STD_LOGIC_VECTOR (3 downto 0);
    
    Component Moins_5 is
    Port ( ADCbin : in STD_LOGIC_VECTOR (3 downto 0);
           Moins5 : out STD_LOGIC_VECTOR (3 downto 0));
    end Component;
    
    SIGNAL s_Moins5: STD_LOGIC_VECTOR (3 downto 0);
    
    Component Bin2BCD2 is
    Port ( Moins5 : in STD_LOGIC_VECTOR (3 downto 0);
           Moins : out STD_LOGIC_VECTOR (3 downto 0);
           Unit5 : out STD_LOGIC_VECTOR (3 downto 0));
    end Component;
    
    SIGNAL s_Moins: STD_LOGIC_VECTOR (3 downto 0);
    SIGNAL s_Unite_s: STD_LOGIC_VECTOR (3 downto 0);
    
    Component Mux_and_Btn is
    Port ( 
           -- Input
           ADCbin : in STD_LOGIC_VECTOR (3 downto 0);
           
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
    end Component;
    
    SIGNAL s_BTN: STD_LOGIC_VECTOR (1 downto 0);
    SIGNAL s_S2: STD_LOGIC;
    SIGNAL s_AFF0: STD_LOGIC_VECTOR (3 downto 0);
    SIGNAL s_AFF1: STD_LOGIC_VECTOR (3 downto 0);
   

begin
  
    inst_synch : synchro_module_v2
     generic map (const_CLK_syst_MHz => freq_sys_MHz)
         port map (
            clkm         => sysclk,
            o_CLK_5MHz   => clk_5MHz,
            o_S_1Hz      => d_S_1Hz
        );  

   inst_aff :  affhexPmodSSD 
    generic map (const_CLK_MHz => 5)  
       port map (
           clk    => clk_5MHz,
           -- donnee a afficher definies sur 8 bits : chiffre hexa position 1 et 0
           DA(7 downto 4)  => d_AFF1, 
           DA(3 downto 0)  => d_AFF0,
           JPmod  => o_SSD   -- sorties directement adaptees au connecteur PmodSSD
       );
       
       
    inst_Thermo2Bin: Thermo2Bin
        port map (
            ADC     =>   s_ADC,
            ADCBin  =>   s_ADCBin,
            erreur    =>   s_erreur
         );
   
    inst_Fonction_2_3: Fonction_2_3
        port map (
            ADCBin  =>   s_ADCBin,
            A2_3    =>   s_A2_3
         );

    inst_Decodeur3_8: Decodeur3_8
        port map (
            A2_3  =>   s_A2_3,
            LD    =>   s_LD
         );

    inst_Parity: Parity
        port map (
            ADCBin  =>   s_ADCBin,
            i_S1    =>   s_i_S1,
            Parite  =>   s_Parite
         );

    inst_Bin2BCD1: Bin2BCD1
        port map (
            ADCBin  =>   s_ADCBin,
            Diz    => s_Diz,
            Unites    => s_Unite_ns
         );

    inst_Moins_5: Moins_5
        port map (
            ADCBin  =>   s_ADCBin,
            Moins5  => s_Moins5
         );

    inst_Bin2BCD2: Bin2BCD2
        port map (
            Moins5  =>   s_Moins5,
            Moins    =>  s_Moins,
            Unit5    => s_Unite_s
         );

    inst_Mux_and_Btn: Mux_and_Btn
        port map (
            ADCBin  =>   s_ADCBin,
            Dizaine    => s_Diz,
            Unite_ns    => s_Unite_ns,
            Code_signe    =>  s_Moins,
            Unite_s    => s_Unite_s,
            erreur    => s_erreur,
            BTN    => s_BTN,
            S2    => s_S2,
            AFF0    => s_AFF0,
            AFF1    => s_AFF1
         );

   d_opa               <=  i_sw;                        -- operande A sur interrupteurs
   d_opb               <=  i_btn;                       -- operande B sur boutons
   d_cin               <=  d_S_1Hz;                     -- la retenue d'entrée alterne 0 1 a 1 Hz
      
   d_AFF0              <=  d_sum(3 downto 0);           -- Le resultat affiché sur PmodSSD(0)
   d_AFF1              <=  '0' & '0' & '0' & d_Cout;    -- La retenue de sortie affichée sur PmodSSD(1) (0 ou 1)
   o_led6_r            <=  d_Cout;                      -- La led couleur représente aussi la retenue en sortie  Cout
   o_pmodled           <=  d_opa & d_opb;               -- Les opérandes d'entrés reproduits combinés sur Pmod8LD
   o_led (3 downto 0)  <=  '0' & '0' & '0' & d_S_1Hz;   -- La LED0 sur la carte représente retenue d'entrée        
   
   
end BEHAVIORAL;


