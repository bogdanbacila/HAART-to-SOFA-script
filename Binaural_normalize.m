clear all;
maxPeak = 0.103373147547245;
mkdir Binaural_Normalized;

for number = 1:100
  
  for channel = 1:2
    fileName = sprintf('IR-%d-1-48k-%d.wav', channel, number);
    
    inputFile = audioread(fileName);
    outputFile(:,channel) = (inputFile./maxPeak)*0.9;
   
  end;
  audiowrite(sprintf('Binaural_Normalized/BRIR_%d.wav', number), outputFile, 48000, 'BitsPerSample', 32);
end;