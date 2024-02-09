patiente=2;
if(patiente==1)
    X=load("lstm/trainX_lstm.mat").trainX_lstm;
    Y=load("lstm/trainY_lstm.mat").trainY_lstm;
else
    X=load("lstm/trainX_lstm_2.mat").trainX_lstm;
    Y=load("lstm/trainY_lstm_2.mat").trainY_lstm;
end

autoenc=trainAutoencoder(X,10,'MaxEpochs',1000,'DecoderTransferFunction','purelin');

newX=encode(autoenc,X);

trainX_lstm=num2cell(newX,1);
trainY_lstm=categorical(Y);

numHiddenUnits=100;
numClasses=4;
[numFeatures,~]=size(newX);

layers=[
    sequenceInputLayer(numFeatures)
    lstmLayer(numHiddenUnits,'OutputMode','last')
    fullyConnectedLayer(numClasses)
    softmaxLayer
    classificationLayer
    ]

    maxEpc=100;
    
options = trainingOptions('adam', ...
    'MaxEpochs',maxEpc, ...
    'GradientThreshold',1, ...
    'Plots','training-progress', ...
    'MiniBatchSize',100, ...
    'InitialLearnRate',0.1, ...
    'Verbose',0, ...
    'ExecutionEnvironment','cpu');

net=trainNetwork(trainX_lstm,trainY_lstm,layers,options);

%-------------------------TESTAR-------------------------------
if(patiente==1)
 testX_lstm=load("lstm/testX_lstm.mat").testX_lstm;
 testY_lstm=load("lstm/testY_lstm.mat").testY_lstm;
else
  testX_lstm=load("lstm/testX_lstm_2.mat").testX_lstm;
 testY_lstm=load("lstm/testY_lstm_2.mat").testY_lstm;
end

 testX_lstm=encode(autoenc,testX_lstm);
 testX_lstm=num2cell(testX_lstm,1);

 YPred =  double(string(classify(net,testX_lstm)))';


tn=0;
tp=0;
fn=0;
fp=0;
i=1;
correct=0;

    disp("DETETAR")
    while(i<=length(testY_lstm))
        if(testY_lstm(i)==3 && YPred(i)==3)
            tp=tp+1;
        end
        if(testY_lstm(i)~=3 && YPred(i)==3)
            fp=fp+1;
        end
        if(testY_lstm(i)==3 && YPred(i)~=3)
            fn=fn+1;
        end
        if(testY_lstm(i)~=3 && YPred(i)~=3)
            tn=tn+1;
        end
        if(testY_lstm(i)==YPred(i))
            correct=correct+1;
        end
        i=i+1;
    end
    tn2=0;
    tp2=0;
    fn2=0;
    fp2=0;
    i=1;
    correct2=0;
   
    while(i<=length(testY_lstm))
        if(testY_lstm(i)==2 && YPred(i)==2)
            tp2=tp2+1;
        end
        if(testY_lstm(i)~=2 && YPred(i)==2)
            fp2=fp2+1;
        end
        if(testY_lstm(i)==2 && YPred(i)~=2)
            fn2=fn2+1;
        end
        if(testY_lstm(i)~=2 && YPred(i)~=2)
            tn2=tn2+1;
        end
        if(testY_lstm(i)==YPred(i))
            correct2=correct2+1;
        end
        i=i+1;
    
    end

tn
tp
fn
fp
sensitivity= tp/(tp+fn)
specificity= tn/(tn+fp)
accuracy = correct/length(testY_lstm)
disp("PREVER")
tn2
tp2
fn2
fp2
sensitivity2= tp2/(tp2+fn2)
specificity2= tn2/(tn2+fp2)
accuracy2 = correct2/length(testY_lstm)






