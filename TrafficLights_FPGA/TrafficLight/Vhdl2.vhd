library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity clockdivider is 
    Port ( 
        clk_in  : in  STD_LOGIC;   -- 50MHz 
        reset   : in  STD_LOGIC;   -- Reset 
        clk_out : out STD_LOGIC    -- 1Hz (1 tick/sec) 
		  
    ); 
end clockdivider; 
 
architecture Behavioral of clockdivider is 
    signal counter : integer := 0; 
    signal clk_sig : STD_LOGIC := '0';  
begin 
    process(clk_in, reset) 
    begin 
        if reset = '1' then 
            counter <= 0; 
            clk_sig <= '0'; 
        elsif rising_edge(clk_in) then 
            if counter = 24999999 then --debug ow 24999999 else 4
                clk_sig <= not clk_sig; 
                counter <= 0; 
            else 
                counter <= counter + 1; 
            end if; 
        end if; 
    end process; 
     
    clk_out <= clk_sig;
	
end Behavioral;