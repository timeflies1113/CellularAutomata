% �˳���Ϊ�޸�Ԥʱ���鴫����matlab����

% B����Ϊ3ά����B(i,j,k),����k��ʾ����������k=1Ϊ��ʼ��Ⱦ�����k���ֵΪ��������+1
% Blength:ĳʱ�̸�Ⱦ����Ŀ����ֵΪB������ÿ�ε����еĵ���1����Ŀ��

clf;clear;clc

%����
n = 9000; % ��������50/100/500/1000/5000
Alpha = zeros(102,102);
Eta = zeros(102,102);
alpha = 0.06 * rand(100,100); % �������������������޸ģ�
eta = 0.04 + rand(100,100); %�����������������޸ģ�
Alpha(2:101,2:101) = alpha;
Eta(2:101,2:101) = eta;
P = 0.0006; % δ��Ԥ�����µ�δ��Ⱦ��ת��Ϊ��Ⱦ�ߵĸ���

% ����Ԫ�����󲢳�ʼ��(1Ϊ��Ⱦ��0Ϊδ��Ⱦ)
A = zeros(102,102);
B = zeros(102,102,n+1);
a = randsrc(100,100,[0 1;1-P P]);
A(2:101,2:101) = a;
B(:,:,1) = A;
for t=1:n
    
    % ��һ������
    for i=2:101
        for j=2:101
            if B(i,j,t)==1
                B(i,j,t+1)=1;
            end
        end
    end
    
    % �ڶ�������
    for i=2:101
        for j=2:101
            sum = Alpha(i-1,j-1)*B(i-1,j-1,t)+Alpha(i-1,j)*B(i-1,j,t)+Alpha(i-1,j+1)*B(i-1,j+1,t)+Alpha(i,j+1)*B(i,j+1,t)+Alpha(i+1,j+1)*B(i+1,j+1,t)+Alpha(i+1,j)*B(i+1,j,t)+Alpha(i+1,j-1)*B(i+1,j-1,t)+Alpha(i,j-1)*B(i,j-1,t);
            if sum>=Eta(i,j)
                B(i,j,t+1)=1;
            end
        end
    end
    
    % ����������
    for i=2:101
        for j=2:101
            if B(i,j,t)==0 & P>=rand(1)
                B(i,j,t+1)=1;
            end
        end
    end
end

B1 = B(2:101,2:101,:);
for k=1:n+1
    Blength(k) = length(find(B1(:,:,k)==1));
end

% ��ͼ
figure
plot(Blength(1:9001))
title('��������')

figure
imshow(~B(:,:,1)) % ��ʼ���ĸ�Ⱦ��
title('��ʼ���ĸ�Ⱦ��')
figure
imshow(~B(:,:,101)) % ��ɫ��Ⱦ����100�ε�����Ľ��
title('100�ε�����Ľ��')
figure
imshow(~B(:,:,501)) % ��ɫ��Ⱦ����500�ε�����Ľ��
title('500�ε�����Ľ��')
figure
imshow(~B(:,:,1001)) % ��ɫ��Ⱦ����1000�ε�����Ľ��
title('1000�ε�����Ľ��')
figure
imshow(~B(:,:,5001)) % ��ɫ��Ⱦ����5000�ε�����Ľ��
title('5000�ε�����Ľ��')
figure
imshow(~B(:,:,9001)) % ��ɫ��Ⱦ����9000�ε�����Ľ��
title('9000�ε�����Ľ��')