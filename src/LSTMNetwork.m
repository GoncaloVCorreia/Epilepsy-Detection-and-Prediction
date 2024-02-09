function [] = LSTMNewtork(patiente,percentage,op,detect,netChoice)
[trainX_lstm,trainY_lstm,testX_lstm,testY_lstm,numFeatures]=prepareDataLSTM(patiente,percentage,op);

trainX_lstm=num2cell(trainX_lstm,1);
testX_lstm=num2cell(testX_lstm,1);
trainY_lstm=categorical(trainY_lstm);

if(netChoice==3)
    numHiddenUnits=50
end
if(netChoice==4)
    numHiddenUnits=125
 end
numClasses=4;

layers=[
    sequenceInputLayer(numFeatures)
    lstmLayer(numHiddenUnits,'OutputMode','last')
    fullyConnectedLayer(numClasses)
    softmaxLayer
    classificationLayer
    ]
if(patiente==1)
    maxEpc=20;
else
     maxEpc=100;
end
options = trainingOptions('adam', ...
    'MaxEpochs',maxEpc, ...
    'GradientThreshold',1, ...
    'Plots','training-progress', ...
    'MiniBatchSize',100, ...
    'InitialLearnRate',0.1, ...
    'Verbose',0, ...
    'ExecutionEnvironment','cpu');

net=trainNetwork(trainX_lstm,trainY_lstm,layers,options);
if(patiente==1)
    save 'networks/LSTM_net.mat' net;
else
    save 'networks/LSTM_net_2.mat' net;
end

%postProcessingLSTM(detect);



