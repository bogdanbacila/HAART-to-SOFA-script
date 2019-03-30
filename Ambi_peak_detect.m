clear all;

for number = 1:100
  for channel = 3:6
    
    fileName = sprintf('Raw/IR-%d-1-48k-%d.wav', channel, number);
    inputFile = audioread(fileName);
    
    ambiPeaks(number,channel-2) = max(abs(inputFile));
    
  end
end;

[max, location] = max(abs(ambiPeaks(:)));

