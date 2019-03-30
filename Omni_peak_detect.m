clear all;

for number = 1:100
 
    
    fileName = sprintf('Raw/IR-7-1-48k-%d.wav', number);
    inputFile = audioread(fileName);
    
    omniPeaks(number) = max(abs(inputFile));
   
end;

[max, location] = max(abs(omniPeaks(:)));

