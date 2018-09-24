clear all;
trainingSet = load('train.mat');
testSet = load('test.mat');

trainRow = 100;
trainCol = 784;
testRow = 10;
testCol = 784;
start = 1;
endindex = trainRow;

XTrain = zeros(trainRow*10, trainCol);
YTrain = zeros(trainRow*10,10);

XTest = zeros(testRow*10, testCol);
YTest = zeros(testRow*10,1);

%Load Data in training and testing matrices 
%XTrain - Training set, YTrain - Training label
%XTest - Testing set, YTest - Testing label

for i= 1:10
    matrixName = strcat('train',int2str(i-1));
    XTrain(start:endindex,:) = getfield(trainingSet, matrixName);
    YTrain(start:endindex,i) = 1;
    start = endindex+1;
    endindex = endindex + trainRow;
end
start = 1;
endindex = testRow;

for i= 1:10
    matrixName = strcat('test',int2str(i-1));
    XTest(start:endindex,:) = getfield(testSet, matrixName);
    YTest(start:endindex,1) = i;
    start = endindex+1;
    endindex = endindex + testRow;
end
XTest = XTest';
YTest = YTest';
errorMatrix = zeros(80,1);
index = 1;
minError = 100;
minIndex = 0;

for K = 1:200
    [Js,er] = pcaHW(XTrain,YTrain,K,XTest,YTest);
    errorMatrix(K,index) = er;
    if(minError>er)
        minError = er;
        minIndex = K;
    end
    index = index + 1 ;
end 
figure
stem(errorMatrix, 'b')
hold
