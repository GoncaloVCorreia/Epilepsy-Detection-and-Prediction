function [trainSetY] = revertTarget(trainSetY_aux)
[numFeatures,dim]=size(trainSetY_aux);
i=1;
trainSetY=[];
while(i<=dim)
    if(trainSetY_aux(:,i)==[1;0;0;0])
        trainSetY=[trainSetY 1];
    end
    if(trainSetY_aux(:,i)==[0;1;0;0])
        trainSetY=[trainSetY 2];
    end
    if(trainSetY_aux(:,i)==[0;0;1;0])
       trainSetY=[trainSetY 3];
    end
    if(trainSetY_aux(:,i)==[0;0;0;1])
       trainSetY=[trainSetY 4];
    end
    i=i+1;
end