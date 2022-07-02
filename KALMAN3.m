% Kalman filter example of temperature measurement in Matlab
% This M code is modified from Xuchen Yao's matlab on 2013/4/18
%房间当前温度真实值为24度，认为下一时刻与当前时刻温度相同，误差为0.02度（即认为连续的两个时刻最多变化0.02度）。
%温度计的测量误差为0.5度。
%开始时，房间温度的估计为23.5度，误差为1度。
% Kalman filter example demo in Matlab
% This M code is modified from Andrew D. Straw's Python
% implementation of Kalman filter algorithm.
% The original code is from the link in references [2] 
% Below is the Python version's comments:
% Kalman filter example demo in Python
% A Python implementation of the example given in pages 11-15 of "An
% Introduction to the Kalman Filter" by Greg Welch and Gary Bishop,
% University of North Carolina at Chapel Hill, Department of Computer
% Science, TR 95-041,
[3]  % by Andrew D. Straw
% by Xuchen Yao
% by Lin Wu
clear all;
close all;
% intial parameters
n_iter = 100; %计算连续n_iter个时刻
sz = [n_iter, 1]; % size of array. n_iter行，1列
x = 24; % 温度的真实值
Q = 4e-4; % 过程方差， 反应连续两个时刻温度方差。更改查看效果
R = 0.25; % 测量方差，反应温度计的测量精度。更改查看效果
z = x + sqrt(R)*randn(sz); % z是温度计的测量结果，在真实值的基础上加上了方差为0.25的高斯噪声。
% 对数组进行初始化
xhat=zeros(sz); % 对温度的后验估计。即在k时刻，结合温度计当前测量值与k-1时刻先验估计，得到的最终估计值
P=zeros(sz); % 后验估计的方差
xhatminus=zeros(sz); % 温度的先验估计。即在k-1时刻，对k时刻温度做出的估计
Pminus=zeros(sz); % 先验估计的方差
K=zeros(sz); % 卡尔曼增益，反应了温度计测量结果与过程模型（即当前时刻与下一时刻温度相同这一模型）的可信程度
% intial guesses
xhat(1) = 23.5; %温度初始估计值为23.5度
P(1) =1; %误差方差为1
for k = 2:n_iter
% 时间更新（预测）
xhatminus(k) = xhat(k-1); %用上一时刻的最优估计值来作为对当前时刻的温度的预测
Pminus(k) = P(k-1)+Q; %预测的方差为上一时刻温度最优估计值的方差与过程方差之和
% 测量更新（校正）
K(k) = Pminus(k)/( Pminus(k)+R ); %计算卡尔曼增益
xhat(k) = xhatminus(k)+K(k)*(z(k)-xhatminus(k)); %结合当前时刻温度计的测量值，对上一时刻的预测进行校正，得到校正后的最优估计。该估计具有最小均方差
P(k) = (1-K(k))*Pminus(k); %计算最终估计值的方差
end
FontSize=14;
LineWidth=3;
figure();
% 估计的误差的方差
% 估计的误差的方差
plot(z,'k+'); %画出温度计的测量值
hold on;
plot(xhat,'b-','LineWidth',LineWidth) %画出最优估计值
hold on;
plot(x*ones(sz),'g-','LineWidth',LineWidth); %画出真实值
legend('温度计的测量结果', '后验估计', '真实值');
xl=xlabel('时间(分钟)');
yl=ylabel('温度');
set(xl,'fontsize',FontSize);
set(yl,'fontsize',FontSize);
hold off;
set(gca,'FontSize',FontSize);
figure();
valid_iter = [2:n_iter]; % Pminus not valid at step 1
plot(valid_iter,P([valid_iter]),'LineWidth',LineWidth); %画出最优估计值的方差
legend('后验估计的误差估计');
xl=xlabel('时间(分钟)');
yl=ylabel('℃^2');
set(xl,'fontsize',FontSize);
set(yl,'fontsize',FontSize);
set(gca,'FontSize',FontSize);