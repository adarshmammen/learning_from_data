load helix.mat
scatter3(X(1,:),X(2,:),X(3,:),35,tt);
title('Helix 3D plot'); xlabel 'X1', ylabel 'X2', zlabel 'X3';
view([12 20])
grid on

clear;

load swiss.mat

scatter3(X(1,:),X(2,:),X(3,:),25,tt);
title('Swiss roll 3D plot'); xlabel 'X1', ylabel 'X2', zlabel 'X3';
view([12 20])
grid on


clear all

% Linear Kernel
%helix
clear all;
load helix.mat
rng('default')
n = 700;

H = eye(700) - 1/n .* ones(700);
c = 0;

Linear_K = X' * X + c;

Linear_Gram = H * Linear_K * H;

[V D] = eig(Linear_Gram);

V_q = [V(:,1) V(:,2)];

eigen_values = [abs(D(1,1)) abs(D(2,2))];
eigen_values_root = eigen_values.^(1/2);

lamda_q_root = diag(eigen_values_root);

encoded =  lamda_q_root * V_q';


figure
scatter(encoded(1,:),encoded(2,:),20,tt)
title 'Helix linear kernel'
grid on

%%%%%%%%%%%%%%%%%%swissroll
clear all;
load swiss.mat
rng('default')
n = 700;

H = eye(700) - 1/n .* ones(700);
c = 0;

Linear_K = X' * X + c;

Linear_Gram = H * Linear_K * H;

[V D] = eig(Linear_Gram);

V_q = [V(:,1) V(:,2)];

eigen_values = [abs(D(1,1)) abs(D(2,2))];
eigen_values_root = eigen_values.^(1/2);

lamda_q_root = diag(eigen_values_root);

encoded =  lamda_q_root * V_q';


figure
scatter(encoded(1,:),encoded(2,:),20,tt)
title 'Swiss linear kernel'
grid on


%%%%%%%%%% polynomial Kernel
%helix
clear all;
load helix.mat
rng('default')
n = 700;

H = eye(700) - 1/n .* ones(700);
c = 0; alpha = 1; r = 3;

