entity RTC is
	port(
	);
end entity RTC

architecture rtl of RTC is
	-- CLOCK IS 50 MHz
	constant c_sec_in_min:natural = 60;
	constant c_min_in_hour:natural  = 60;
	constant c_hour_in_day:natural = 24;
	
	signal r_sec : natural range c_sec_in_min downto 0;
	signal r_min: natural range c_min_in_hour downto 0;
	signal r_hour: natural range c_hour_in_day downto 0 ;
	
	constant c_1Hz:natural = 50000000;
	constant c_6000Hz:natural = 8333;
	constant c_1000Hz:natural = 50000;
	
	signal r_1000Hz:natural range c_1000Hz downto 0;
	signal r_6000Hz:natural range c_6000Hz downto 0;
	signal s_reset_led;
	signal s_disp_active: natural range c_nb_disp downto 0;
	
	constant c_nb_disp:natural = 6;
	
	signal s_curr_nb: natural range 9 downto 0;
	signal s_Sel_seg: std_logic_vector(7 downto 0);
	
	begin

	counters: process(clk) is
	begin
		if rising_edge(clk) then
			if r_1Hz = c_1Hz -1 then
				r_1Hz <= 0
				r_sec <= r_sec +1
			else
				r_1Hz <= r_1Hz +1
			end if;
			if r_sec = c_sec_in_min -1 then
				r_sec <= 0;
				r_min <= r_min + 1
			end if;
			if r_min = c_min_in_hour -1 then
				r_min <= 0;
				r_hour <= r_hour + 1
			end if;
			if r_hour = c_hour_in_day -1 then
				r_hour <= 0;
			end if;
		end if;
	end process counters;
	
	disp_counters: process(clk) is 
	begin
		if rising_edge(clk) then
			if r_6000Hz = c_6000Hz -1 then
				r_6Hz <= 0;
				s_disp_active <= s_disp_active + 1
			else
				r_6000Hz <= r_6000Hz + 1 
			end if;
			if s_disp_active = c_nb_disp then
				s_disp_active = 0;
				s_reset_led <= not s_reset_led;
			end if;
	end;
	end process disp_counters;
	
	display: process(s_disp_active) is
	begin
		case s_disp_active is
			when 0 =>
				s_curr_nb <= r_sec mod 10;
			when 1 => 
				s_curr_nb <= r_sec / 10;
			when 2 =>
				s_curr_nb <= r_min mod 10;
			when 3 =>
				s_curr_nb <= r_min / 10;
			when 4 =>
				s_curr_nb <= r_hour mod 10;
			when 5 =>
				s_curr_nb <= r_hour / 10;
			when others =>
				s_curr_nb <= 0;
		end case;
		
		case s_curr_nb is
			when 0 =>
				s_Sel_seg <= '00111111';
			when 1 =>
				s_Sel_seg <= '00000110';
			when 2 =>
				s_Sel_seg <= '01011011';
			when 3 =>
				s_Sel_seg <= '01001111';
			when 4 =>
				s_Sel_seg <= '01100110';
			when 5 =>
				s_Sel_seg <= '01101101';
			when 6 =>
				s_Sel_seg <= '01111101';
			when 7 =>
				s_Sel_seg <= '00000111';
			when 8=>
				s_Sel_seg <= '01111111';
			when 9 =>
				s_Sel_seg <= '01101111';
			when others => s_Sel_seg <= '00000000';
			end case;
	end;
	end process display;
	
end;