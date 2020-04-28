library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

entity catalan_controller is
    port (clk, rst, start, iGTn, wGTw2: in std_logic;
          i_ld, i_en, w_ld, w_en, wr: out std_logic);
end entity;

architecture rtl of catalan_controller is
    type state_type is (s0, s1, s2, s3, s4, s5);
    signal current_state, next_state: state_type;
begin
    process (current_state, start, iGTn, wGTw2)
    begin
        case current_state is
            when s0 =>
                i_ld <= '0';
                i_en <= '0';
                w_ld <= '0';
                w_en <= '0';
                wr <= '0';
                next_state <= s1;
            when s1 =>
                i_ld <= '0';
                i_en <= '0';
                w_ld <= '0';
                w_en <= '0';
                wr <= '0';
                if (start = '1') then
                    next_state <= s2;
                else
                    next_state <= s1;
                end if;
            when s2 =>
                i_ld <= '1';
                i_en <= '0';
                w_ld <= '0';
                w_en <= '0';
                wr <= '0';
                next_state <= s3;
            when s3 =>
                i_ld <= '0';
                i_en <= '0';
                w_ld <= '1';
                w_en <= '0';
                wr <= '0';
                if (iGTn = '1') then
                    next_state <= s1;
                else
                    next_state <= s4;
                end if;
            when s4 =>
                i_ld <= '0';
                i_en <= '0';
                w_ld <= '0';
                w_en <= '1';
                wr <= '1';
                if (wGTw2 = '1') then
                    next_state <= s5;
                else
                    next_state <= s4;
                end if;
            when others =>
                i_ld <= '0';
                i_en <= '1';
                w_ld <= '0';
                w_en <= '0';
                wr <= '0';
                next_state <= s3;
        end case;
    end process;

    process (rst, clk)
    begin
        if (rst = '1') then
            current_state <= s0;
        elsif (rising_edge(clk)) then
            current_state <= next_state;
        end if;
    end process;
end rtl;