library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

entity catalan_datapath is
port (clk, rst, i_ld, i_en, w_ld, w_en, wr: in std_logic;
      n: in std_logic_vector (1 downto 0);
      wt, val, w2: in std_logic_vector (7 downto 0);
      iGTn, wGTw2: out std_logic;
      addr : out std_logic_vector(1 downto 0);
      dout : out std_logic_vector(7 downto 0));
end entity;

architecture rtl of catalan_datapath is
    component count_up_2bit is
        port (clk, rst, ld, en: in std_logic;
              d: in std_logic_vector(1 downto 0);
              count: out std_logic_vector(1 downto 0));
    end component;

    component count_up_8bit is
        port (clk, rst, ld, en: in std_logic;
              d: in std_logic_vector(7 downto 0);
              count: out std_logic_vector(7 downto 0));
    end component;

    component isGreater_2bit is
        port (x, y: in std_logic_vector (1 downto 0);
              isGreater: out std_logic);
    end component;

    component isGreater_8bit is
        port (x, y: in std_logic_vector (7 downto 0);
              isGreater: out std_logic);
    end component;

    component inc_8bit is
        port (x: in std_logic_vector (7 downto 0);
              y: out std_logic_vector (7 downto 0));
    end component;
    component k_ram is
port(clk, wr : in std_logic;
i, n : in std_logic_vector(1 downto 0);
w, wt, val, w2 : in std_logic_vector(7 downto 0);
dout : out std_logic_vector(7 downto 0));
end component;
    signal w, w_plus: std_logic_vector (7 downto 0);
    signal i : std_logic_vector(1 downto 0);
    signal addr_uns : unsigned(1 downto 0);
begin
    u0: count_up_2bit port map (clk, rst, i_ld, i_en, "00", i);
    u1: count_up_8bit port map (clk, rst, w_ld, w_en, "00000000", w);
    u2: inc_8bit port map (w, w_plus);
    u3: isGreater_2bit port map (i, n, iGTn);
    u4: isGreater_8bit port map (w_plus, w2, wGTw2);
    ram : k_ram port map (clk, wr, i, n, w, wt, val, w2, dout);
    addr_uns <= unsigned(i) - 1;
    addr <= std_logic_vector(addr_uns);
end rtl;