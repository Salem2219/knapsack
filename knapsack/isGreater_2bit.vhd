library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

entity isGreater_2bit is
    port (x, y: in std_logic_vector (1 downto 0);
          isGreater: out std_logic);
end entity;

architecture rtl of isGreater_2bit is
begin
    process(x, y)
    begin
        if (unsigned(x) > unsigned(y)) then
            isGreater <= '1';
        else
            isGreater <= '0';
        end if;
    end process;
end rtl;