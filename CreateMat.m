function [] = CreateMat(name)

numberOfIRs = 100;
%name = 'C1m'

for number = 1:numberOfIRs
  IR = audioread(sprintf('BRIR_%d.wav', number));
  IR_L(:,number) = IR(:,1);
  IR_R(:,number) = IR(:,2);
end

save(name,'IR_L','IR_R');

