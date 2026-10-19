--------------------------------------------------------------------------------
-- Cameron Marsh
-- Component declarations for lab5 top level.
--------------------------------------------------------------------------------
package components is
    component button_sync is
        port (
            clk : in std_logic;
            reset : in std_logic;
            async_in : in std_logic;
            sync_out : out std_logic
            );
    end component;
    component level_sync is
        generic(
            WIDTH : integer := 3
        );  
        port (
             clk               : in std_logic;
            reset             : in std_logic;
            async_in          : in std_logic_vector(WIDTH-1 downto 0);
            sync_out          : out std_logic_vector(WIDTH-1 downto 0)
        );
    end component;
    component double_dabble is
        port (
            result_padded : in std_logic_vector(11 downto 0);
            ones : out std_logic_vector(3 downto 0);
            tens : out std_logic_vector(3 downto 0);
            hundreds : out std_logic_vector(3 downto 0)
        );
    end component;
    component add_sub is
        port (
            a       : in  std_logic_vector(bits-1 downto 0);
            b       : in  std_logic_vector(bits-1 downto 0);
	        clk		: in std_logic;
	        reset 	: in std_logic;
	        op		: in std_logic;
            result : out std_logic_vector(3 downto 0)
        );
    end component;
    component seven_seg is
        port (
            reset           : in std_logic;
            bcd             : in std_logic_vector(3 downto 0);
            ssd_out   : out std_logic_vector(6 downto 0)
        );  
    end component;

end package components;