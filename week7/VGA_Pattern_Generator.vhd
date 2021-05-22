library ieee;
    use ieee.std_logic_1164.all;
    use ieee.std_logic_arith.all;
    use ieee.std_logic_unsigned.all;
    
entity VGA_Pattern_Generator is
    port(
      nRst     : in std_logic;
      clk      : in std_logic;
      VGA_CLK  : out std_logic;
      VGA_BLANK: out std_logic;
      VGA_HS   : out std_logic;
      VGA_VS   : out std_logic;
      VGA_SYNC : out std_logic;
      VGA_R    : out std_logic_vector(9 downto 0);
      VGA_G    : out std_logic_vector(9 downto 0);
      VGA_B    : out std_logic_vector(9 downto 0)
    );
    end VGA_Pattern_Generator;
    
architecture beh of VGA_Pattern_Generator is
   
      signal H_cnt : std_logic_vector(9 downto 0);
      signal V_cnt : std_logic_vector(9 downto 0);
      signal pclk  : std_logic;
      
begin
   
   process(nRst, clk)
   begin
      if(nRst = '0') then
         pclk <= '0';
      elsif rising_edge(clk) then
         pclk <= not pclk;
      end if;
   end process;
   
   process(nRst, pclk)
   begin
      if(nRst = '0') then
         H_cnt <= (others => '0');
         V_cnt <= (others => '0');
      elsif rising_edge(pclk) then
         if(H_cnt = 799) then
            H_cnt <= (others => '0');
            if(V_cnt = 524) then
               V_cnt <= (others => '0');
            else
               V_cnt <= V_cnt + 1;
            end if;
         else
            H_cnt <= H_cnt + 1;
         end if;
      end if;
		
		if(((H_cnt > 240 and H_cnt < 260) and (V_cnt > 52 and V_cnt < 112 )) or
      ((H_cnt > 220 and H_cnt < 240) and (V_cnt > 112 and V_cnt < 152)) or
      ((H_cnt > 200 and H_cnt < 220) and (V_cnt > 152 and V_cnt < 192)) or
      ((H_cnt > 180 and H_cnt < 200) and (V_cnt > 192 and V_cnt < 232)) or
      ((H_cnt > 160 and H_cnt < 180) and (V_cnt > 232 and V_cnt < 272)) or
      ((H_cnt > 260 and H_cnt < 280) and (V_cnt > 112 and V_cnt < 152)) or
      ((H_cnt > 280 and H_cnt < 300) and (V_cnt > 152 and V_cnt < 192)) or
      ((H_cnt > 300 and H_cnt < 320) and (V_cnt > 192 and V_cnt < 232)) or
      ((H_cnt > 320 and H_cnt < 340) and (V_cnt > 232 and V_cnt < 272)) or
      ((H_cnt > 240 and H_cnt < 260) and (V_cnt > 232 and V_cnt < 312)) or   
      ((H_cnt > 160 and H_cnt < 340) and (V_cnt > 292 and V_cnt < 312)) or
      ((H_cnt > 200 and H_cnt < 300) and (V_cnt > 332 and V_cnt < 352)) or
      ((H_cnt > 180 and H_cnt < 200) and (V_cnt > 352 and V_cnt < 372)) or
      ((H_cnt > 300 and H_cnt < 320) and (V_cnt > 352 and V_cnt < 372)) or
      ((H_cnt > 160 and H_cnt < 180) and (V_cnt > 372 and V_cnt < 452)) or
      ((H_cnt > 320 and H_cnt < 340) and (V_cnt > 372 and V_cnt < 452)) or
      ((H_cnt > 180 and H_cnt < 200) and (V_cnt > 452 and V_cnt < 472)) or
      ((H_cnt > 300 and H_cnt < 320) and (V_cnt > 452 and V_cnt < 472)) or
      ((H_cnt > 200 and H_cnt < 300) and (V_cnt > 472 and V_cnt < 492)) ) then
         VGA_R <= (others => '1');
		else
         VGA_R <= (others => '0');
   end if; 
		
   end process;
   
   VGA_CLK   <= pclk;
   VGA_HS    <= '0' when (H_cnt >= 0  ) and (H_cnt <= 99 ) else '1';
   VGA_VS    <= '0' when (V_cnt >= 0  ) and (V_cnt <= 1  ) else '1';
   VGA_BLANK <= '1' when (H_cnt >= 149) and (H_cnt <= 789) else '0';
   VGA_SYNC  <= '1';
 
   
end beh;