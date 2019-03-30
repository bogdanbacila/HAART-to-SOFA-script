clear all;

%%
% This demo creates an artificial HRTF set.
% It shows how to use SOFAgetConventions and SOFAsave
% The HRTF set contains single pulses placed at sample index of 100
% which results in a broadband delay of 100 samples. 
% Each IR is 256 samples long (i.e., N=256)

% SOFA API - demo script
% Copyright (C) 2012-2013 Acoustics Research Institute - Austrian Academy of Sciences
% Licensed under the EUPL, Version 1.1 or ? as soon they will be approved by the European Commission - subsequent versions of the EUPL (the "License")
% You may not use this work except in compliance with the License.
% You may obtain a copy of the License at: http://joinup.ec.europa.eu/software/page/eupl
% Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" basis, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
% See the License for the specific language governing  permissions and limitations under the License. 


%% Set parameters
% Latency of the created IRs
% latency=100; % in samples, must be 1<latency<256
% Data compression (0..uncompressed, 9..most compressed)
compression=1; % results in a nice compression within a reasonable processing time



%% Create a 2D array with the IRs from the current folder

irName = 'LS8m';
CreateMat(irName);

%% Get an empy conventions structure
Obj = SOFAgetConventions('SimpleFreeFieldHRIR');

%% Define positions -  we use the standard CIPIC positions here
lat1 = 0 + 3.6*(0:99);    % lateral angles, 3.6 degrees apart
pol1= 0;                   % polar angles (0 - just one elevation)
pol=repmat(pol1',length(lat1),1);
lat=lat1(round(0.5:1/length(pol1):length(lat1)+0.5-1/length(pol1)));


%% Load impulse response

load(irName);
N = length(IR_L(:,1));

%% Fill data with data
M=length(lat1)*length(pol1);
Obj.Data.IR = NaN(M,2,N); % data.IR must be [M R N]

ii=1;
for aa=1:length(lat1)
	for ee=1:length(pol1)
		Obj.Data.IR(ii,1,:)=IR_L(:,aa);
		Obj.Data.IR(ii,2,:)=IR_R(:,aa);
		[azi,ele]=hor2sph(lat(ii),pol(ii));
    Obj.SourcePosition(ii,:)=[azi ele 1];
		Obj.SourcePosition(ii,:)=[azi ele 1];
		ii=ii+1;
	end
end

%% Update dimensions
Obj=SOFAupdateDimensions(Obj);

%% Fill with attributes
Obj.GLOBAL_ListenerShortName = 'KU100';
Obj.GLOBAL_History = 'created with a script';
Obj.GLOBAL_DatabaseName = 'none';
Obj.GLOBAL_ApplicationName = 'Create SOFA file for one position from St Pauls room';
Obj.GLOBAL_ApplicationVersion = SOFAgetVersion('API');
Obj.GLOBAL_Organization = 'Applied Psychoacoustics Lab (APL), University of Huddersfield';
Obj.GLOBAL_AuthorContact = 'bogdan.bacila@hud.ac.uk';
Obj.GLOBAL_Comment = 'Contains 100 BRIRs at 3.6 degrees apart and one elevation(0)';

%% save the SOFA file

%SOFAfn=fullfile(SOFAdbPath,'sofa_api_mo_test',sprintf('%s.sofa', irName));
SOFAfn=sprintf('%s.sofa', irName);
disp(['Saving:  ' SOFAfn]);
Obj=SOFAsave(SOFAfn, Obj, compression);
