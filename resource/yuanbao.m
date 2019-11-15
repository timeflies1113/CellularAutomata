% 二维元胞自动机
% 2016-4-8
% zhaoyu
% 规则，先把中间点置为1，每一时间步对每一点，如果周围
% 八个点和为偶数，则变为0，为奇数则变为 1

% 规则
% 
% 　　　　设有axa的网格（a为奇数），中间点设为1，其他点设为0；则此网格共有q/2层，设k为层数k=1~a/2;进行如下循环：
% 
% 　　1.设k层中任一点（Xi, Yi）,则判断其八个邻居的现有状态；其和为奇数则（Xi，Yi）为1，否则为0；
% 
% 　　2.对第k层中（Xi, Yi）= 1的点着色；
% 
% 　　3.k = k + 1;返回步骤1.

% 颜色控制
Map = [1 1 1; 0 0 0];
colormap(Map);
% 设置网格大小
S = 121;
L = zeros(S);
% 把中间一个数设置为 1 作为元胞种子
M = (S+1)/2;
L(M, M) = 1;
Temp = L;
imagesc(L);

% 计算层数
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
    % 速度控制
    pause(0.2);
end