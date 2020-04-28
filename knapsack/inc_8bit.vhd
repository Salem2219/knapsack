library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

entity inc_8bit is
port (x: in std_logic_vector (7 downto 0);
      y: out std_logic_vector (7 downto 0));
end entity;

architecture rtl of inc_8bit is
    signal y_temp: unsigned (7 downto 0);
begin
    y_temp <= unsigned(x) + 1;
    y <= std_logic_vector(y_temp);
end rtl;