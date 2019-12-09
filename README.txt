************************************************************************************
************************************************************************************
*                                DLX PROJECT										   
*                   TESSER ANDREA		   VIANELLO NICOLA						   
*                                 GROUP 12
************************************************************************************
************************************************************************************
Organization of the folders:

ASM : contains the .asm program used to test the DLX and the assembler with the
supported instructions.

place_and_route : contains the post-place-and-route netlist and reports

synthesis: In the main folder the post synthesis netlist and reports are placed.
In the folder analysis_reports there are two sub-folders on which the results coming
from the area and power analysis respectively are saved. In these last sub-folders,
the reports name respects the following rule: 
Quantity type report + quantity under constraint + worst possible timing path.
In the folder scripts there are both the analysis scripts and the script used to
synthesis the DLX.

VHDL: Here all the files that compose the design are stored with the recommended
organization. In the testbench subfolder there are the VHDL testbench and the script
used for the simulation in Modelsim. 

final_report: The report of our work in pdf format.

schematics: some block diagrams and RTL schematics of the design.
