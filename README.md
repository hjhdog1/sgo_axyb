# A Stochastic Global Optimization Algorithm for the Two-Frame Sensor Calibration Problem (IEEE TIE 2016)
<br>

[**Paper**](https://ieeexplore.ieee.org/stamp/stamp.jsp?arnumber=7347394)

MATLAB implementation of Stochastic Global Optimization Algorithm for the Two-Frame Sensor Calibration Problem AX = YB


## Overview
This is an implementation of a fast and numerically robust optimization algorithm for the two-frame sensor calibration (or equivalently, hand-eye and robot-world calibration) AX = YB, which is a two-phase stochastic geometric optimization algorithm for finding the global minimizer. Using coordinate-invariant differential geometric methods that take into account the matrix Lie group structure of the rigid-body transformations, the algorithm makes use of analytic gradients and Hessians, and a strictly descending fast step-size estimate to achieve significant performance improvements.

## Instruction
To run the calibration, call
```
[X, Y] = solveAXYB_SE3(A,B,alpha,param)
```
where
* ``A, B`` are the measurement datasets, each of which is in size of ``4 X 4 X n`` (for n measurements).
* ``alpha`` is weight factor of translation error; e.g., transration error of 1.0mm is equally weighted to 1 radian rotational error given ``alpha = 1.0`` (when length unit in data is mm).
* ``param`` is a struct of algorithm parameters. Declare by ``param = defaultParam()`` and set ``param.globalOptMethod = 2`` for stochastic global optimization. See  ``instruction.docx`` for more details.
* ``X, Y`` are the calibration results.

## Demos
Demo codes are included that generate sythetic datasets and run calibrations on the generated datasets.
* To generate a synthetic dataset, run ``main_dataGeneration_SE3.m``.
* To run calibration on the generated dataset, run ``main_solve_AXYB_SE3.m``.

SO(3) case is handled in ``main_dataGeneration_SO3.m`` and ``main_solve_AXYB_SO3.m``

