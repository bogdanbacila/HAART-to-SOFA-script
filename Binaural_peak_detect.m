clear all;

for channel = 1:2
  for number = 1:100
    
    fileName = sprintf('Raw/IR-%d-1-48k-%d.wav', channel, number);
    inputFile = audioread(fileName);
    
    binauralPeaks(channel, number) = max(abs(inputFile));
    
  end
end;

[max, location] = max(abs(binauralPeaks(:)));

