clear;clc;
T=500; h=0.005;
X=randn(T,1);
y=X.^2+randn(T,1);
D=squareform(pdist(X));
% D=epan_kernel(D,h);
K= exp(-D/(4*h));
d=diag(sum(K,2));
L=d-K;
[U,S]=eig(L);
S=diag(S);
flt =exp(-1*S);
yf=U*(flt.*(U'*y));
coor=U(:,2:3);
G=gsp_graph(D,coor);

%% 
figure
plot(X,y,'ob');
hold on;
plot(X,yf,'.g')




function u=epan_kernel(u,b)
u=u./b;
u=max(0,3/4.*(1-u.^2));
end