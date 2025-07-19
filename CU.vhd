library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity CU is
  port (
    clk          : in std_logic;
    rst          : in std_logic;
    start        : in std_logic;
    EQZ          : in std_logic;      -- ← NEW: signal from OU indicating RB=0
    load_clear   : out std_logic;     -- Activates loading of operands and accumulator clear
    shift_enable : out std_logic;     -- Enables shifting and partial product generation
    done         : out std_logic      -- Indicates multiplication is complete (1 clock cycle)
  );
end CU;

architecture arc_CU of CU is

  -- FSM states
  type state_type is (IDLE, LOAD, SHIFTING, STOP);
  signal state, next_state : state_type;

begin

  -- State update
  process(clk, rst)
  begin
    if rst = '1' then
      state <= IDLE;
    elsif rising_edge(clk) then
      state <= next_state;
    end if;
  end process;

  -- Next state logic using EQZ
  process(state, start, EQZ)
  begin
    next_state <= state; -- default

    case state is
      when IDLE =>
        if start = '1' then
          next_state <= LOAD;
        end if;

      when LOAD =>
        next_state <= SHIFTING;

      when SHIFTING =>
        if EQZ = '1' then
          next_state <= STOP;
        else
          next_state <= SHIFTING;
        end if;

      when STOP =>
        next_state <= IDLE;

      when others =>
        next_state <= IDLE;
    end case;
  end process;

  -- Output logic
  load_clear   <= '1' when state = LOAD else '0';
  shift_enable <= '1' when state = SHIFTING else '0';
  done         <= '1' when state = STOP else '0';

end arc_CU;
