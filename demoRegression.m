clear;clc;
T=500; h=0.5;
X=randn(T,1);
y=X.^2+randn(T,1);
D=squareform(pdist(X));
% D=epan_kernel(D,h);
 K= exp(-D/(4*sigma));
    p = sum(K, 1)';
    K = K ./ ((p * p') .^ alpha);
    v = sqrt(sum(K, 1))';
    K = K ./ (v * v');
d=sum(D,2);
L=diag(d)-D;
[U,S]=eig(L);
S=diag(S);
flt =exp(-10*S);
yf=U*(flt.*(U'*y));
coor=U(:,2:3);
G=gsp_graph(D,coor);

%% 
figure;
gsp_plot_signal(G,y)
title('Input signal');
figure;
gsp_plot_signal(G,yf)
title('Filtered signal');

figure
plot(X,y,'ob');
hold on;
plot(X,yf,'.g')




function u=epan_kernel(u,b)
u=u./b;
u=max(0,3/4.*(1-u.^2));
end