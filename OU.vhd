library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity OU is
  port (
    clk          : in std_logic;
    rst          : in std_logic;
    A            : in std_logic_vector(3 downto 0);
    B            : in std_logic_vector(3 downto 0);
    load         : in std_logic;
    shift_enable : in std_logic;
    P            : out std_logic_vector(7 downto 0);
    EQZ          : out std_logic
  );
end OU;

architecture arc_OU of OU is

  signal RA           : std_logic_vector(7 downto 0);
  signal RB           : std_logic_vector(8 downto 0);
  signal ACC          : signed(7 downto 0) := (others => '0');
  signal shift_amount : integer range 0 to 20 := 0;

begin

  process(clk, rst)
    variable RB_slice   : std_logic_vector(2 downto 0);
    variable partial_pp : signed(7 downto 0);
    variable acc_var    : signed(7 downto 0);
  begin
    if rst = '1' then
      RA  <= (others => '0');
      RB  <= (others => '0');
      ACC <= (others => '0');
      shift_amount <= 0;

    elsif rising_edge(clk) then
      if load = '1' then
        RA <= std_logic_vector(resize(signed(A), 8));
        RB <= std_logic_vector(resize(signed(B), 8)) & '0';
        ACC <= (others => '0');
        shift_amount <= 0;

      elsif shift_enable = '1' then
        RB_slice := RB(2 downto 0);

        -- Booth encoding
        case RB_slice is
          when "000" | "111" => partial_pp := (others => '0');
          when "001" | "010" => partial_pp := signed(RA);
          when "011"         => partial_pp := shift_left(signed(RA), 1);
          when "100"         => partial_pp := -shift_left(signed(RA), 1);
          when "101" | "110" => partial_pp := -signed(RA);
          when others        => partial_pp := (others => '0');
        end case;

        -- accumulation with shift amount
        acc_var := ACC;
        acc_var := acc_var + shift_left(partial_pp, shift_amount);
        ACC <= acc_var;

        -- shift RB right by 2 bits
        RB <= "00" & RB(8 downto 2);

        -- increment shift amount
        shift_amount <= shift_amount + 2;
      end if;
    end if;
  end process;

  -- output assignments
  P   <= std_logic_vector(ACC);
  EQZ <= '1' when RB = "000000000" else '0';

end arc_OU;
