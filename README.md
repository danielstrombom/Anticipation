# Anticipation
Code for review of Strömbom &amp; Antia. Anticipation induces polarized collective motion in attraction based models.

INSTRUCTIONS FOR GENERATING FIGURES 2 AND 3 IN THE MANUSCRIPT

Download the folders Fig2 and Fig3 to your computer.

GENERATE FIG 2 

Set Fig2 as Current Folder in Matlab.

To run a complete set of new simulations to generate Fig 2 run the script LabAnticipation.m. This script calls the main simulation function (anticipation.m) 100 times for each c from 0.02 to 2 in increments of 0.02 with \tau=0 and then the same with \tau=1. May take many hours to finish.

REGENERATE FIG 3

Set Fig3 as Current Folder in Matlab.

To run a complete set of new simulations to generate Fig 3 run the script LabAnticipationTau.m. This script calls the main simulation function (anticipation.m) 100 times for each \tau from 0 to 8 in increments of 0.25 with c=0.1 and N=100. May take a while to finish.


NOTE: Figure/font size, colour/width of lines and other superficial features of the plots you generated will/may differ from the ones in the manuscript.
