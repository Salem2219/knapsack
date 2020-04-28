library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

entity k_ram is
port(clk, wr : in std_logic;
i, n : in std_logic_vector(1 downto 0);
w, wt, val, w2 : in std_logic_vector(7 downto 0);
dout : out std_logic_vector(7 downto 0));
end k_ram;
architecture rtl of k_ram is
type ram_type is array (0 to 3, 0 to 255) of
std_logic_vector(7 downto 0);
signal program: ram_type;
signal ieq0, weq0, x, y : std_logic;
signal a, b, s, y1 : std_logic_vector(7 downto 0);
signal iminus1 : unsigned(1 downto 0);
signal a_uns, wminuswt : unsigned(7 downto 0);

component max is
    port (a, b : in std_logic_vector(7 downto 0);
    y : out std_logic_vector(7 downto 0));
end component;
begin
ieq0 <= '1' when i = "00" else '0';
weq0 <= '1' when w = "00000000" else '0';
x <= ieq0 or weq0;
y <= '0' when unsigned(wt) > unsigned(w) else '1';
iminus1 <= unsigned(i) - 1;
wminuswt <= unsigned(w) - unsigned(wt);
a_uns <= unsigned(val) + unsigned(program(conv_integer(iminus1), conv_integer(wminuswt)));
a <= std_logic_vector(a_uns);
b <= program(conv_integer(iminus1), conv_integer(unsigned(w)));
u1 : max port map (a, b, y1);
s <= "00000000" when x ='1' else
y1 when y = '1' else
b;
process(clk)
begin
if (rising_edge(clk)) then
if (wr = '1') then
program(conv_integer(unsigned(i)), conv_integer(unsigned(w))) <= s;
end if;
end if;
end process;
dout <= program(conv_integer(unsigned(n)), conv_integer(unsigned(w2)));
end rtl;