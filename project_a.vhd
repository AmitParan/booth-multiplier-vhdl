library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity project_a is
  port (
    clk   : in std_logic;
    rst   : in std_logic;
    start : in std_logic;
    A     : in std_logic_vector(3 downto 0);
    B     : in std_logic_vector(3 downto 0);
    P     : out std_logic_vector(7 downto 0);
    EQZ   : out std_logic;
    done  : out std_logic
  );
end project_a;

architecture arc_project_a of project_a is

  -- Internal control signals between CU and OU
  signal load_clear   : std_logic;
  signal shift_enable : std_logic;
  signal EQZ_internal : std_logic; -- internal signal from OU to CU

begin

  -- Control Unit instantiation
  CU_inst: entity work.CU
    port map (
      clk          => clk,
      rst          => rst,
      start        => start,
      EQZ          => EQZ_internal,     -- ← new input to CU
      load_clear   => load_clear,
      shift_enable => shift_enable,
      done         => done
    );

  -- Operational Unit instantiation
  OU_inst: entity work.OU
    port map (
      clk          => clk,
      rst          => rst,
      A            => A,
      B            => B,
      load         => load_clear,
      shift_enable => shift_enable,
      P            => P,
      EQZ          => EQZ_internal      -- ← internal wire from OU to CU
    );

  -- external EQZ output (optional, for testbench visibility)
  EQZ <= EQZ_internal;

end arc_project_a;
