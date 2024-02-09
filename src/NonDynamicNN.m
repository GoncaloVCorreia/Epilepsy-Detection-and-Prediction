function []= NonDynamicNN(patiente,netChoice) 

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

%detection
if(patiente==1)
    for (i=1 : nc)
        if (Trg(i)==3)
            ew=[ew 0.7];
        end
        if  (Trg(i)==2)
            ew=[ew 0.6];
        end
        if  (Trg(i)==1)
            ew=[ew 0.1];
        end
        if  (Trg(i)==4)
            ew=[ew 0.7];
        end
    end
end
%prediction    
if(patiente==2)
    for (i=1 : nc)
        if (Trg(i)==3)
            ew=[ew 2.2];
        end
        if(Trg(i)==2)
            ew=[ew 0.8];
        end
        if  (Trg(i)==4)
            ew=[ew 0.7];
        end
        if  (Trg(i)==1 )
            ew=[ew 0.1];
        end
    end
end

if(netChoice==5)
    layers=[20,10]
end
if(netChoice==6)
    layers=[10]
end

%layers=[30,20,10];
net = feedforwardnet(layers,'trainscg');

%para treinar
net.divideParam.trainRatio = 0.85;
net.divideParam.testRatio = 0.15;
net.trainParam.max_fail = 250;
%net.trainParam.epochs=200;
net.trainParam.epochs = 2000;
net.divideFcn='dividerand';

T=T';
net = train(net,P,T,{},{},ew,'UseGPU','yes');
if(patiente==1)
    save 'networks/NonDynamicNN_D.mat' net;
else 
    save 'networks/NonDynamicNN_D_2.mat' net;
end
%patiente, operaca ( 1 -> treinar, 2-> so testar)
%postProcessing(patiente,1)

