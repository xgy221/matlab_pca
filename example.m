% A sample script, which shows the usage of functions, included in
% PCA-based face recognition system (Eigenface method)
%
% See also: CREATEDATABASE, EIGENFACECORE, RECOGNITION

% Original version by Amir Hossein Omidvarnia, October 2007
%                     Email: aomidvar@ece.ut.ac.ir                  

clear all
clc
close all

% You can customize and fix initial directory paths
%TrainDatabasePath = uigetdir(strcat(matlabroot,'\work'), 'Select training database path' );
% TestDatabasePath = uigetdir(strcat(matlabroot,'\work'), 'Select test database path');

TrainDatabasePath = 'D:\matlab code\PCA_based Face Recognition System\ORL';
TestDatabasePath='D:\matlab code\PCA_based Face Recognition System\ORL_Test';

prompt = {'Enter test image name :'};
dlg_title = 'Input of PCA-Based Face Recognition System';
num_lines= 1;
def = {'1'};

% TestImage  = inputdlg(prompt,dlg_title,num_lines,def);
TestImage='orl001';
TestImage = strcat(TestDatabasePath,'\',char(TestImage),'.bmp');
im = imread(TestImage);

T = CreateDatabase(TrainDatabasePath);
[m, A, Eigenfaces] = EigenfaceCore(T);
OutputName = Recognition(TestImage, m, A, Eigenfaces);

SelectedImage = strcat(TrainDatabasePath,'\',OutputName);
SelectedImage = imread(SelectedImage);

figure;
subplot(1,2,1);imshow(im);
title('Test Image');
subplot(1,2,2);imshow(SelectedImage);
title('Equivalent Image');

str = strcat('Matched image is :  ',OutputName);
disp(str)
