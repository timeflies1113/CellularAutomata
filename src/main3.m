clf;clear;clc
load('main1.mat');

%参数
n = 10001; % 迭代次数
Alpha = zeros(102,102);
Eta = zeros(102,102);
alpha = 0.04 * rand(100,100); % 参数阿尔法（可自行修改）
eta = 0.04 + 1.2 * rand(100,100); %参数依塔（可自行修改）
Alpha(2:101,2:101) = alpha;
Eta(2:101,2:101) = eta;
P = 0.0006; % 未干预条件下的未感染者转变为感染者的概率
P1 = 0.0004; % 干预条件下的未感染者转变为感染者的概率
Pd = 0.0008; % Pd

% 构造元胞矩阵并初始化(1为感染，0为未感染)
num = 1000; % 从第几次开始进行干预
A = B;
B = zeros(102,102,n+1);
B(:,:,1:num) = A(:,:,1:num);
for t=num:n
    
    % 第一条规则
    for i=2:101
        for j=2:101
            if B(i,j,t)==0 & P1>=rand(1)
                B(i,j,t+1)=1;
            end
        end
    end

    
    % 第二条规则
    for i=2:101
        for j=2:101
            sum = Alpha(i-1,j-1)*B(i-1,j-1,t)+Alpha(i-1,j)*B(i-1,j,t)+Alpha(i-1,j+1)*B(i-1,j+1,t)+Alpha(i,j+1)*B(i,j+1,t)+Alpha(i+1,j+1)*B(i+1,j+1,t)+Alpha(i+1,j)*B(i+1,j,t)+Alpha(i+1,j-1)*B(i+1,j-1,t)+Alpha(i,j-1)*B(i,j-1,t);
            if B(i,j,t)==0 & sum>=Eta(i,j)
                B(i,j,t+1)=1;
            end
        end
    end
    
    % 第三、四条规则
    for i=2:101
        for j=2:101
            if B(i,j,t)==1 
                if Pd>=rand(1)
                    B(i,j,t+1)=0;
                else
                    B(i,j,t+1)=1;
                end
            end
        end
    end
end

B = B(2:101,2:101,:);
for k=1:n+1
    Blength(k) = length(find(B(:,:,k)==1));
end

% 作图
figure
plot(Blength(1:n)) % 迭代次数的曲线图，可以修改20001（次数）
title('迭代曲线')