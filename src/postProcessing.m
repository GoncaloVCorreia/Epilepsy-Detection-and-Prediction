function [sense,spec]= postProcessing(patiente,control,option,detect,netChoice)
if(patiente==1)
    testSet_target=load("pacient1/pacient_testSet_target.mat");
    testSet_dataset=load("pacient1/pacient_testSet_dataset.mat");
    testSet_dataset=testSet_dataset.testSet_dataset;
    testSet_target=testSet_target.testSet_target;
   
else
    testSet_target=load("pacient2/pacient_testSet_target.mat");
    testSet_dataset=load("pacient2/pacient_testSet_dataset.mat");
    testSet_dataset=testSet_dataset.testSet_dataset;
    testSet_target=testSet_target.testSet_target;

end

[testSet_dataset,testSet_target]=prepareDataShallow(patiente,1);
%Non Dynamic
if(control==1)
    %testar
    if(option==1)
        if(patiente==1)
            net = load("bestNetworks/NonDynamicNN.mat");
        else
            net = load("bestNetworks/NonDynamicNN_D_2.mat");
        end
    %treinar
    else
        if(patiente==1)
            NonDynamicNN(patiente,netChoice);
            net=load("networks/NonDynamicNN_D.mat");
        else
            NonDynamicNN(patiente,netChoice);
            net=load("networks/NonDynamicNN_D_2.mat");
        end
    end
%Dynamic
else
    %testar
    if(option==1)
        if(patiente==1)
            net=load("bestNetworks/DynamicNN.mat");
        else
            net=load("bestNetworks/DynamicNN_P_2.mat");
        end

    %treinar
    else
        if(patiente==1)
            DynamicNN(patiente,netChoice);
            net=load("networks/DynamicNN_P.mat");
        else
            DynamicNN(patiente,netChoice);
            net=load("networks/DynamicNN_P_2.mat");
        end
    end
end

net=net.net;

if(control==1)
    Y=sim(net,testSet_dataset);
    [~, result]=max(Y);
    [~,testSet_target]=max(testSet_target');
else
    [Xs,Xi,Ai,~]=preparets(net,tonndata(testSet_dataset',false,false),{},tonndata(testSet_target,false,false));
    Y=sim(net,Xs,Xi,Ai);
    [~, result]=max(cell2mat(Y));

    [~,testSet_target]=max(testSet_target');
end

%detection
tp=0;
fn=0;
fp=0;
tn=0;

for i=1:length(result)
    if(result(i)==3 & testSet_target(i)==3)
        tp=tp+1;
    end
    if(result(i)~=3 & testSet_target(i)==3)
        fn=fn+1;
    end
    if(result(i)~=3 & testSet_target(i)~=3)
        tn=tn+1;
    end
    if(result(i)==3 & testSet_target(i)~=3)
        fp=fp+1;
    end
end

%prediction
tp2=0;
fn2=0;
fp2=0;
tn2=0;
acc=0;
for i=1:length(result)
    if(result(i)==2 & testSet_target(i)==2)
        tp2=tp2+1;
    end
    if(result(i)~=2 & testSet_target(i)==2)
        fn2=fn2+1;
    end
    if(result(i)~=2 & testSet_target(i)~=2)
        tn2=tn2+1;
    end
    if(result(i)==2 & testSet_target(i)~=2)
        fp2=fp2+1;
    end
    if(result(i)==testSet_target(i))
        acc=acc+1;
    end

end

    Y;
    disp("DETECTION")
    tp
    fn
    tn
    fp
    sensitivity=tp/(tp+fn)
    specificity=tn /(tn + fp)
    accuracy= acc/length(result)
    Y;
    disp("PREDICTION")
    tp2
    fn2
    tn2
    fp2
    sensitivity2=tp2/(tp2+fn2)
    specificity2=tn2 /(tn2 + fp2)
    accuracy= acc/length(result)
     
   if(detect==1)
       sense=sensitivity;
       spec=specificity;
   else
       sense=sensitivity2;
       spec=specificity2;
   end



