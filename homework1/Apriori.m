function Apriori(T, minSup)
 M = size(T,1);%������
    N = size(T,2);%������
    C=cell(1,N);
    STCount=sum(T)/M;%��ѡ����֧�ֶ�
    for r=1:N
        C{r}=r;
    end
    L=C(STCount>minSup);%��count�����>=MST��ֵ�ҳ��� 
    LL=L;
    ICount=sum(T,2);%T����ĸ���֮��
    k=1;%Ƶ�������?
    disp(numel(L));
% Initialize Counter
    k=1;%Ƶ���������
    B=[];
    BB=reshape(cell2mat(L),1,numel(L)); 
    % Iterations
    while ~isempty(L)%����ֱ�������isempty()�������пա�whileѭ��������Ƶ����Ĵ�ѭ��41-87��,��L{k}-->L{k+1}�仯
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
                    c = sum(y1==y2);%��������ѡ���Ľ���
                end
                if  (c==k-1)%�ж�1.���������Ƿ�Ϊ1,2.�жϽ���c��x1ǰle-1��ͬ�ĸ����Ƿ�le-1
                    NEW=x1;
                    NEW(k+1)=x2(k);
                    sub_set=subset(NEW);%��NEW���Ӽ�
                    %���ɸú�ѡ�������K-1���Ӽ�
                    len=length(sub_set);
                    %�ж���ЩK-1���Լ��Ƿ�ΪƵ����
                    p=1; n=0;
                    while(p && n<len)
                        n=n+1;%�����Ӽ�����Ƶ����ĸ���
                        if k==1
                            p=in(sub_set{n},BB);%in�����ж�NEW�Ӽ��Ƿ�����LƵ���
                        else
                            p=in(sub_set{n},B);%in�����ж�NEW�Ӽ��Ƿ�����LƵ���
                        end
                    end
                    if n==len%�������n��len��ȣ������Ӽ�ȫ������Ƶ���
                        u=u+1;
                        %��ѡk�
                        C{u}=NEW;%���������������NEW������C��ѡ����
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
