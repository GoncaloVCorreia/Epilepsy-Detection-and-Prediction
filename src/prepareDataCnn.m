function[]= prepareDataCnn(patiente,percentage,op)
%op = 1 -> CNN, op=2 -> LSTM
if(patiente ==1)
    data=load("pacient1/pacient_P.mat");
    trg=load("pacient1/pacient_total_Trg.mat");
    target=load("pacient1/pacient_total_final_target.mat");
else
    data=load("pacient2/pacient_P.mat");
    trg=load("pacient2/pacient_total_Trg.mat");
    target=load("pacient2/pacient_total_final_target.mat");
end

 target=target.Target;
 data=data.P;
 trg=trg.Trg;
 size=length(data);
%separar classes
 classinterictal=[];
 classpreictal=[];
 classictal=[];
 classposictal=[];
 i=1
 while(i<=size)
     if(trg(i)==1)
         classinterictal=[classinterictal, data(:,i) ];
     end
     if(trg(i)==2)
         classpreictal=[classpreictal, data(:,i) ];
     end
     if(trg(i)==3)
         classictal=[classictal, data(:,i) ];
     end
     if(trg(i)==4)
         classposictal=[classposictal, data(:,i) ];
     end
     i=i+1;
 end
%retirar numero de imagens para cada classe
 numberOfImagesInter=round(length(classinterictal)/29);
 numberOfImagesPre=round(length(classpreictal)/29);
 numberOfImagesIctal=round(length(classictal)/29);
 numberOfImagesPos=round(length(classposictal)/29);

sizeTrain=round(numberOfImagesIctal*percentage);
%inicializar matriz
trainsSetX=[];
trainsSetY=[]

 i=1;
 %CNN
 if(op==1)
     if(patiente ==1)
        treshold=20;
        interPlus=50;
     else
        treshold=-5;
        interPlus=0;
     end
 %LSTM
 else
     if(patiente==1)
        treshold=-15;
        interPlus=-10;
     else
        treshold=0;
        interPlus=0;
     end
 end

 
 preIctalPoints=0;
 ictalPoints=0;
 posIctalPoints=0;
 interIctalPoints=0;

 %para treino
   i=1;
 while(i<=sizeTrain+treshold+interPlus)
     trainsSetX=cat(4,trainsSetX,classinterictal(:,1+29*(i-1):1+29*(i-1)+28));
     trainsSetY=cat(2,trainsSetY,[1]);
     interIctalPoints=interIctalPoints+29;
    i=i+1;
 end
  i=1;
 while(i<=sizeTrain+treshold)
     trainsSetX=cat(4,trainsSetX,classpreictal(:,1+29*(i-1):1+29*(i-1)+28));
     trainsSetY=cat(2,trainsSetY,[2]);
     preIctalPoints=preIctalPoints+29;
     i=i+1;
 end
  i=1;
 while(i<=sizeTrain)
     trainsSetX=cat(4,trainsSetX,classictal(:,1+29*(i-1):1+29*(i-1)+28));
     trainsSetY=cat(2,trainsSetY,[3]);
      ictalPoints=ictalPoints+29;
     i=i+1;
 end
  i=1;
 while(i<=sizeTrain+treshold)
     trainsSetX=cat(4,trainsSetX,classposictal(:,1+29*(i-1):1+29*(i-1)+28));
     trainsSetY=cat(2,trainsSetY,[4]);
     posIctalPoints=posIctalPoints+29;
     i=i+1;
 end

  length(trainsSetX);
  
 preIctalPoints2=0;
 ictalPoints2=0;
 posIctalPoints2=0;
 interIctalPoints2=0;
  %para teste
  testSetX=[];
  testSetY=[];

  i=sizeTrain+1+treshold+interPlus;
 while(i<numberOfImagesIctal+treshold+interPlus)
    testSetX=cat(4,testSetX,classinterictal(:,1+29*(i-1):1+29*(i-1)+28));
    testSetY=cat(2,testSetY,[1]);
    interIctalPoints2=interIctalPoints2+29;
    i=i+1;
 end

  i=sizeTrain+1+treshold;
 while(i<numberOfImagesIctal+treshold)
     testSetX=cat(4,testSetX,classpreictal(:,1+29*(i-1):1+29*(i-1)+28));
     testSetY=cat(2,testSetY,[2]);
      preIctalPoints2=preIctalPoints2+29;
     i=i+1;
 end
  i=sizeTrain+1;
 while(i<numberOfImagesIctal)
    a=1+29*(i-1);
    b=1+29*(i-1)+28;
    testSetX=cat(4,testSetX,classictal(:,1+29*(i-1):1+29*(i-1)+28));
    testSetY=cat(2,testSetY,[3]);
    ictalPoints2=ictalPoints2+29;
    i=i+1;
 end
  i=sizeTrain+1+treshold;
 while(i<numberOfImagesIctal+treshold)
     testSetX=cat(4,testSetX,classposictal(:,1+29*(i-1):1+29*(i-1)+28));
     testSetY=cat(2,testSetY,[4]);
     posIctalPoints2=posIctalPoints2+29;
     i=i+1;
 end
 length(testSetX)
disp("TREINO")
preIctalPoints
ictalPoints
posIctalPoints
interIctalPoints
disp("TESTE")
preIctalPoints2
ictalPoints2
posIctalPoints2
interIctalPoints2

if(op==1)
    if(patiente==1)
        save 'cnn/trainSetX.mat' trainsSetX;
        save 'cnn/testSetX.mat' testSetX;
        save 'cnn/trainSetY.mat' trainsSetY;
        save 'cnn/testSetY.mat' testSetY;
    else
        save 'cnn/trainSetX_2.mat' trainsSetX;
        save 'cnn/testSetX_2.mat' testSetX;
        save 'cnn/trainSetY_2.mat' trainsSetY;
        save 'cnn/testSetY_2.mat' testSetY;
    end

else
    if(patiente==1)
        save 'lstm/trainSetX.mat' trainsSetX;
        save 'lstm/testSetX.mat' testSetX;
        save 'lstm/trainSetY.mat' trainsSetY;
        save 'lstm/testSetY.mat' testSetY;
    else
        save 'lstm/trainSetX_2.mat' trainsSetX;
        save 'lstm/testSetX_2.mat' testSetX;
        save 'lstm/trainSetY_2.mat' trainsSetY;
        save 'lstm/testSetY_2.mat' testSetY;
    end

end



