# Booth Multiplier (Radix-4) – VHDL

VHDL implementation of a signed Booth multiplier using Radix-4 encoding.

## Project Overview

This project implements a signed Booth multiplier using Radix-4 algorithm, written in VHDL.  
The design includes:
- **CU.vhd** – Control Unit implementing a finite state machine (FSM) to manage multiplication cycles.
- **OU.vhd** – Operational Unit performing shift-add operations based on Radix-4 encoding.
- **project_a.vhd** – Top-level entity connecting CU and OU into a full system.
- **project_a_tb.vhd** – Testbench file for simulation.

The multiplier accepts **4-bit signed inputs** and outputs an **8-bit signed product**.

## Files

- `CU.vhd` – Control Unit (FSM)
- `OU.vhd` – Operational Unit
- `project_a.vhd` – Top-level entity
- `project_a_tb.vhd` – Testbench

## How to Run

1. Load all VHDL files (`CU.vhd`, `OU.vhd`, `project_a.vhd`, and `project_a_tb.vhd`) into your simulator (e.g., ModelSim).
2. Compile all files.
3. Set `project_a_tb` as the top-level for simulation.
4. Run the simulation and analyze waveforms.

## Technologies Used

- **VHDL (IEEE Standard)**
- **ModelSim** (or equivalent simulator)
- **Radix-4 Booth Multiplication Algorithm**


## Author

Amit Paran  
[GitHub Profile](https://github.com/AmitParan)

