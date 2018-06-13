function OutputName = Recognition(TestImage, m, A, Eigenfaces)
% Recognizing step....
%
% Description: This function compares two faces by projecting the images into facespace and 
% measuring the Euclidean distance between them.
%
% Argument:      TestImage              - Path of the input test image
%
%                m                      - (M*Nx1) Mean of the training
%                                         database, which is output of 'EigenfaceCore' function.
%
%                Eigenfaces             - (M*Nx(P-1)) Eigen vectors of the
%                                         covariance matrix of the training
%                                         database, which is output of 'EigenfaceCore' function.
%
%                A                      - (M*NxP) Matrix of centered image
%                                         vectors, which is output of 'EigenfaceCore' function.
% 
% Returns:       OutputName             - Name of the recognized image in the training database.
%
% See also: RESHAPE, STRCAT

% Original version by Amir Hossein Omidvarnia, October 2007
%                     Email: aomidvar@ece.ut.ac.ir                  

%%%%%%%%%%%%%%%%%%%%%%%% Projecting centered image vectors into facespace
% All centered images are projected into facespace by multiplying in
% Eigenface basis's. Projected vector of each face will be its corresponding
% feature vector.

ProjectedImages = [];
Train_Number = size(A,2);
for i = 1 : Train_Number
    temp = Eigenfaces'*A(:,i); % Projection of centered images into facespace��ÿ������ͶӰ�������ռ�
    ProjectedImages = [ProjectedImages temp]; 
end

%%%%%%%%%%%%%%%%%%%%%%%% Extracting the PCA features from test image
InputImage = imread(TestImage);
%temp = InputImage(:,:,1);
temp = InputImage;

[irow icol] = size(temp);
InImage = reshape(temp',irow*icol,1);
Difference = double(InImage)-m; % Centered test image
ProjectedTestImage = Eigenfaces'*Difference; % Test image feature vector����������ͶӰ�������ռ�

%%%%%%%%%%%%%%%%%%%%%%%% Calculating Euclidean distances
%%%%%%%%%%%%%%%%%%%%%%%% ����ŷʽ����ȡ��С��ԭ��ó�ƥ�������
% Euclidean distances between the projected test image and the projection
% of all centered training images are calculated. Test image is
% supposed to have minimum distance with its corresponding image in the
% training database.

Euc_dist = [];
for i = 1 : Train_Number
    q = ProjectedImages(:,i);
    temp = ( norm( ProjectedTestImage - q ) )^2;
    Euc_dist = [Euc_dist temp];
end

[Euc_dist_min , Recognized_index] = min(Euc_dist);

i=Recognized_index;
str = int2str(i);

if i<10
    str = strcat('00',str);
elseif i<100
    str = strcat('0',str);
end
    
str = strcat('orl',str);
OutputName = strcat(str,'.bmp');
