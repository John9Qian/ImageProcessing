function Apriori(T, minSup)
 M = size(T,1);%事务数
    N = size(T,2);%属性数
    C=cell(1,N);
    STCount=sum(T)/M;%候选集的支持度
    for r=1:N
        C{r}=r;
    end
    L=C(STCount>minSup);%把count里面的>=MST的值找出来 
    LL=L;
    ICount=sum(T,2);%T矩阵的各行之和
    k=1;%频繁项集的项?
    disp(numel(L));
% Initialize Counter
    k=1;%频繁项集的项数
    B=[];
    BB=reshape(cell2mat(L),1,numel(L)); 
    % Iterations
    while ~isempty(L)%可以直接用这个isempty()函数来判空。while循环是生成频繁项集的大循环41-87行,由L{k}-->L{k+1}变化
        C={};
        %L={};
        u=0;
        for r=1:numel(L)
            for i=r:(numel(L)-1)
                x1=L{r};
                x2=L{i+1};
                if k==1
                    c=0;
                else
                    y1=x1;
                    y2=x2;
                    y1(k)=[];
                    y2(k)=[];
                    c = sum(y1==y2);%求两个候选集的交集
                end
                if  (c==k-1)%判断1.交集长度是否为1,2.判断交集c和x1前le-1相同的个数是否le-1
                    NEW=x1;
                    NEW(k+1)=x2(k);
                    sub_set=subset(NEW);%求NEW的子集
                    %生成该候选项的所有K-1项子集
                    len=length(sub_set);
                    %判断这些K-1项自己是否都为频繁的
                    p=1; n=0;
                    while(p && n<len)
                        n=n+1;%计数子集属于频繁项集的个数
                        if k==1
                            p=in(sub_set{n},BB);%in函数判断NEW子集是否属于L频繁项集
                        else
                            p=in(sub_set{n},B);%in函数判断NEW子集是否属于L频繁项集
                        end
                    end
                    if n==len%如果计数n和len相等，则其子集全部属于频繁项集
                        u=u+1;
                        %候选k项集
                        C{u}=NEW;%把这个符合条件的NEW集归于C候选集合
                    end
                else
                    break;
               end
            end
        end
        L={};
        w=0;
        for r=1:numel(C)            
            SS=zeros(N,1);
            SS(C{r})=1;          
            Sup=sum(T*SS==k+1)/M;
            if Sup > minSup
                w=w+1;
               L{w}=C{r};
            end
        end
        B=reshape(cell2mat(L),k+1,numel(L));          
        disp(numel(L));%%%%%%%%%%%%%%%%%%        
        clear C;        
        k=k+1;       
    end
end
