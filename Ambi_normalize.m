clear all;
maxPeak = 0.121287867426872;
mkdir Ambi_Normalized;

for number = 1:100
  
  for channel = 3:6
    fileName = sprintf('IR-%d-1-48k-%d.wav', channel, number);
    
    inputFile = audioread(fileName);
    outputFile(:,channel-2) = (inputFile./maxPeak)*0.9;
   
  end;
  audiowrite(sprintf('Ambi_Normalized/Ambi_IR_%d.wav', number), outputFile, 48000, 'BitsPerSample', 32);
end;