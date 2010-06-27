
clear all;
close all;
clc;

load genotypes_chr22_CEU_r21a_nr.txt.dat;
load genotypes_chr22_CHB_r21a_nr.txt.dat;
load genotypes_chr22_JPT_r21a_nr.txt.dat;
load genotypes_chr22_YRI_r21a_nr.txt.dat;

genotypes_chr22_CEU_r21a_nr_txt = genotypes_chr22_CEU_r21a_nr_txt';
genotypes_chr22_CHB_r21a_nr_txt = genotypes_chr22_CHB_r21a_nr_txt';
genotypes_chr22_JPT_r21a_nr_txt = genotypes_chr22_JPT_r21a_nr_txt';
genotypes_chr22_YRI_r21a_nr_txt = genotypes_chr22_YRI_r21a_nr_txt';

%This is really stupid...
[~,n1] = size(genotypes_chr22_CEU_r21a_nr_txt);
[~,n2] = size(genotypes_chr22_CHB_r21a_nr_txt);
[~,n3] = size(genotypes_chr22_JPT_r21a_nr_txt);
[~,n4] = size(genotypes_chr22_YRI_r21a_nr_txt);

n = min([n1,n2,n3,n4]);

genotypes_chr22_CEU_r21a_nr_txt = genotypes_chr22_CEU_r21a_nr_txt(:, 1:n);
genotypes_chr22_CHB_r21a_nr_txt = genotypes_chr22_CHB_r21a_nr_txt(:, 1:n);
genotypes_chr22_JPT_r21a_nr_txt = genotypes_chr22_JPT_r21a_nr_txt(:, 1:n);
genotypes_chr22_YRI_r21a_nr_txt = genotypes_chr22_YRI_r21a_nr_txt(:, 1:n);

big_data = [genotypes_chr22_CEU_r21a_nr_txt; genotypes_chr22_CHB_r21a_nr_txt; genotypes_chr22_JPT_r21a_nr_txt; genotypes_chr22_YRI_r21a_nr_txt];
clear genotypes_chr22_CEU_r21a_nr_txt
clear genotypes_chr22_CHB_r21a_nr_txt
clear genotypes_chr22_JPT_r21a_nr_txt
clear genotypes_chr22_YRI_r21a_nr_txt

make_projections(big_data);

k = 6;

tic
[~,s,~] = pca(big_data,k);
toc

%without 'econ' you crash memory
tic
[~,s0,~] = svd(big_data,'econ');
toc

s
s0 = s0(1:k, 1:k);
s0