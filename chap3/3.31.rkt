#lang sicp
#|
The add-action procedure is called in called in the definition of 'inverter',
'and-gate', and 'or-gate', and it where the delay, logic, and watching of
input changes for for each function takes place. If we didn't call the procedure
right away, the changes in signal would never be called, and the time delays
wouldn't take place. We wouldn't get any change in output for the signals and the
time delay wouldn't be correct at all.
|#


            

