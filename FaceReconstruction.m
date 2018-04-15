clc; 
clear all; 

%load image package
pkg load image;

img = load('faces.mat');
[m, n] = size(img.FACES);
i_SIZE = sqrt(m); 
s = sqrt(n); 
G_size = i_SIZE * s;  %G_size is grid size

%%%%%%%%%%% DISPLAYING THE DATABASE %%%%%%%%%%
for i = 1:n
   k = img.FACES(:,i);
   image{i} = reshape(k, [i_SIZE, i_SIZE]);
end
f = struct('faces', []);
z = 1;
for i = 1: i_SIZE: G_size
   for j = 1: i_SIZE: G_size
      f.faces(i: i + (i_SIZE-1) , j: j + (i_SIZE-1)) = image{z};
      z = z + 1;
   end
end
images = f.faces;
figure(1); 
imshow(images, []);title('Image Database')

%%%%%%%%%%%%%% Calculate Mean Face  %%%%%%%%%%%%%
temp = img.FACES;
face = mean(temp,2);
mean_face = reshape(face, [i_SIZE, i_SIZE]);
figure(2);
imshow(mean_face, []);title('Mean Face')

%%%%%%%%%%%%% Calculate COVARIANCE MATRIX %%%%%%%
cov_mat = zeros(m, m);
for i = 1:n
    difference(:,i) = img.FACES(:,i) - face;
end
cov_mat = difference'*difference;
cov_mat = (1/9)*cov_mat;

% %%%%%%%%%%%%% Calculate Eigen Values and Vectors %%%%%
 [eigen_values, eigen_vectors] = eig(cov_mat);
 %sort the eigen vectors in decreasing order
 [eigen_vectors, d] = sort(diag(eigen_vectors), 'descend');
 eigen_values = eigen_values(:, d);
 e_vectors = difference*eigen_values;
 %normalize the vectors
 e_normalized = norm(e_vectors);
 e_vectors = (1/e_normalized)*e_vectors;
 
for i = 1:n
    im1{i} = e_vectors(:,i);     
    im_faces{i} = reshape(im1{i}, [i_SIZE, i_SIZE]);
end

e_faces = struct('faces', []);
z = 1;
for i = 1: i_SIZE: G_size     %convert image cells into structure
   for j = 1: i_SIZE: G_size
      e_faces.faces(i: i + (i_SIZE-1) , j: j + (i_SIZE-1)) = im_faces{z};
      z = z + 1;
   end
end

eigen_faces = e_faces.faces;
figure(3); 
imshow(eigen_faces, []);title('Eigen Faces')

%%%%%%%%%%%%%%%%%Face Reconstruction %%%%%%%%%%%
% for loop is used because we need to reconstruct faces for eigen vec
%=3 and 6
for q=1:2
eigenfaces = q*3; 
eigen_vec_new = zeros(m, n);
eigen_vec_new (:, 1:eigenfaces)= e_vectors(:, 1:eigenfaces);
%project to a new feature space
z = difference' * eigen_vec_new; 

%%%reconstruction
reconstruction = z * eigen_vec_new';
reconstruction = reconstruction';

for i = 1:n
    o{i} = reconstruction(:,i) + face;
    op{i} = reshape(o{i}, [i_SIZE, i_SIZE]); %op =output
end

faces_op = struct('faces', []);
z = 1;
%convert image cells into structure
for i = 1: i_SIZE: G_size        
   for j = 1: i_SIZE: G_size
      faces_op.faces(i: i + (i_SIZE-1) , j: j + (i_SIZE-1)) = op{z};
      z = z + 1;
   end
end
op_images = faces_op.faces;
figure(q+4); imshow(op_images, []);
title(['Reconstructed Image with number of Eigen Faces =' num2str(eigenfaces)]);
end