function [sensitivity,specificity]= postProcessingCNN(patiente,detect,option,netChoice)
%testar
if(option==1)
    if(patiente==1)
        net=load("bestNetworks/Cnn_net.mat").net;
    else 
        net=load("bestNetworks/Cnn_net_SGDM_5x20_2.mat").net;
    end
%treinar
else
    if(patiente==1)
        cnnNetwork(patiente,0.8,1,1,netChoice);
        net=load("networks/Cnn_net.mat").net;
    else
        cnnNetwork(patiente,0.8,1,1,netChoice);
        net=load("networks/Cnn_net_2.mat").net;

    end
end

if(patiente==1)
    testSetX=load("cnn/testSetX.mat").testSetX;
    testSetY=load("cnn/testSetY.mat").testSetY;
else
    testSetX=load("cnn/testSetX_2.mat").testSetX;
    testSetY=load("cnn/testSetY_2.mat").testSetY;
end


YPred =  double(string(classify(net,testSetX)))';
tn=0;
tp=0;
fn=0;
fp=0;
i=1;
correct=0;

    while(i<=length(testSetY))
        if(testSetY(i)==3 && YPred(i)==3)
            tp=tp+1;
        end
        if(testSetY(i)~=3 && YPred(i)==3)
            fp=fp+1;
        end
        if(testSetY(i)==3 && YPred(i)~=3)
            fn=fn+1;
        end
        if(testSetY(i)~=3 && YPred(i)~=3)
            tn=tn+1;
        end
        if(testSetY(i)==YPred(i))
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
    while(i<=length(testSetY))
        if(testSetY(i)==2 && YPred(i)==2)
            tp2=tp2+1;
        end
        if(testSetY(i)~=2 && YPred(i)==2)
            fp2=fp2+1;
        end
        if(testSetY(i)==2 && YPred(i)~=2)
            fn2=fn2+1;
        end
        if(testSetY(i)~=2 && YPred(i)~=2)
            tn2=tn2+1;
        end
        if(testSetY(i)==YPred(i))
            correct2=correct2+1;
        end
        i=i+1;
    end

tn
tp
fn
fp
correct
sensitivity= tp/(tp+fn)
specificity= tn/(tn+fp)
accuracy = correct/length(testSetY)


tn2
tp2
fn2
fp2
correct2
sensitivity2= tp2/(tp2+fn2)
specificity2= tn2/(tn2+fp2)
accuracy2 = correct2/length(testSetY)

if(detect~=1)
    sensitivity=sensitivity2;
    specificity=specificity2;
end





