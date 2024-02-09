function[]= cnnNetwork(patiente,percentage,op,detect,netChoice)

prepareDataCnn(patiente,percentage,op)
if(patiente==1)
    trainsSetX=load('cnn/trainSetX.mat').trainsSetX;
    trainsSetY=load('cnn/trainSetY.mat').trainsSetY;
else
    trainsSetX=load('cnn/trainSetX_2.mat').trainsSetX;
    trainsSetY=load('cnn/trainSetY_2.mat').trainsSetY;
end

if(netChoice==1)
    l=convolution2dLayer(5,20)
end
if(netChoice==2)
    l=convolution2dLayer([6 4],32)
end

layers=[imageInputLayer([29 29 1])
        
        l
        %convolution2dLayer(5,32)
        %convolution2dLayer([6 4], 16)
        %convolution2dLayer([6 4], 32)
        %convolution2dLayer(12,25)
        reluLayer
        maxPooling2dLayer(2,'Stride',2)
        fullyConnectedLayer(4)
        softmaxLayer
        classificationLayer;
    ]
if(patiente==1)
    maxEpochs=1000;
else
    maxEpochs=1000;
end
options = trainingOptions('adam', ...
    'MaxEpochs',maxEpochs,...
    'Verbose',false, ...
    'Plots','training-progress');

categoricalY=categorical(trainsSetY);

net=trainNetwork(trainsSetX,categoricalY',layers,options);
if(patiente==1)
    save 'networks/Cnn_net.mat' net;
else
    save 'networks/Cnn_net_2.mat' net;
end
%postProcessingCNN(detect)





