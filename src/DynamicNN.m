function []= DynamicNN(patiente,netChoice) 

if(patiente==1)
    T=load("pacient1/pacient_total_final_target.mat");
    P=load("pacient1/pacient_P.mat");
    Trg=load("pacient1/pacient_total_Trg.mat");
   
else
    T=load("pacient2/pacient_total_final_target.mat");
    P=load("pacient2/pacient_P.mat");
    Trg=load("pacient2/pacient_total_Trg.mat");
end
 T=T.Target;
 P=P.P;
 Trg=Trg.Trg;

[P,T,Trg]=prepareDataShallow(patiente,0);
Trg=Trg';
[~, nc] = size(P);

%erros
ew=[];

for (i=1 : nc)
    if (Trg(i)==2)
        ew=[ew 0.8];
    end
    if  (Trg(i)==3)
        ew=[ew 0.9];
    end
    if  (Trg(i)==1 )
        ew=[ew 0.1];
    end
    if  (Trg(i)==4 )
        ew=[ew 0.3];
    end
end


%layers=[30,20,10];
layers=[20,10];
%layers=10;
if(netChoice==7)
    net = narxnet(1:3,1:3,layers,'open','trainscg')
end
if(netChoice==8)
    net = narxnet(1:2,1:2,layers,'open','trainscg')
end


%para treinar
net.divideParam.trainRatio = 0.85;
net.divideParam.testRatio = 0.15;
net.trainParam.max_fail = 250;
net.trainParam.epochs = 300;

[Xs,Xi,Ai,Ts,ew] = preparets(net,tonndata(P',false,false),{},tonndata(T,false,false),tonndata(ew,false,false));
net = train(net,Xs,Ts,Xi,Ai,ew);
if(patiente==1)
    save 'networks/DynamicNN_P.mat' net;
else
      save 'networks/DynamicNN_P_2.mat' net;
end

%postProcessing(patiente,2);




