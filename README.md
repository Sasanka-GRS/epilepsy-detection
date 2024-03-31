# Epilepsy Detection with Graph Learning

### Required packages

1. MATLAB
2. Network metrics toolbox
3. YALMIP and MOSEK solvers

### Data format

The data should be in a .mat format. The data must be split into 5 time regions, before epilepsy (r1), just before epilepsy (r2), epilepsy (r3), just after epilepsy (r4) and after epilepsy (r5). Thus, the data should have the following format

Subject_1.mat

|_ r1 (N x T1 matrix)
|_ r2 (N x T2 matrix)
|_ r3 (N x T3 matrix)
|_ r4 (N x T4 matrix)
|_ r5 (N x T5 matrix)


T1, T2, T3, T4 and T5 are the duration (time-stamps) in the respective time regions, and N is the number of electrodes (nodes).

### Running

1. Run the init.m file with all the required packages and dependencies linked there. This adds them to the MATLAB path, after which they need not be in the same folder.
2. Copy the data (which is in the above format) in the ANALYSIS and CLASSIFICATION PIPELINE folders.
3. Run the final.m code to generate till TFA
4. Run the windowedGL.m code to extract graphs over time, with respective band-choices, TFA choices and graph learning choices.
