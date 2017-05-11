function [nL,nC,nR,nLV,nCV,nRV]=ipeaksNarrow(x,delta,theta,phi,eta)
%%% The function ipeaksNarrow is proposed to find peaks with left and right
%%% minimums which seem to be more rational. It will first call ipeaks to 
%%% determine the central maximums. Then, from each central maximum£¬it
%%% will search around to find the corresponding left or right minimum
%%% which is the first point that is smaller than the threshold eta.
%%%
%%% Input:
%%% x is the time course of the signal and it must be a vector;
%%% delta, theta and phi are threhold parameters (see ipeaks);
%%% eta is the amplitude threshold for re-detecting left and right minimums.
%%%
%%% Output:
%%% nL,nR,nC are respectively the locations of left minimum,right minimum
%%% and central maximum in x;
%%% nLV,nRV,nCV are respectively the signal strength at L, R and C.

singlecell=smooth(x,'sgolay');
[L,C,R,LV,CV,RV]=ipeaks(x,delta,theta,phi);
nL=zeros(size(L));nR=zeros(size(R));nC=C;
nLV=zeros(size(LV));nRV=zeros(size(RV));nCV=CV;
if ~isempty(C)
    for i=1:length(C)
        iL=0;
        while singlecell(C(i)-iL-1)>=eta
            iL=iL+1;
            if C(i)-iL-1==0
                break
            end
        end
        nL(i)=max(C(i)-iL-1,1);nLV(i)=singlecell(nL(i));
        iR=0;
        while singlecell(C(i)+iR+1)>=eta
            iR=iR+1;
            if C(i)+iR+1==length(x)+1
                break
            end
        end
        nR(i)=min(C(i)+iR+1,length(x));nRV(i)=singlecell(nR(i));        
    end
end