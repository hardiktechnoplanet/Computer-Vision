clc
clear all
%this code checks if the filter is separable or not?
%Singular Value Decomposition (SVD) is computed
A=[1 2 3; 1 2 3; 1 2 3]/18; %A is the filter
[U,S,V]=svd(A) 

%filter is separable if in the principal diagonal of S matrix only the left 
%most element is non zero
D=diag(S)
L=D(1);
T=D(2:end);
flag=0;
if (L~=0)
  if (T<1)
    flag=1; %flag =1 implies that the filter separable condition is satiesfied
  endif
endif

if (flag==1)
  %Horizontal component of the filter (h=t^(1/2)v0')
  t=S(1,1); %t is the left most diagonal element of S
  t=sqrt(t);
  v=V(:,1); %v is the first column of V
  v=v';
  horizontal_component=t*v %h is the horizontal component of the filter

  %Vertical component of the filter (v=t^(1/2)u0')
  t=S(1,1); %t is the left most diagonal element of S
  t=sqrt(t);
  u=U(:,1); %v is the first column of V
  u=u';
  vertical_component=t*u %h is the horizontal component of the filter
endif
  

