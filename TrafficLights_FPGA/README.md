# Traffic Light Controller on FPGA (DE1-SoC)

VHDL project implementing a finite-state machine (FSM) traffic light controller for a 3-direction junction plus pedestrian crossing lights.

## Contents

- `TrafficLight/TrafficLight.vhd`: top-level traffic light FSM
- `TrafficLight/Vhdl2.vhd`: clock divider (50 MHz to 1 Hz tick)
- `TrafficLight/Waveform6.vwf`: waveform setup for simulation in Quartus
- `TrafficLight/TrafficLight.qpf`, `TrafficLight/TrafficLight.qsf`: Quartus project files
- `MoschopoulouPavlina.pdf`: project report with design details, state diagrams, and implementation notes.

## Tools

- Intel/Altera Quartus II 13.1
- Target board/chip: Altera DE1-SoC, Cyclone V
