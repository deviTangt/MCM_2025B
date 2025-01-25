clear
clc

a=[0,12,inf,inf,inf,16;12,0,10,inf,inf,7;inf,10,0,3,5,6;inf,inf,3,0,4,inf;inf,inf,5,4,0,2;16,7,6,inf,2,0];
[dist,path,distance]=dijkstra(a,1,3);

function [dist,path,Distance] = dijkstra(A,start,dest)
p = size(A,1);
S(1) = dest;          %初始化集合S，已加入到路径中的顶点编号
U = 1:p;              %初始化集合U，未加入到路径中的顶点编号
U(dest) = [];
Distance = zeros(2,p);
Distance(1,:) = 1:p;
Distance(2,1:p) = A(dest,1:p); 
new_Distance = Distance;
D = Distance;            %初始化U中所有顶点到终点dest的距离
D(:,dest) = [];          %删除U中终点编号到终点编号的距离
path = zeros(p,2);  %初始化路径
path(:,1) = 1:p;    %重赋值第一行为各顶点编号
path(Distance(2,:)~=inf,2) = dest;  %距离值不为无穷大时，将两顶点相连
path

% 寻找最短路径
while ~isempty(U)  %判断U中元素是否为空
    D
    U
    index = find(D(2,:)==min(D(2,:)),1);  %剩余顶点中距离最小值的索引
    k = D(1,index);   %发现剩余顶点中距离终点最近的顶点编号
    S = [S,k];     %将顶点k添加到S中
    U(U==k) = [];  %从U中删除顶点k  
    new_Distance(2,:) = A(k,1:p)+Distance(2,k); %计算先通过结点k，再从k到达终点的所有点距离值
    D = min(Distance,new_Distance);  %与原来的距离值比较，取最小值  
    path(D(2,:)~=Distance(2,:),2) = k;  %出现新的最小值，更改连接关系，连接到结点k上 
    Distance = D;  %更新距离表为所有点到终点的最小值
    D(:,S) = [];   %删除已加入到S中的顶点
end
dist = Distance(start,2);  %取出指定起点到终点的距离值
fprintf('找到的最短路径为：');
while start ~= dest    %到达终点时结束
    fprintf('%d-->',start);  %打印当前点编号
    next = path(start,2);    %与当前点相连的下一顶点
    start = next;            %更新当前点
end
fprintf('%d\n',dest);
fprintf('最短路径对应的距离为：%d\n',dist);
end