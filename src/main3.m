clf;clear;clc
load('main1.mat');

%����
n = 10001; % ��������
Alpha = zeros(102,102);
Eta = zeros(102,102);
alpha = 0.04 * rand(100,100); % �������������������޸ģ�
eta = 0.04 + 1.2 * rand(100,100); %�����������������޸ģ�
Alpha(2:101,2:101) = alpha;
Eta(2:101,2:101) = eta;
P = 0.0006; % δ��Ԥ�����µ�δ��Ⱦ��ת��Ϊ��Ⱦ�ߵĸ���
P1 = 0.0004; % ��Ԥ�����µ�δ��Ⱦ��ת��Ϊ��Ⱦ�ߵĸ���
Pd = 0.0008; % Pd

% ����Ԫ�����󲢳�ʼ��(1Ϊ��Ⱦ��0Ϊδ��Ⱦ)
num = 1000; % �ӵڼ��ο�ʼ���и�Ԥ
A = B;
B = zeros(102,102,n+1);
B(:,:,1:num) = A(:,:,1:num);
for t=num:n
    
    % ��һ������
    for i=2:101
        for j=2:101
            if B(i,j,t)==0 & P1>=rand(1)
                B(i,j,t+1)=1;
            end
        end
    end

    
    % �ڶ�������
    for i=2:101
        for j=2:101
            sum = Alpha(i-1,j-1)*B(i-1,j-1,t)+Alpha(i-1,j)*B(i-1,j,t)+Alpha(i-1,j+1)*B(i-1,j+1,t)+Alpha(i,j+1)*B(i,j+1,t)+Alpha(i+1,j+1)*B(i+1,j+1,t)+Alpha(i+1,j)*B(i+1,j,t)+Alpha(i+1,j-1)*B(i+1,j-1,t)+Alpha(i,j-1)*B(i,j-1,t);
            if B(i,j,t)==0 & sum>=Eta(i,j)
                B(i,j,t+1)=1;
            end
        end
    end
    
    % ��������������
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

% ��ͼ
figure
plot(Blength(1:n)) % ��������������ͼ�������޸�20001��������
title('��������')