library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

entity catalan_toplevel is
port (clk, rst, start: in std_logic;
       n: in std_logic_vector (1 downto 0);
      w2, wt, val: in std_logic_vector (7 downto 0);
      addr : out std_logic_vector(1 downto 0);
      dout : out std_logic_vector(7 downto 0));
end entity;

architecture rtl of catalan_toplevel is
    component catalan_datapath is
        port (clk, rst, i_ld, i_en, w_ld, w_en, wr: in std_logic;
      n: in std_logic_vector (1 downto 0);
      wt, val, w2: in std_logic_vector (7 downto 0);
      iGTn, wGTw2: out std_logic;
      addr : out std_logic_vector(1 downto 0);
      dout : out std_logic_vector(7 downto 0));
    end component;

    component catalan_controller is
        port (clk, rst, start, iGTn, wGTw2: in std_logic;
              i_ld, i_en, w_ld, w_en, wr: out std_logic);
    end component;

    signal i_ld, i_en, w_ld, w_en, iGTn, wGTw2, wr: std_logic;
begin
    u0: catalan_datapath port map (clk, rst, i_ld, i_en, w_ld, w_en, wr, n, wt, val, w2, iGTn, wGTw2, addr, dout);
    u1: catalan_controller port map (clk, rst, start, iGTn, wGTw2, i_ld, i_en, w_ld, w_en, wr);
end rtl;

