
-- Standard library
library ieee;
-- Standard packages
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity segment_display_tb is
end segment_display_tb;

--=============================================================================
-- ARCHITECTURE DECLARATION
--=============================================================================
architecture tb of segment_display_tb is

  constant CLK_PER : time    := 8 ns;   -- 125 MHz clk freq
  constant CLK_LIM : integer := 2**22;  -- Stops simulation from running forever if circuit is not correct
  constant DELAY : time := 32ns; 
constant TEST : time := 1ns; 
  
  signal clk  : std_logic := '0';
  signal nReset : std_logic := '0';

   signal address : std_logic_vector(2-1 downto 0);
   signal write : std_logic := '0';
   signal read : std_logic := '0';
   signal writedata : std_logic_vector(8-1 downto 0);
   signal readdata : std_logic_vector(8-1 downto 0);

   signal SelSeg           :    std_logic_vector(7 downto 0);
   signal Reset_Led        :    std_logic;
   signal nSelDig          :    std_logic_vector(5 downto 0);

--=============================================================================
-- COMPONENT DECLARATIONS
--=============================================================================
 -- component display
        --port(
	--		clk : in std_logic;
	--		nReset : in std_logic;
	--		
	--		-- Internal interface (i.e. Avalon slave).
	--		address : in std_logic_vector(3-1 downto 0);
	--		write : in std_logic;
	--		read : in std_logic;
	--		
	--		writedata : in std_logic_vector(8-1 downto 0);
	--		readdata : out std_logic_vector(8-1 downto 0);
	--		
	--		-- External interface (i.e. conduit).
	--		SelSeg           : out   std_logic_vector(7 downto 0);
	--		Reset_Led        : out   std_logic;
	--		nSelDig          : out   std_logic_vector(5 downto 0)
        --);
    --end component;


--=============================================================================
-- ARCHITECTURE BEGIN
--=============================================================================
begin

--=============================================================================
-- COMPONENT INSTANTIATIONS
--=============================================================================
  dut: entity work.sevensegmentdisplay
    PORT MAP(
        clk => clk,
        nReset => nReset, 
	address => address,
	write => write,
	read => read,
	writedata => writedata,
	readdata => readdata,
	SelSeg => SelSeg,
	Reset_Led => Reset_Led,
	nSelDig => nSelDig
    );
--=============================================================================
-- CLOCK PROCESS
-- Process for generating the clock signal
--=============================================================================
  p_clock: process
  begin
    clk <= '0';
    wait for CLK_PER / 2;
    clk <= '1';
    wait for CLK_PER / 2;
  end process;

--=============================================================================
-- RESET PROCESS
-- Process for generating the reset signal
--=============================================================================
  p_reset: process
  begin
    -- Reset the registers
    wait for CLK_PER;
    nReset <= '0';
    wait for CLK_PER;
    nReset <= '1';
    wait;
  end process;

--=============================================================================
-- TEST PROCESSS
--=============================================================================
  p_stim: process


  begin
    	wait until nReset = '1';
    	wait for 4*CLK_PER;
	address <= "11";
	wait for 4*CLK_PER;
	writedata <= "00000000";
	wait for 2*CLK_PER;
	  	write <= '1';
	wait for 2*CLK_PER;
	  	write <= '0';
	wait for 10*CLK_PER;
	address <= "10";
	wait for 4*CLK_PER;
	writedata <= "00000100";
	wait for 2*CLK_PER;
	  	write <= '1';
	wait for 2*CLK_PER;
	  	write <= '0';
	wait for 10*CLK_PER;
	writedata <= "00000000";
	wait for 20000*CLK_PER;
	address <= "11";
	wait for 4 * CLK_PER;
	writedata <= "00000010";
	wait for 2*CLK_PER;
	  	write <= '1';
	wait for 2*CLK_PER;
	  	write <= '0';
	wait for 10*CLK_PER;
	address <= "11";
	wait for 4*CLK_PER;
	writedata <= "00000000";
	wait for 2*CLK_PER;
	  	write <= '1';
	wait for 2*CLK_PER;
	  	write <= '0';
	wait for 10*CLK_PER;
	wait for 20000*CLK_PER;
	address <= "11";
	wait for 4 * CLK_PER;
	writedata <= "00000001";
	wait for 2*CLK_PER;
	  	write <= '1';
	wait for 2*CLK_PER;
	  	write <= '0';
	 
   wait;
  end process;

end architecture tb;
--=============================================================================
-- ARCHITECTURE END
--=============================================================================
