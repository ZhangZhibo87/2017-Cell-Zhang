function [T0,T1,T2,TP,Am]=WaveformProperties(data,delta,theta,phi,miniN,eta)
%%% WaveformProperties is used to calculate the waveform properties of RelA 
%%% dynamics. 
%%%
%%% Input:
%%% data is a matrix and each column represents a single-cell RelA-GFP
%%% localization trajectory;
%%% delta, theta, phi and eta are threhold parameters (see ipeaks and
%%% ipeaksNarrow);
%%% miniN determines the minimal number of detected peaks. 
%%%
%%% Output:
%%% T0, rest time, time lags between the right minimum and its following
%%% left minimum;
%%% T1, rise time, time lags between the left minimum and its following
%%% central maximum;
%%% T2, decay time, time lags between the central maximum and its following
%%% right minimum;
%%% TP, period, time lags between two successive central maximums;
%%% Am, amplitude, the difference between the Nuc.RelA signals at the
%%% central maximum and the threshold eta.

T0=[];T1=[];T2=[];TP=[];Am=[];
for i=1:size(data,2)
    [nL,nP,nR,~,~,~]=ipeaksNarrow(data(:,i),delta,theta,phi,eta);
    singlecell=smooth(data(:,i),'sgolay');
    if length(nP)>miniN
       T0=[T0,nL(2:end)-nR(1:end-1)];
       T1=[T1,nP-nL];
       T2=[T2,nR-nP];
       TP=[TP,diff(nP)];
        for j=1:length(nP)
            Am=[Am,singlecell(nP(j))-eta];
        end
    end
end
end