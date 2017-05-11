function [L,C,R,LV,CV,RV]=ipeaks(x,delta,theta,phi)
%%% The function ipeaks is proposed to detect the notable peaks in a time
%%% series. The basic idea comes from Samuel Zambrano's 2014 PLOS ONE paper.
%%% The time series is first smoothed by savitzky-golay filter of degree 2.
%%%
%%% Input:
%%% x is the time course of the signal and it must be a vector;
%%% delta is the mininal difference between central maximum and its
%%% corresponding minimums;
%%% the central maximum must be larger than theta;
%%% the left and right minimum must be smaller than phi.
%%%
%%% Output:
%%% L,R,C are respectively the locations of left minimum,right minimum and
%%% central maximum in x;
%%% LV,RV,CV are respectively the signal strength at L, R and C.

L=[];R=[];C=[];LV=[];RV=[];CV=[];
locmin=zeros(size(x));locmax=zeros(size(x));
x=smooth(x,'sgolay');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% find the local maxmum and minmum
if x(1)<x(2)&&x(1)<phi
    locmin(1)=1;
elseif x(1)>x(2)&&x(1)>theta
        locmax(1)=1;
end
if x(end)<x(end-1)&&x(end)<phi
    locmin(end)=1;
elseif x(end)>x(end-1)&&x(end)>theta
        locmax(end)=1;
end
for i=2:length(x)-1
    if x(i)<x(i-1)&&x(i)<x(i+1)&&x(i)<phi
        locmin(i)=1;
    elseif x(i)>x(i-1)&&x(i)>x(i+1)&&x(i)>theta
           locmax(i)=1; 
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

loclim=locmin+2*locmax;
vallim=x(loclim~=0);
flag=loclim(loclim~=0); % flag=1 minimum,flag=2 maximum
indmin=find(flag==1);
indmax=find(flag==2);
if numel(indmin)==0||numel(indmax)==0
    return;
end
n1=indmin(1);
n2=n1;n3=n2;
npeak=0;


while n1<indmin(end)
    n2=n1;
    for i1=n1+1:length(flag)
        if flag(i1)==2&&(vallim(i1)-vallim(n1)>delta)
            n2=i1;
            break;
        elseif flag(i1)==1&&(vallim(i1)<vallim(n1))
                n1=i1;
        end
    end
    if n2<=n1
        break;
    end
    n3=n2;
    for i2=n2+1:length(flag)
        if flag(i2)==1&&(vallim(n2)-vallim(i2)>delta)
            n3=i2;
            break;
        elseif flag(i2)==2&&(vallim(i2)>vallim(n2))
                n2=i2;
        end
    end  
    if n3<=n2
        break;
    end
    for i3=n3+1:length(flag)
        if flag(i3)==2&&(vallim(i3)-vallim(n3)>delta)
            break;
        elseif flag(i3)==1&&(vallim(i3)<vallim(n3))
                n3=i3;
        end
    end     
    if (flag(n1)==1)&&(flag(n2)==2)&&(flag(n3)==1)
        npeak=npeak+1;
        LV(npeak)=vallim(n1);
        CV(npeak)=vallim(n2);
        RV(npeak)=vallim(n3);
        L(npeak)=find(x==LV(npeak));
        C(npeak)=find(x==CV(npeak));
        R(npeak)=find(x==RV(npeak));
        n1=n3;
    else
        while n1<indmin(end)
            n1=n1+1;
            if flag(n1)==1
                break;
            end
        end
    end
end
end
