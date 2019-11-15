% 此程序为有干预时舆情传播的matlab程序

% B矩阵为3维矩阵，B(i,j,k),其中k表示迭代次数，k=1为初始感染情况，k最大值为迭代次数+1
% Blength:某时刻感染者数目（数值为B矩阵中每次迭代中的等于1的数目）

clf;clear;clc

%参数
n = 20001; % 迭代次数1000、3000、5000、7000、9000
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
A = zeros(102,102);
B = zeros(102,102,n+1);
a = randsrc(100,100,[0 1;1-P1 P1]);
A(2:101,2:101) = a;
B(:,:,1) = A;
for t=1:n
    
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
plot(Blength(1:20001)) % 迭代次数的曲线图，可以修改20001（次数）
title('迭代曲线')

figure
imshow(~B(:,:,1)) % 初始化的感染者
title('初始化的感染者')
figure
imshow(~B(:,:,1001)) % 黑色感染，第1000次迭代后的结果
title('1000次迭代后的结果')
figure
imshow(~B(:,:,3001)) % 黑色感染，第3000次迭代后的结果
title('3000次迭代后的结果')
figure
imshow(~B(:,:,5001)) % 黑色感染，第5000次迭代后的结果
title('5000次迭代后的结果')
figure
imshow(~B(:,:,7001)) % 黑色感染，第7000次迭代后的结果
title('7000次迭代后的结果')
figure
imshow(~B(:,:,9001)) % 黑色感染，第9000次迭代后的结果
title('9000次迭代后的结果')

% % 动态图
% figure
% for k=1:n+1
%     imshow(~B(:,:,k))
%     pause(0.001)
% end