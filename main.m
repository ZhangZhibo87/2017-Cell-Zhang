clear;
clc;

%% load sample data %%
% "single_cell_trajectories" contains 60 single-cell Nuc.RelA data(see 
% Figure S3)
% "time" is the time point from 0 to 600 min and the interval is 5 min 
load('sample_data.mat');

%% parameters %%
delta=0.8;
theta=2;
phi=2;
miniN=2;
eta=2.3;

%% plot detected peaks %%
% upper triangle: central maximum
% left triangle: left minimum
% right triangle: right minimum
cell_num=size(single_cell_trajectories,2);
subplot_c=10;
subplot_r=ceil(cell_num/subplot_c);
figure(1);
suptitle('Detected Peaks');
for i=1:cell_num
    [L,C,P,LV,CV,PV]=ipeaksNarrow(single_cell_trajectories(:,i),delta,...
        theta,phi,eta);
    subplot(subplot_r,subplot_c,i)
    smooth_single_cell=smooth(single_cell_trajectories(:,i),'sgolay');
    plot(time,smooth_single_cell,time(L),LV,'<',time(C),CV,'^',time(P),PV,'>')
    axis([time(1),time(end),1.5,7.5]);
end
subplot(subplot_r,subplot_c,(subplot_r-1)*subplot_c+1);
hold on;
xlabel('time(min)');ylabel('Nuc.RelA');

%% waveform properties %%
[T0,T1,T2,TP,Am]=WaveformProperties(single_cell_trajectories,delta,theta,phi,miniN,eta);
figure(2);
suptitle('Waveform Properties')
subplot(1,5,1);
hist(T0*5);
xlabel('T0(min)');ylabel('count');
subplot(1,5,2);
hist(T1*5);
xlabel('T1(min)');ylabel('count');
subplot(1,5,3);
hist(T2*5);
xlabel('T2(min)');ylabel('count');
subplot(1,5,4);
hist(TP*5);
xlabel('Period(min)');ylabel('count');
subplot(1,5,5);
hist(Am);
xlabel('Amplitude(a.u.)');ylabel('count');



