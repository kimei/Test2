----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:23:22 01/13/2011 
-- Design Name: 
-- Module Name:    VHDL - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
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
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

---- Uncomment the following library declaration if instantiating
---- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity VHDL is
    Port ( 	lys : out  STD_LOGIC;
				lys2 : out  STD_LOGIC;
				clk_100m : in std_logic;
				knapp : in std_logic; -- reset
				lyd : out std_logic);
	end VHDL;

architecture Behavioral of VHDL is
signal clkdiv_count : integer range 10000 downto 0;
signal clk_1k  : std_logic;
signal dim_count_sw : integer range 10000 downto 0;
signal lys2_S : std_logic;
signal snu : std_logic;

begin
lys <= '1' when (knapp = '0') else '0';
lys2 <= lys2_S;



clk_div:process (clk_100m)
begin
	if clk_100m'event and clk_100m = '1' then
		if knapp = '1' then
			clkdiv_count <= 0;
			clk_1k <= '0';
			dim_count_sw <= 0;
			lys2_S <= '0';
			snu <= '0';
		else
			clkdiv_count <= clkdiv_count + 1;
			clk_1k <= '0';
			lys2_S <= '1';
			
			if clkdiv_count > dim_count_sw then
				lys2_S <= '0';
			end if;
			
			if clkdiv_count = 9999 then
				clk_1k <= '1';
				
				if dim_count_sw = 2 then
					snu <= '0';
				end if;
				if snu = '1' then
					dim_count_sw <= dim_count_sw - 1;
				else
					dim_count_sw <= dim_count_sw + 1;
				end if;
			end if;
			
			if dim_count_sw = 9998 then
				snu <= '1';
			end if;
			
		end if;
	end if;
end process clk_div;

end Behavioral;

