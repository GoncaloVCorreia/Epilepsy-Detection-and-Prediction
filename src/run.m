function [sense,spec]= run(patiente,action,option,network,forTrainingNetwork)



%patiente
if(strcmp(patiente,'44202')==1)
   patiente=1;
else
   patiente=2;
end
%action
if(strcmp(action,'Detect')==1)
    action=1;
else
    action=0;
end
%option
if(strcmp(option,'Test')==1)
    option=1;
else
    option=0;
end

%se for so testar
if(option==1)

   
    if(strcmp(network,'CNN')==1)
        network=1;
        [sense,spec]=postProcessingCNN(patiente,action,option);
    
        
    elseif(strcmp(network,'LSTM')==1)
        network=2;
        [sense,spec]=postProcessingLSTM(patiente,action,option);
    
    elseif(strcmp(network,'NonDynamic')==1)
        network=3;
        [sense,spec]=postProcessing(patiente,1,option,action,0);
    
    
    elseif(strcmp(network,'Dynamic')==1)
        network=4;
        [sense,spec]=postProcessing(patiente,2,option,action,0);
    
    
    end
else
    forTrainingNetwork
    networkChoice=0;
    if(strcmp(forTrainingNetwork,'CNN_(5,20)')==1)
        networkChoice=1
        [sense,spec]=postProcessingCNN(patiente,action,option,networkChoice);

    elseif(strcmp(forTrainingNetwork,'CNN_([6,4],32)')==1)
         networkChoice=2
         [sense,spec]=postProcessingCNN(patiente,action,option,networkChoice);

    elseif(strcmp(forTrainingNetwork,'LSTM_HU50')==1)
         networkChoice=3
         [sense,spec]=postProcessingLSTM(patiente,action,option,networkChoice)

    elseif(strcmp(forTrainingNetwork,'LSTM_HU125')==1)
         networkChoice=4
         [sense,spec]=postProcessingLSTM(patiente,action,option,networkChoice);

    elseif(strcmp(forTrainingNetwork,'ND_20_10')==1)
         networkChoice=5
          [sense,spec]=postProcessing(patiente,1,option,action,networkChoice);

    elseif(strcmp(forTrainingNetwork,'ND_10')==1)
         networkChoice=6
         [sense,spec]=postProcessing(patiente,1,option,action,networkChoice);
    elseif(strcmp(forTrainingNetwork,'DNN_1:3_20_10')==1)
         networkChoice=7
         [sense,spec]=postProcessing(patiente,2,option,action,networkChoice);
    else
         networkChoice=8
         [sense,spec]=postProcessing(patiente,2,option,action,networkChoice);
    end

end


