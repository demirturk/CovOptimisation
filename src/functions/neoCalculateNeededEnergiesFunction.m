function [av1,av2,av3,target_CI1,target_CI2,target_CI3,...
    node_CI1, node_CI2,node_CI3,energy_to_be_consumedALL,...
    nodes_overhead_energy_consumption_CI_ALL,encryption_energy_ALL,OverheadMatrix128192256]=...
    neoCalculateNeededEnergiesFunction(total_blocks,target_CIA_in_av_order,...
    generate_CI1,generate_CI2,generate_CI3,...
    node_group1,node_group2,node_group3)

%CALCULATE ENERGY NEED
%first call known energy info %what are the known energy consumption values

energy_info=neo_call_energy_info; %ikinci versiyon DPR enerjileri farkliysa
OverheadMatrix128192256=[energy_info(9:11);energy_info(12:14);energy_info(15:17)];
Overh_=[OverheadMatrix128192256(:,2),OverheadMatrix128192256(:,3),OverheadMatrix128192256(:,1)];
OverheadMatrix192256128=[Overh_(2,:);Overh_(3,:);Overh_(1,:)];

av1=target_CIA_in_av_order(1,3);
av2=target_CIA_in_av_order(2,3);
av3=target_CIA_in_av_order(3,3);
% 
% % init_cov
% disp('initialized');

%ilk once en yuksek availability ihtiyacini karsilamaya calisacak
%o yuzden target_CI gr1'inki olarak secilir
target_CI1=generate_CI1;
target_CI2=generate_CI2;
target_CI3=generate_CI3;
CItargets=[target_CI1;target_CI2;target_CI3];

node_CI1=node_group1(:,[3 4]);      % 2 1
node_CI2=node_group2(:,[3 4]);      % 3 1
node_CI3=node_group3(:,[3 4]);      % 1 1
CInodes= [node_CI1,node_CI2,node_CI3];

%energy_to_be_consumedALL 1to1 2to1 3to1 --1to2 2to2 3to2-- 1to3 2to3 3to3
%node overhead 1to1 2to1 3to1 --1to2 2to2 3to2-- 1to3 2to3 3to3
[energy_to_be_consumedALL,nodes_overhead_energy_consumption_CI_ALL,encryption_energy_ALL1]=neo_nodetoallenergies(CItargets,CInodes,energy_info,total_blocks);

% siralamasi 1to1 2to1 3to1 --1to2 2to2 3to2-- 1to3 2to3 3to3
encryption_energy_ALL=energy_to_be_consumedALL-nodes_overhead_energy_consumption_CI_ALL; 

% disp('calculated energies');

% [ALLNODES_w_consumptionsto1,ALLNODES_w_consumptionsto2,ALLNODES_w_consumptionsto3]= create_nodeWcons(node_group1,node_group2,node_group3,energy_to_be_consumedALL);

% disp('nodes w consumption generated');



% initcov1= length(allpossible_node_IDs1to1)/node_number;
% initcov2= length(allpossible_node_IDs2to2)/node_number;
% initcov3= length(allpossible_node_IDs3to3)/node_number;
% initcoverages=[initcov1, initcov2,initcov3];

end