Poly_K = (alpha .* (X' * X) + c).^r;

Poly_Gram = H * Poly_K * H;

[V D] = eig(Poly_Gram);

V_q = [V(:,1) V(:,2)];

eigen_values = [abs(D(1,1)) abs(D(2,2))];
eigen_values_root = eigen_values.^(1/2);

lamda_q_root = diag(eigen_values_root);

encoded =  lamda_q_root * V_q';


figure
scatter(encoded(1,:),encoded(2,:),20,tt)
title 'Helix poly kernel'
grid on

%%%%%%%%%%%%%%%%%%swissroll
clear all;
load swiss.mat
rng('default')
n = 700;

H = eye(700) - 1/n .* ones(700);
c = 0; alpha = 1; r = 3;

Poly_K = (alpha .* (X' * X) + c).^r;

Poly_Gram = H * Poly_K * H;

[V D] = eig(Poly_Gram);

V_q = [V(:,1) V(:,2)];

eigen_values = [abs(D(1,1)) abs(D(2,2))];
eigen_values_root = eigen_values.^(1/2);

lamda_q_root = diag(eigen_values_root);

encoded =  lamda_q_root * V_q';


figure
scatter(encoded(1,:),encoded(2,:),20,tt)
title 'swiss roll poly kernel'
grid on


%%%%%%%%%% polynomial Kernel
%helix
clear all;
load helix.mat
rng('default')
n = 700;

H = eye(700) - 1/n .* ones(700);
c = 0; alpha = 1; r = 3; sigma = 4;

for ii = 1:700
    for jj = 1:700
   
    X_normed_sq(ii,jj) = sum((X(:,ii) - X(:,jj)).^2);
    
    end
    
end

Radial_K = exp((- X_normed_sq)./(2.*sigma.^2));

Radial_Gram = H * Radial_K * H;

[V D] = eig(Radial_Gram);

V_q = [V(:,1) V(:,2)];

eigen_values = [abs(D(1,1)) abs(D(2,2))];
eigen_values_root = eigen_values.^(1/2);

lamda_q_root = diag(eigen_values_root);

encoded =  lamda_q_root * V_q';


figure
scatter(encoded(1,:),encoded(2,:),20,tt)
title 'Helix Radial basis kernel'
grid on

%%%%%%%%%% polynomial Kernel
%swissroll
clear all;
load swiss.mat
rng('default')
n = 700;

H = eye(700) - 1/n .* ones(700);
c = 0; alpha = 1; r = 3; sigma = 4;

for ii = 1:700
    for jj = 1:700
   
    X_normed_sq(ii,jj) = sum((X(:,ii) - X(:,jj)).^2);
    
    end
    
end

Radial_K = exp((- X_normed_sq)./(2.*sigma.^2));

Radial_Gram = H * Radial_K * H;

[V D] = eig(Radial_Gram);

V_q = [V(:,1) V(:,2)];

eigen_values = [abs(D(1,1)) abs(D(2,2))];
eigen_values_root = eigen_values.^(1/2);

lamda_q_root = diag(eigen_values_root);

encoded =  lamda_q_root * V_q';


figure
scatter(encoded(1,:),encoded(2,:),20,tt)
title 'Swiss Roll Radial basis kernel'
grid on

clear all

load helix.mat
    
rng('default')
n = 700;

H = eye(700) - 1/n .* ones(700);
Euclid_dist = zeros(n);

for ii = 1:700
    for jj= 1:700
     
        Euclid_dist(ii,jj) = (sum((X(:,ii) - X(:,jj)).^2));
       
    end
end

for ii = 1:700
   Sorted = sort(Euclid_dist(ii,:));
   for jj = 1:700
       if(Euclid_dist(ii,jj) > Sorted(1,10))
        Euclid_dist(ii,jj) = 0;
       end
   end
   clear Sorted
end

Euclid_dist = Euclid_dist.^(1/2);

D = dijkstra( Euclid_dist , [1:700] );

del = D.^2;

K_isomap = -(1/2) .* H * del * H ;


[V D] = eig(K_isomap);

V_q = [V(:,1) V(:,2)];

eigen_values = [abs(D(1,1)) abs(D(2,2))];
eigen_values_root = eigen_values.^(1/2);

lamda_q_root = diag(eigen_values_root);

encoded =  lamda_q_root * V_q';


figure
view([12 20])
scatter(encoded(1,:),encoded(2,:),20,tt)
title 'Helix Kiso kernel'
grid on

plotter3d = zeros(700);

for ii = 1:700
    for jj = 1:700
        
        if(Euclid_dist(ii,jj) ~= 0)
           plotter3d(ii,jj) = 1; 
        end
        
    end
end
figure
% view(3);
% scatter3(X(1,:),X(2,:),X(3,:),15,tt)
% hold on
for ii = 1:700
    for jj = 1:700
        
        if(plotter3d(ii,jj) ~= 0)
           plotX = [X(:,ii) X(:,jj)];
           plot3(plotX(1,:),plotX(2,:),plotX(3,:));
           hold on
           clear plotX
        end
        
    end
end
view([12 20]);
hold on
grid on
title 'K- nearest helix'






clear all

load swiss.mat
rng('default')

n = 700;

H = eye(700) - 1/n .* ones(700);
Euclid_dist = zeros(n);

for ii = 1:700
    for jj= 1:700
     
        Euclid_dist(ii,jj) = (sum((X(:,ii) - X(:,jj)).^2));
       
    end
end

for ii = 1:700
   Sorted = sort(Euclid_dist(ii,:));
   for jj = 1:700
       if(Euclid_dist(ii,jj) > Sorted(1,10))
        Euclid_dist(ii,jj) = 0;
       end
   end
   clear Sorted
end

Euclid_dist = Euclid_dist.^(1/2);

D = dijkstra( Euclid_dist , [1:700] );

del = D.^2;

K_isomap = -(1/2) .* H * del * H ;


[V D] = eig(K_isomap);

V_q = [V(:,1) V(:,2)];

eigen_values = [abs(D(1,1)) abs(D(2,2))];
eigen_values_root = eigen_values.^(1/2);

lamda_q_root = diag(eigen_values_root);

encoded =  lamda_q_root * V_q';


figure
scatter(encoded(1,:),encoded(2,:),35,tt)
title 'Swiss Kiso kernel'
grid on




plotter3d = zeros(700);

for ii = 1:700
    for jj = 1:700
        
        if(Euclid_dist(ii,jj) ~= 0)
           plotter3d(ii,jj) = 1; 
        end
        
    end
end
figure
% view(3);
% scatter3(X(1,:),X(2,:),X(3,:),15,tt)
% hold on
for ii = 1:700
    for jj = 1:700
        
        if(plotter3d(ii,jj) ~= 0)
           plotX = [X(:,ii) X(:,jj)];
           plot3(plotX(1,:),plotX(2,:),plotX(3,:));
           hold on
           clear plotX
        end
        
    end
end
view([12 20]);
hold on
grid on
title 'K- nearest Swiss'
