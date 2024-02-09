function [trainX_lstm, trainY_lstm, testX_lstm,testY_lstm,numFeatures]= prepareDataLSTM(patiente,percentage,op)

prepareDataCnn(patiente,percentage,op)

if(patiente==1)
    trainSetX=load("lstm/trainSetX.mat").trainsSetX;
    trainSetY=load("lstm/trainSetY.mat").trainsSetY;
    testSetX=load("lstm/testSetX.mat").testSetX;
    testSetY=load("lstm/testSetY.mat").testSetY;
else
    trainSetX=load("lstm/trainSetX_2.mat").trainsSetX;
    trainSetY=load("lstm/trainSetY_2.mat").trainsSetY;
    testSetX=load("lstm/testSetX_2.mat").testSetX;
    testSetY=load("lstm/testSetY_2.mat").testSetY;
end

i=1;

[~,dim]=size(trainSetY);
[numFeatures,~,~,~]=size(trainSetX);
trainX_lstm=[];
trainY_lstm=[];
while(i<dim)
    
    trainX_lstm=[trainX_lstm, trainSetX(:,:,:,i)];
    if(trainSetY(i)==1)
        j=1;
        while(j<=29)
            trainY_lstm=[trainY_lstm 1];
             j=j+1;
        end
       
    end
    if(trainSetY(i)==2)
        j=1;
        while(j<=29)
            trainY_lstm=[trainY_lstm 2];
             j=j+1;
        end
    end
    if(trainSetY(i)==3)
         j=1;
        while(j<=29)
            trainY_lstm=[trainY_lstm 3];
             j=j+1;
        end
    end
    if(trainSetY(i)==4)
         j=1;
        while(j<=29)
            trainY_lstm=[trainY_lstm 4];
            j=j+1;
        end

    end
    i=i+1;
end


i=1;

[~,dim]=size(testSetY);
[numFeatures,~,~,~]=size(trainSetX);
testX_lstm=[];
testY_lstm=[];
while(i<dim)
    
    testX_lstm=[testX_lstm, testSetX(:,:,:,i)];
    if(testSetY(i)==1)
        j=1;
        while(j<=29)
            testY_lstm=[testY_lstm 1];
             j=j+1;
        end
       
    end
    if(testSetY(i)==2)
        j=1;
        while(j<=29)
            testY_lstm=[testY_lstm 2];
             j=j+1;
        end
    end
    if(testSetY(i)==3)
         j=1;
        while(j<=29)
            testY_lstm=[testY_lstm 3];
             j=j+1;
        end
    end
    if(testSetY(i)==4)
         j=1;
        while(j<=29)
            testY_lstm=[testY_lstm 4];
            j=j+1;
        end

    end
    i=i+1;
end
if(patiente==1)
    save 'lstm/trainX_lstm.mat' trainX_lstm;
    save 'lstm/trainY_lstm.mat' trainY_lstm;
    save 'lstm/testX_lstm.mat' testX_lstm;
    save 'lstm/testY_lstm.mat' testY_lstm;
else
    save 'lstm/trainX_lstm_2.mat' trainX_lstm;
    save 'lstm/trainY_lstm_2.mat' trainY_lstm;
    save 'lstm/testX_lstm_2.mat' testX_lstm;
    save 'lstm/testY_lstm_2.mat' testY_lstm;
end
