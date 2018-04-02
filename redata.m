
%载入源数据
load xlsdata;
for i = 1:length(ID)
    RD{i,1}=ID(i); RD{i,4}=age(i); RD{i,5}=sex(i); RD{i,6}=c_sno(i);
    RD{i,7}=c_name(i);
end

%建立索引
[m n] = size(RD);
Index = zeros(RD{m,1}-304000,2);
row = 1;
Index(RD{1,1}-304000,1 )= row;
Index(RD{1,1}-304000,2 )= 1;

for i = 1:m
    if Index(RD{i,1}-304000,1)==0
        row = row + 1;
        Index(RD{i,1}-304000,1) = row;
        Index(RD{i,1}-304000,2) = i;
    end
end

%填入ID、性别、年龄数据
for i = 1:length(Index)
    if Index(i,1) ~= 0
    D(Index(i,1),1)=i+304000;
    D(Index(i,1),4)=RD{Index(i,2),4};
    D(Index(i,1),5)=RD{Index(i,2),5};
    end
end
%填入病症数据
D = num2cell(D);
[md nd]= size(D);
D2 = zeros(md,10);
D2 = num2cell(D2);
D = [D D2];
for i = 1:m
    if Index(RD{i,1}-304000)~= 0;
    if ~isnan(RD{i,6}+5)
    D{Index(RD{i,1}-304000,1),RD{i,6}+5}=RD{i,7};
    end
    end
end
%填入日期数据
load dateinfo
[ms ns] = size(S3);
for i = 1:md
    id = D{i,1};
    for a = 1:ns-1
        for b = 1:ms-a
            if id<=S3(14-b,7-a)
                D{i,2}=S3(1,7-a);
                D{i,3}=S3(14-b,1);
            end
        end
    end
end
save data D