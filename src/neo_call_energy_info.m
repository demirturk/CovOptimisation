% call_energy_info_V2

%energy_info en altta atamasi yapildi
function energy_info=neo_call_energy_info()

% node un acikken harcadigi base energy
energy_need_per_128bit_power_ON=0;  %simdilik dikkate almadim

% confidentiality icin algoritmalar
% yok, AES128, AES192, AES256
% karsilik gelen levellar sirasiyla {1,2,3}
confidentiality_levels=[1,2,3];
energy_need_per_128bit_C=[5.05, 5.98, 6.66];  %nJ energy_need_per_128bit_block for confidentiality algorithm

% integrity icin algoritmalar
% None, Ascon hash, SHA 256, SHA 384 
% sahip olduklari levellar sirasiyla {1,2,3,4}

integrity_levels=[1,2,3];
energy_need_per_128bit_I=[0,0,0]; %energy_need_per_min for integrity algorithm

%AXIWHICAP consumes 9.2mw avg power and TP=14.3MB. 
% Since AES partial bit is
%6.16MB gibi bir bitstream degerim olsaydı
% reconftime=boyut/TP
%energy=avg_power*reconftime derdim
%bu calismada farklı ama her farklı kısım icin farklı reconftime ve enerji tüketimi var
%0.43sec de tamamlamış 6.16/14.3

% E_ICAPj=9.2*(10^-3)*0.43; 
AvgPower_AXI_HWICAP=9.2*10^(-3);  %watt
% AvgReconfTP_AXI_HWICAP=14.3; % MB/s   througput
reconftimeKL=0.0943*10^(-3); %seconds
reconftimeKM=0.1092*10^(-3); % in seconds
% reconftimeENC=0.6726*10^(-3); %we dont use these because we only do AES

%ASAGIDA EKLEDIGIM SAYILAR NE ANLAMA GELIYOR?? first run ve subsequent run
%arasında enerji tüketim farkı var first run'ın fazla enerjisini DPR a
%koydum ki her dpr yapıldığında first run olacağı için aradan çıkar
% overhead_Csi=[E_ICAPnj+23.77, E_ICAPnj+30.07, E_ICAPnj+36.53];  % uc sifreleme algoritması icin overhead in nj 

DPR_KL128= reconftimeKL*AvgPower_AXI_HWICAP;    % in joules
DPR_KL192= DPR_KL128;   % in joules
DPR_KL256= DPR_KL128;   % in joules
DPR_KL_Blank= DPR_KL128;    % in joules

DPR_KM1= reconftimeKM* AvgPower_AXI_HWICAP;
DPR_KM2= DPR_KM1;

diff_firstrun128=128*(0.2252-0.0395)*10^(-9);   %energy difference in joules for first run per 128 bit block   
diff_firstrun192=128*(0.2816-0.0467)*10^(-9);   %energy difference in joules for first run per 128 bit block 
diff_firstrun256=128*(0.3374-0.0520)*10^(-9);   %energy difference in joules for first run per 128 bit block 

DPRenergy_192to192=0;
DPRenergy_192to256= DPR_KL256+   0    + diff_firstrun256+ DPR_KL_Blank;  % in joules
DPRenergy_192to128= DPR_KL128+ DPR_KM1+ diff_firstrun128+ DPR_KL_Blank;  % in joules
DPRenergy_256to192= DPR_KL192+   0    + diff_firstrun192+ DPR_KL_Blank;  % in joules
DPRenergy_256to256=0;
DPRenergy_256to128= DPR_KL128+ DPR_KM1+ diff_firstrun128+ DPR_KL_Blank;  % in joules
DPRenergy_128to192= DPR_KL192+ DPR_KM2+ diff_firstrun192+ DPR_KL_Blank;  % in joules
DPRenergy_128to256= DPR_KL256+ DPR_KM2+ diff_firstrun256+ DPR_KL_Blank;  % in joules
DPRenergy_128to128=0;


% E_ICAPj=[DPRenergy_192to192, DPRenergy_192to256, DPRenergy_192to128,...
%     DPRenergy_256to192, DPRenergy_256to256 ,DPRenergy_256to128,...
%     DPRenergy_128to192,DPRenergy_128to256,DPRenergy_128to128];

E_ICAPj=[DPRenergy_128to128, DPRenergy_128to192, DPRenergy_128to256, ... 
         DPRenergy_192to128, DPRenergy_192to192, DPRenergy_192to256, ...
         DPRenergy_256to128, DPRenergy_256to192, DPRenergy_256to256  ];

E_ICAPnj=E_ICAPj*(10^9); %DPR overheads in nJ



overhead_Csi=E_ICAPnj;  % uc sifreleme algoritması icin birbiri arasında gecis icin overhead in nj 
overhead_Cs=[0,overhead_Csi]; %overhead olmayacaksa sifirdir o yuzden basa sifir eklendi

%DPRenergy_1to2, DPRenergy_1to3, DPRenergy_2to1 ,DPRenergy_2to3, DPRenergy_3to1, DPRenergy_3to2
overhead_Isi=[0,0,0,0,0,0,0,0,0];   % hash fonksiyonları yok su anda o yüzden sıfır bunlar
overhead_Is=[0,overhead_Isi]; %overhead olmayacaksa sifirdir o yuzden basa sifir eklendi

% DPRenergy_128to128, DPRenergy_128to192, DPRenergy_128to256, ... 
%          DPRenergy_192to128, DPRenergy_192to192, DPRenergy_192to256, ...
%          DPRenergy_256to128, DPRenergy_256to192, DPRenergy_256to256 

energy_info=[energy_need_per_128bit_power_ON,...
    energy_need_per_128bit_C, ...
    energy_need_per_128bit_I, ...
    overhead_Cs, ...        % 8:17 on tane
    overhead_Is ];          % 18:27 on tane

end