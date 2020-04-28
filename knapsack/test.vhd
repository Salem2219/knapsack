library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

entity test is
    port (clk, rst, start : in std_logic;
    n : in std_logic_vector(1 downto 0);
    w2 : in std_logic_vector(7 downto 0);
    dout : out std_logic_vector(7 downto 0));
end test;

architecture rtl of test is
    component catalan_toplevel is
port (clk, rst, start: in std_logic;
       n: in std_logic_vector (1 downto 0);
      w2, wt, val: in std_logic_vector (7 downto 0);
      addr : out std_logic_vector(1 downto 0);
      dout : out std_logic_vector(7 downto 0));
end component;
component wt_rom is
port(addr: in std_logic_vector (1 downto 0);
data: out std_logic_vector (7 downto 0));
end component;
component val_rom is
port(addr: in std_logic_vector (1 downto 0);
data: out std_logic_vector (7 downto 0));
end component;

signal addr : std_logic_vector(1 downto 0);
signal wt, val : std_logic_vector(7 downto 0);
begin
    tl : catalan_toplevel port map (clk, rst, start, n, w2, wt, val, addr, dout);
    wt_arr : wt_rom port map (addr, wt);
    val_arr : val_rom port map (addr, val);
end rtl;