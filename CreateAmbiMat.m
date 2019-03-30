function [] = CreateAmbiMat(name)

numberOfIRs = 100;
%name = 'C1m'

for number = 1:numberOfIRs
  IR = audioread(sprintf('Ambi_IR_%d.wav', number));
  IR_1(:,number) = IR(:,1);
  IR_2(:,number) = IR(:,2);
  IR_3(:,number) = IR(:,3);
  IR_4(:,number) = IR(:,4);
end

save(name,'IR_1','IR_2','IR_3','IR_4');

