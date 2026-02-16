library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity TrafficLight is

	port (lights: out STD_LOGIC_VECTOR (8 downto 0);
	
			main_clk: in STD_LOGIC;
		
			reset : in STD_LOGIC;
			
			divided_clk_out : out STD_LOGIC --debug
			);
	
	end TrafficLight;
	

architecture Behavioral of TrafficLight is 

	type state_type is (s1, s2, s3, s4, s5, s6, s7);
	signal state: state_type;
	 signal count: unsigned(3 downto 0);  
    constant SEC2: unsigned(3 downto 0) := "0010"; 
    constant SEC6: unsigned(3 downto 0) := "0110";  
    constant SEC9: unsigned(3 downto 0) := "1001"; 
	
	signal divided_clk : std_logic;
	
	
	begin
	

	u1: entity work.clockdivider
			port map (
				clk_in => main_clk,
				clk_out => divided_clk,
				reset   => reset 
			);
			
	
	
	process (divided_clk, reset)
	begin
		if reset = '1' then 
			state <= s1;
			count <= X"0";
		
		elsif divided_clk'event and divided_clk = '1' then 
		case state is 
			when s1 =>
							if count < SEC9 then
								state <= s1;
								count <= count + 1;
							else 
								state <= s2;
								count <= X"0";
							end if;
			when s2 => 
							if count < SEC2 then 
								state <= s2;
								count <= count + 1;
							else 
								state <= s3;
								count <= X"0";
							end if;
							
			when s3 =>
							if count < SEC9 then 
								state <=s3;
								count <= count + 1;
							else 
								state <= s4;
								count <= X"0";
							end if;
							
			when s4 => 
							if count < SEC2 then 
								state <= s4;
								count <= count + 1;
							else 
								state <= s5;
								count <= X"0";
							end if;
							
			when s5 => 
							if count < SEC9 then 
								state <= s5;
								count <= count + 1;
							else 
								state <= s6;
								count <= X"0";
							end if;
			
			when s6 =>
							if count < SEC2 then 
								state <= s6;
								count <= count + 1;
							else 
								state <=s7;
								count <= X"0";
							end if;
							
			when s7 =>
							if count <= SEC9 then 
								state <= s7;
								count <= count + 1;
							else 
								state <=s1;
								count <= X"0";
							end if;
			
			when others =>
								state <= s1;
		end case;
	  end if;
	end process;
	
		
		
		C2: process (state)
			 begin	
			 case state is
					when s1 => lights <= "000001000";
					when s2 => lights <= "001000000";
					when s3 => lights <= "000010000";
					when s4 => lights <= "010000000";
					when s5 => lights <= "000100000";
					when s6 => lights <= "100000000";
					when s7 => lights <= "000000111";
					when others => lights <= "000001000";
		end case;
		end process;
	
		divided_clk_out <= divided_clk; -- debug 		
			
end Behavioral;