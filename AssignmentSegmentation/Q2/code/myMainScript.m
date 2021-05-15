load('../data/assignmentSegmentBrainGmmEmMrf.mat');

Y = imageData;
mask = imageMask;
K = 3;
%% Initialization for chosen beta
%(a) According to us, a beta of 10 gives a smooth, realistic segmentation
beta = 10;

%(b) The initial estimate is was made manually based on approximate values
%of the different classes in the image. Position was not taken into
%account. The regions were thus (0.6,1), [0.4,0.6], (0,0.4).
X = zeros(256,256);
for i=1:256
        for j=1:256
            if (mask(i,j)==0)
                continue
            end
            if(Y(i,j)<0.4)
                X(i,j)=3;  %CSF
            elseif(Y(i,j)>0.6)
                X(i,j)=1;  %White Matter
            else
                X(i,j)=2;  %Grey Matter
            end
        end
end

%(c) The variance has been initialised to 1, while the means have been
%initialized based on some test runs done on the image
vari = [1,1,1];
mu = [0.64,0.52,0.29];

%% Iterations for chosen beta
for i= 1:30
    comb = Member(Y, X, mask, K, mu, vari, beta);
    mem = comb.a;
    X = comb.b;
    post = ['log Posterior update ',num2str(comb.c),' ==> ',num2str(comb.d)];
    disp(post)
    comb= Gauss_update(Y, mem, mask, K);
    mu = comb.a;
    vari = comb.b;
end
%Optimal class means for chosen beta-
mean_display = ['means ',num2str(mu)];
disp(mean_display);
%% Saving images for chosen beta

white_b = zeros(256,256);
grey_b = zeros(256,256);
csf_b = zeros(256,256);
for i=1:256
        for j=1:256
            if (mask(i,j)==0)
                continue
            end
            if(X(i,j)==1)
                white_b(i,j)=1;  %white
                grey_b(i,j) = 0;
                csf_b(i,j) = 0;
            elseif(X(i,j)==2)
                white_b(i,j)=0;  %grey
                grey_b(i,j) = 1;
                csf_b(i,j) = 0;
            else
                white_b(i,j)=0;  %CSF
                grey_b(i,j) = 0;
                csf_b(i,j) = 1;
            end
        end
end
joint_labels_b = [white_b,grey_b,csf_b];

figure; imshow(imageData); title('Original Image');colormap('jet');colorbar;
figure; imshow(mem); title('Class-Membership Image: Chosen beta');
figure; imshow(joint_labels_b); title('Optimal Label images (chosen beta): White, Grey, CSF');
hold off;
cd ../;
save('results/original_image.mat',"imageData");
save('results/Memberships_beta.mat',"mem");
save('results/label_beta.mat',"X");
cd code;
%% Initialization for beta = 0 (No MRF)
beta = 0;
X = zeros(256,256);
for i=1:256
        for j=1:256
            if (mask(i,j)==0)
                continue
            end
            if(Y(i,j)<0.4)
                X(i,j)=3;  %CSF
            elseif(Y(i,j)>0.6)
                X(i,j)=1;  %White Matter
            else
                X(i,j)=2;  %Grey Matter
            end
        end
end
vari = [1,1,1];
mu = [0.638,0.524,0.290];

%% Iterations for beta = 0
for i= 1:30
    comb = Member(Y, X, mask, K, mu, vari, beta);
    mem = comb.a;
    X = comb.b;
    post = ['log Posterior update ',num2str(comb.c),' ==> ',num2str(comb.d)];
    disp(post)
    comb= Gauss_update(Y, mem, mask, K);
    mu = comb.a;
    vari = comb.b;
end

%% Saving images for beta = 0

white_0 = zeros(256,256);
grey_0 = zeros(256,256);
csf_0 = zeros(256,256);
for i=1:256
        for j=1:256
            if (mask(i,j)==0)
                continue
            end
            if(X(i,j)==1)
                white_0(i,j)=1;  %white
                grey_0(i,j) = 0;
                csf_0(i,j) = 0;
            elseif(X(i,j)==2)
                white_0(i,j)=0;  %grey
                grey_0(i,j) = 1;
                csf_0(i,j) = 0;
            else
                white_0(i,j)=0;  %CSF
                grey_0(i,j) = 0;
                csf_0(i,j) = 1;
            end
        end
end
joint_labels_0 = [white_0,grey_0,csf_0];

figure; imshow(imageData); title('Original Image');colormap('jet');colorbar;
figure; imshow(mem); title('Class-Membership Image: Zero beta');
figure; imshow(joint_labels_0); title('Optimal Label images (zero beta): White, Grey, CSF');

cd ../;
save('results/Memberships_zero.mat',"mem");
save('results/label_zero.mat',"X");
cd code;