clear all;
maxPeak = 0.035240922123194;
mkdir Omni_Normalized;

for number = 1:100
    
  fileName = sprintf('IR-7-1-48k-%d.wav', number);
    
  inputFile = audioread(fileName);
  outputFile = (inputFile./maxPeak)*0.9;
   
  audiowrite(sprintf('Omni_Normalized/Omni_IR_%d.wav', number), outputFile, 48000, 'BitsPerSample', 32);
  
end;