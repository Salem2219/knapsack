library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

entity val_rom is
port(addr: in std_logic_vector (1 downto 0);
data: out std_logic_vector (7 downto 0));
end val_rom;
architecture rtl of val_rom is
type rom_type is array (0 to 3) of
std_logic_vector (7 downto 0);
constant program : rom_type := (
"00111100", 
"01100100",
"01111000",
"00000000");
begin
data <= program(conv_integer(unsigned(addr)));
end rtl;