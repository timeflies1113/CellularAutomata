% ��άԪ���Զ���
% 2016-4-8
% zhaoyu
% �����Ȱ��м����Ϊ1��ÿһʱ�䲽��ÿһ�㣬�����Χ
% �˸����Ϊż�������Ϊ0��Ϊ�������Ϊ 1

% ����
% 
% ������������axa������aΪ���������м����Ϊ1����������Ϊ0�����������q/2�㣬��kΪ����k=1~a/2;��������ѭ����
% 
% ����1.��k������һ�㣨Xi, Yi��,���ж���˸��ھӵ�����״̬�����Ϊ������Xi��Yi��Ϊ1������Ϊ0��
% 
% ����2.�Ե�k���У�Xi, Yi��= 1�ĵ���ɫ��
% 
% ����3.k = k + 1;���ز���1.

% ��ɫ����
Map = [1 1 1; 0 0 0];
colormap(Map);
% ���������С
S = 121;
L = zeros(S);
% ���м�һ��������Ϊ 1 ��ΪԪ������
M = (S+1)/2;
L(M, M) = 1;
Temp = L;
imagesc(L);

% �������
Layer = (S-1)/2 + 1;

for t=2:Layer
    for x=M-t+1:M+t-1
       if x==M-t+1 || x==M+t-1
           
          for y=M-t+1:M+t-1
            SUM = 0;
            for m=-1:1
               for n=-1:1
                  if x+m>0 && x+m<=S && y+n>0 && y+n<=S
                     SUM = SUM + L(x+m, y+n); 
                  end
               end
            end
            SUM = SUM - L(x, y);
            Temp(x, y) = mod(SUM, 2);
          end
          
       else
            y = M-t+1;
            SUM = 0;
            for m=-1:1
               for n=-1:1
                  if x+m>0 && x+m<=S && y+n>0 && y+n<=S
                     SUM = SUM + L(x+m, y+n); 
                  end
               end
            end
            SUM = SUM - L(x, y);
            Temp(x, y) = mod(SUM, 2);
            
            y = M+t-1;
            SUM = 0;
            for m=-1:1
               for n=-1:1
                  if x+m>0 && x+m<=S && y+n>0 && y+n<=S
                     SUM = SUM + L(x+m, y+n); 
                  end
               end
            end
            SUM = SUM - L(x, y);
            Temp(x, y) = mod(SUM, 2);
       end
    end
    L = Temp;
    imagesc(L);
    % �ٶȿ���
    pause(0.2);
end