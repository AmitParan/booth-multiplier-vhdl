library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity project_a_tb is
end project_a_tb;

architecture arc_project_a_tb of project_a_tb is

  component project_a
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
  end component;

  signal clk   : std_logic := '0';
  signal rst   : std_logic := '0';
  signal start : std_logic := '0';
  signal A     : std_logic_vector(3 downto 0) := (others => '0');
  signal B     : std_logic_vector(3 downto 0) := (others => '0');
  signal P     : std_logic_vector(7 downto 0);
  signal EQZ   : std_logic;
  signal done  : std_logic;

  constant clk_period : time := 10 ns;

begin

  UUT: project_a
    port map (
      clk   => clk,
      rst   => rst,
      start => start,
      A     => A,
      B     => B,
      P     => P,
      EQZ   => EQZ,
      done  => done
    );

  -- Clock generation
  clk_process : process
  begin
    while true loop
      clk <= '0';
      wait for clk_period / 2;
      clk <= '1';
      wait for clk_period / 2;
    end loop;
  end process;

  -- Stimulus
  stim_proc : process
  begin
    --------------------------------------------------------
    -- Test Case 1: A = 3, B = -2
    rst <= '1';
    wait for 20 ns;
    rst <= '0';
    wait for 20 ns;

    A <= "0011";  -- 3
    B <= "1110";  -- -2
    start <= '1';
    wait for clk_period;
    start <= '0';
    wait until done = '1';
    wait for clk_period;
    report "Test 1: A=3, B=-2, P=" & integer'image(to_integer(signed(P))) severity note;

    --------------------------------------------------------
    -- Test Case 2: A = -3, B = 3
    rst <= '1';
    wait for 20 ns;
    rst <= '0';
    wait for 20 ns;

    A <= "1101";  -- -3
    B <= "0011";  -- 3
    start <= '1';
    wait for clk_period;
    start <= '0';
    wait until done = '1';
    wait for clk_period;
    report "Test 2: A=-3, B=3, P=" & integer'image(to_integer(signed(P))) severity note;

    --------------------------------------------------------
    -- Test Case 3: A = 0, B = -4
    rst <= '1';
    wait for 20 ns;
    rst <= '0';
    wait for 20 ns;

    A <= "0000";  -- 0
    B <= "1100";  -- -4
    start <= '1';
    wait for clk_period;
    start <= '0';
    wait until done = '1';
    wait for clk_period;
    report "Test 3: A=0, B=-4, P=" & integer'image(to_integer(signed(P))) severity note;

    --------------------------------------------------------
    -- Test Case 4: A = -1, B = -1
    rst <= '1';
    wait for 20 ns;
    rst <= '0';
    wait for 20 ns;

    A <= "1111";  -- -1
    B <= "1111";  -- -1
    start <= '1';
    wait for clk_period;
    start <= '0';
    wait until done = '1';
    wait for clk_period;
    report "Test 4: A=-1, B=-1, P=" & integer'image(to_integer(signed(P))) severity note;

    --------------------------------------------------------
    -- Test Case 5: A = 7, B = 7
    rst <= '1';
    wait for 20 ns;
    rst <= '0';
    wait for 20 ns;

    A <= "0111";  -- 7
    B <= "0111";  -- 7
    start <= '1';
    wait for clk_period;
    start <= '0';
    wait until done = '1';
    wait for clk_period;
    report "Test 5: A=7, B=7, P=" & integer'image(to_integer(signed(P))) severity note;

    report "All test cases completed successfully." severity note;
    wait;
  end process;

end arc_project_a_tb;
