function prepareData(patiente)


if patiente ==1
    data=load('dataset/44202.mat');
else
    data= load('dataset/63502.mat');
end

%transpose
P=data.FeatVectSel';

%indices da ocorrencia das seizures
seizuresIndx=[];
seizuresIndxFinal=[];
i=1;
Trg = data.Trg;
[rows,cols]=size(Trg);
%inicio e fim das seizures
while(i <= rows)
    if(Trg(i)==1)
        seizuresIndx=[seizuresIndx,i];
        while(Trg(i)==1)
           i=i+1;
        end
        seizuresIndxFinal=[seizuresIndxFinal,i-1];

    end
    i=i+1;
end

%pre ictal, ictal, pos-ictal class
j=1;
[r,c]=size(seizuresIndx);
while(j <=c)
    idx=seizuresIndx(j);
    %pre ictal 2
    Trg(idx-900:idx-1)=2;
    while(Trg(idx)==1)
        %ictal 3
        Trg(idx)=3;
        idx=idx+1;
        
    end
    %post ictal 4
    Trg(idx:idx+300)=4;
   
    j=j+1;
end
i=1;

%(non) inter ictal
while (i<=rows)
    if (Trg(i)==0)
        Trg(i)= 1;
        
    end
    i=i+1;
end

%construir target
Target=[];
i=1;
while (i<=rows)
    if (Trg(i)==1)
       Target=[Target; [1 0 0 0]];
    end
    if (Trg(i)==2)
         Target=[Target; [0 1 0 0]];
    end
    if (Trg(i)==3)
         Target=[Target; [0 0 1 0]];
    end
    if (Trg(i)==4)
         Target=[Target; [0 0 0 1]];
    end
    i=i+1;
   
end
%colocar no estado final
Trg=Trg'
Target=Target'




if(patiente==1)
    percentage=round(rows*0.85);
    %para treinar
    trainSet_dataset=P(:,1:percentage);
    trainSet_target=Target(:,1:percentage);
    
    %para testar
    testSet_dataset=P(:,(percentage+1):end);
    testSet_target=Trg(:,(percentage+1):end);
else
    percentage=round(rows*0.85);
    %para treinar
    trainSet_dataset=P(:,1:percentage);
    trainSet_target=Target(:,1:percentage);
    
    %para testar
    testSet_dataset=P(:,(percentage+1):end);
    testSet_target=Trg(:,(percentage+1):end);

end

if(patiente ==1)

    save 'pacient1/pacient_P.mat' P
    save 'pacient1/pacient_total_final_target.mat' Target
    save 'pacient1/pacient_total_Trg.mat' Trg
    save 'pacient1/pacient_trainSet_dataset.mat' trainSet_dataset
    save 'pacient1/pacient_trainSet_target.mat' trainSet_target
    save 'pacient1/pacient_testSet_dataset.mat' testSet_dataset
    save 'pacient1/pacient_testSet_target.mat' testSet_target


else
    save 'pacient2/pacient_P.mat' P
    save 'pacient2/pacient_total_final_target.mat' Target
    save 'pacient2/pacient_total_Trg.mat' Trg
    save 'pacient2/pacient_trainSet_dataset.mat' trainSet_dataset
    save 'pacient2/pacient_trainSet_target.mat' trainSet_target
    save 'pacient2/pacient_testSet_dataset.mat' testSet_dataset
    save 'pacient2/pacient_testSet_target.mat' testSet_target

end






