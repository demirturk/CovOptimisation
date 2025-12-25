% Calculating the energy need to be consumed

% operation target time in minutes is t
% target_specs = {target_CI, target_time}
% energy_to_be_consumed= overhead of changes + (targetted time * energy per min)

function [energy_to_be_consumed_to_targetCI1,nodes_overhead_energy_consumption_to_targetCI1,...
    C_consumption_targetCI1,C_overheadto_targetCI1,I_consumption_targetCI1,I_overheadto_targetCI1]= ...         %C_overhead ve I_overhead 100x1 vector
    neo_calc_energy(target_CI1,node_CI1, ...
    energy_info, ...
    total_blocks)

energy_need_per_min_power_ON=energy_info(1);
energy_need_per_min_C=energy_info(2:4);
energy_need_per_min_I=energy_info(5:7);
% overhead_Cs=[[zeros(1,3);energy_info(9:11);energy_info(12:14) ;energy_info(15:17)],[0;0;0;0]];

%GRUP SIRASINA GORE ISE BU 128to128 128to192 128to256 192to128.....
overhead_Cs=[energy_info(9:11);energy_info(12:14) ;energy_info(15:17)]; 
overhead_Is=[energy_info(19:21);energy_info(22:24) ;energy_info(25:27)];

% %LEVELSIRASINA GORE ISE BU
% overhead_Csx=[energy_info(9:11) ;energy_info(12:14);energy_info(15:17) ];
% overhead_Csy=[overhead_Csx(3,:);overhead_Csx(1,:);overhead_Csx(2,:)];
% overhead_Cs=[overhead_Csy(:,3),overhead_Csy(:,1),overhead_Csy(:,2)];
% overhead_Isx=[energy_info(19:21);energy_info(22:24);energy_info(25:27)];
% overhead_Isy=[overhead_Isx(3,:);overhead_Isx(1,:);overhead_Isx(2,:)];
% overhead_Is=[overhead_Isy(:,3),overhead_Isy(:,1),overhead_Isy(:,2)];

% 
% isdifferent= target_CI~= node_CI;       %aynı olanlar  icin 1 farklı olanlar icin 0 üretir
% lvl_change_to= isdifferent.*target_CI;
% node_CI su andaki levellar
% target_CI gidecegi levellar


power_ON_energy=total_blocks*energy_need_per_min_power_ON; %BU SATIRDA DUZELTME GEREKIR
C_consumption_targetCI1= total_blocks*energy_need_per_min_C(target_CI1(1));      
I_consumption_targetCI1= total_blocks*energy_need_per_min_I(target_CI1(2));

% C_consumption=zeros(length(node_CI1),1);
% I_consumption=zeros(length(node_CI1),1);
% 
% for i=1: length(node_CI1)
% C_consumption(i,1)= total_blocks*energy_need_per_min_C(target_CI1(i,1));
% I_consumption(i,1)= total_blocks*energy_need_per_min_I(target_CI1(i,2));
% end



C_overheadto_targetCI1=zeros(length(node_CI1),1);
I_overheadto_targetCI1=zeros(length(node_CI1),1);

for i=1: length(node_CI1)
C_overheadto_targetCI1(i,1)=(overhead_Cs(node_CI1(i,1), target_CI1(1)));
end

for i=1: length(node_CI1)
I_overheadto_targetCI1(i,1)=(overhead_Is(  node_CI1(i,2), target_CI1(2)  )  );
end

nodes_overhead_energy_consumption_to_targetCI1=(C_overheadto_targetCI1) + (I_overheadto_targetCI1) ;
energy_to_be_consumed_to_targetCI1= power_ON_energy+C_consumption_targetCI1+I_consumption_targetCI1+nodes_overhead_energy_consumption_to_targetCI1;
end
