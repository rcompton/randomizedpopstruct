%
% Compile PROPACK
%

clear all;
close all;
clc;

mex -v bdsqr_mex.c dbdqr.f -output bdsqr -llapack -largeArrayDims -lblas
mex -v reorth_mex.c reorth.f -output reorth -llapack -largeArrayDims -lblas
mex -v tqlb_mex.c tqlb.f -output tqlb -llapack -largeArrayDims -lblas