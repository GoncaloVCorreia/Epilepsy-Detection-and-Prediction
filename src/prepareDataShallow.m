function[newDataX, newDataY,newTrg] = prepareDataShallow(patiente,op)
%treinar
if(op==0)
    if(patiente==1)
        trainX=load("pacient1/pacient_trainSet_dataset.mat").trainSet_dataset;
        trainY=load("pacient1/pacient_trainSet_target.mat").trainSet_target;
    else
        trainX=load("pacient2/pacient_trainSet_dataset.mat").trainSet_dataset;
        trainY=load("pacient2/pacient_trainSet_target.mat").trainSet_target;

    end

    disp("TRAIN")
    trg=revertTarget(trainY);
%testar
else
    if(patiente==1)
        trainX=load("pacient1/pacient_testSet_dataset.mat");
        trainY=load("pacient1/pacient_testSet_target.mat");
    else
        trainX=load("pacient2/pacient_testSet_dataset.mat");
        trainY=load("pacient2/pacient_testSet_target.mat");
    end

    trainY=trainY.testSet_target;
    trainX=trainX.testSet_dataset;


    trg=trainY;
    disp("Test")

end

%separar classes
 classinterictal=[];
 classpreictal=[];
 classictal=[];
 classposictal=[];
 i=1;
 [~,sizee]=size(trainX);
 interIctalPoints=0;
 preIctalPoints=0;
 ictalPoints=0;
 posIctalPoints=0;
 
 while(i<=sizee)
     if(trg(i)==1)
         classinterictal=[classinterictal, trainX(:,i) ];
     end
     if(trg(i)==2)
         classpreictal=[classpreictal, trainX(:,i) ];
        
     end
     if(trg(i)==3)
         classictal=[classictal, trainX(:,i) ];
 
     end
     if(trg(i)==4)
         classposictal=[classposictal, trainX(:,i) ];

     end
     i=i+1;
 end

 numberOfIctal=round(length(classictal));

 newDataX=[];
 newDataY=[];
 newTrg=[];
 if(op==0)
     if(patiente==1)
        treshold=2000;
        tresholdInter=20000;
     else
        treshold=2000;
        tresholdInter=20000;
     end

 else
     treshold=0;
     tresholdInter=0;
 end
 i=1;
 while(i<=numberOfIctal+treshold+ tresholdInter)
     newDataX=[newDataX classinterictal(:,i)];
     newDataY=[newDataY ; [1 0 0 0]];
     newTrg=[newTrg 1];
     i=i+1;
     interIctalPoints=interIctalPoints+1;
 end
 i=1;
 while(i<=numberOfIctal++treshold)
     newDataX=[newDataX classpreictal(:,i)];
     newDataY=[newDataY ; [0 1 0 0] ];
     newTrg=[newTrg 2];
     i=i+1;
      preIctalPoints=preIctalPoints+1;
 end
  i=1;
 while(i<=numberOfIctal)
     newDataX=[newDataX classictal(:,i)];
     newDataY=[newDataY ; [0 0 1 0]];
     newTrg=[newTrg 3];
     i=i+1;
     ictalPoints=ictalPoints+1;
 end
  i=1;
 while(i<=numberOfIctal+treshold)
     newDataX=[newDataX classposictal(:,i)];
     newDataY=[newDataY ; [0 0 0 1]];
     newTrg=[newTrg 4];
     i=i+1;
      posIctalPoints=posIctalPoints+1;
 end
 interIctalPoints
 preIctalPoints
ictalPoints
posIctalPoints

