data1 = [latitude longitude];
W = exp(-(((squareform(pdist(data1))).^2)./(2*(0.01).^2)));
D = diag(sum(W,2));
L = D - W;

L_sym = D^-1/2 * L * D^-1/2;

rng(2);

for k = 1:25
idx{k} = kmeans(data1,k);
end


 U = unique(neighbourhood);
 
 for i = 1: 2558
     for j = 1:25
        test = strcmp(neighbourhood{i,1},U{j});
        if test ==1
            labels(i,1) = j; 
        end
     end
 end
 
for k = 1:25
A = confusionmat(labels,idx{k});
purity(k,1) = sum(max(A,[],2))./sum(sum(A));
end

plot(1:25,purity) 
title 'K vs purity'; xlabel 'K'
ylabel 'purity'

figure
plot(data1(idx{5}==1,2),data1(idx{5}==1,1),'r.','MarkerSize',12)
hold on
plot(data1(idx{5}==2,2),data1(idx{5}==2,1),'b.','MarkerSize',12)
hold on
plot(data1(idx{5}==3,2),data1(idx{5}==3,1),'g.','MarkerSize',12)
hold on
plot(data1(idx{5}==4,2),data1(idx{5}==4,1),'k.','MarkerSize',12)
hold on
plot(data1(idx{5}==5,2),data1(idx{5}==5,1),'y.','MarkerSize',12)
hold on
plot_google_map
