function [sensitivity,specificity]= postProcessingCNN(patiente,detect,option,netChoice)
%testat
if(option==1)
    if(patiente==1)
        net=load('bestNetworks/LSTM_net_HU100_D.mat').net;
    else
         net=load('bestNetworks/LSTM_net_rmsprop_HU125_2.mat').net;
    end
 %treinar
else
    if(patiente==1)
        LSTMNetwork(patiente,0.80,2,1,netChoice);
        net=load("networks/LSTM_net.mat").net;
    else
        LSTMNetwork(patiente,0.80,2,1,netChoice);
        net=load("networks/LSTM_net_2.mat").net;
    end
end


if(patiente==1)
    testX_lstm=load("lstm/testX_lstm.mat").testX_lstm;
    testY_lstm=load("lstm/testY_lstm.mat").testY_lstm;
else
    testX_lstm=load("lstm/testX_lstm_2.mat").testX_lstm;
    testY_lstm=load("lstm/testY_lstm_2.mat").testY_lstm;
end

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
if(detect~=1)
    sensitivity=sensitivity2;
    specificity=specificity2;
end





