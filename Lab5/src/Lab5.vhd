library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity Lab5 is
 generic (
 G_LFSR_WIDTH : positive := 22
 );
 port (
 i_Clk : in std_logic;
 i_Rst : in std_logic;
 i_Switch_1 : in std_logic;
 i_Switch_2 : in std_logic;
 o_LED_1 : out std_logic;
 o_LED_2 : out std_logic;
 o_LED_3 : out std_logic;
 o_LED_4 : out std_logic
 );
end entity Lab5;
architecture RTL of Lab5 is
signal w_LFSR_Done : std_logic;
 signal w_LFSR_Data : std_logic_vector(G_LFSR_WIDTH-1 downto 0);
 signal r_LFSR_Toggle : std_logic := '0';
begin
 LFSR_INST : entity work.lfsr_timer
 generic map (
 G_WIDTH => G_LFSR_WIDTH
 )
 port map (
 i_Clk => i_Clk,
 i_Rst => i_Rst,
 o_LFSR_Data => w_LFSR_Data,
 o_LFSR_Done => w_LFSR_Done
 );
 process (i_Clk)
 begin
 if rising_edge(i_Clk) then
 if i_Rst = '1' then
 r_LFSR_Toggle <= '0';
 elsif w_LFSR_Done = '1' then
 r_LFSR_Toggle <= not r_LFSR_Toggle;
 end if;
 end if;
 end process;
 DEMUX_INST : entity work.demux_1_to_4
 port map (
 i_Data => r_LFSR_Toggle,
 i_Sel0 => i_Switch_1,
 i_Sel1 => i_Switch_2,
 o_Data0 => o_LED_1,
 o_Data1 => o_LED_2,
 o_Data2 => o_LED_3,
 o_Data3 => o_LED_4
 );
end architecture RTL;