%ConsumedEnergies ----- islemler tamamlandiktan sonra enerjiler harcanmis
%gibi hesap yapacagiz. yani energytobeconsumed'lari yazacagiz. Sonra da
%enerji-energytobeconsumed=lastenergy diycez

function [changedmatrix2,ConsumedEnergies,ConsumedEnergies_DPR,ConsumedEnergies_ENC]= finalized(nextstate, energy_to_be_consumedALL,nodes_overhead_energy_consumption_CI_ALL,encryption_energy_ALL,target_CI1,target_CI2,target_CI3)

% energy_consumed=resize(energy_to_be_consumedALL,[3 3]);
% energy_consumed1to1= energy_to_be_consumedALL(:,1);   
% energy_consumed2to1= energy_to_be_consumedALL(:,2);
% energy_consumed3to1= energy_to_be_consumedALL(:,3);
% energy_consumed1to2= energy_to_be_consumedALL(:,4);
% energy_consumed2to2= energy_to_be_consumedALL(:,5);
% energy_consumed3to2= energy_to_be_consumedALL(:,6);
% energy_consumed1to3= energy_to_be_consumedALL(:,7);
% energy_consumed2to3= energy_to_be_consumedALL(:,8);
% energy_consumed3to3= energy_to_be_consumedALL(:,9);


nodeNo=size(nextstate,1);
tempmatrix_A=nextstate(:,1:6);
tempmatrix_B=nextstate(:,7:12);
tempmatrix_C=nextstate(:,13:18);

threematrix= nextstate;

ConsumedEnergyA=zeros(length(tempmatrix_A),1);
ConsumedEnergyB=ConsumedEnergyA;
ConsumedEnergyC=ConsumedEnergyA;
ConsumedEnergy_DPRA=ConsumedEnergyA;
ConsumedEnergy_DPRB=ConsumedEnergyA;
ConsumedEnergy_DPRC=ConsumedEnergyA;
ConsumedEnergy_ENCA=ConsumedEnergyA;
ConsumedEnergy_ENCB=ConsumedEnergyA;
ConsumedEnergy_ENCC=ConsumedEnergyA;

index_nodeA=tempmatrix_A(:,1);
start_grA  =tempmatrix_A(:,2);
end_grA    =tempmatrix_A(:,6);

index_nodeB=tempmatrix_B(:,1);
start_grB  =tempmatrix_B(:,2);
end_grB    =tempmatrix_B(:,6);

index_nodeC=tempmatrix_C(:,1);
start_grC  =tempmatrix_C(:,2);
end_grC    =tempmatrix_C(:,6);


%hangi node nerden nereye gectigine gore enerji tuketimini buluyorum
for i = 1:length(tempmatrix_A)
    if end_grA(i) ~= 0
        column_indexA(i) = end_grA(i); % Hangi sütuna erişeceğimizi hesaplıyoruz
        ConsumedEnergyA(i) = energy_to_be_consumedALL(index_nodeA(i), column_indexA(i));
        ConsumedEnergy_DPRA(i)=nodes_overhead_energy_consumption_CI_ALL(index_nodeA(i), column_indexA(i));
        ConsumedEnergy_ENCA(i)=encryption_energy_ALL(index_nodeA(i), column_indexA(i));
    end
end



for i = 1:length(tempmatrix_B)
    if end_grB(i) ~= 0
        column_indexB = 3+end_grB(i); % Hangi sütuna erişeceğimizi hesaplıyoruz
        ConsumedEnergyB(i) = energy_to_be_consumedALL(index_nodeB(i), column_indexB);
        ConsumedEnergy_DPRB(i)=nodes_overhead_energy_consumption_CI_ALL(index_nodeB(i), column_indexB);
        ConsumedEnergy_ENCB(i)=encryption_energy_ALL(index_nodeB(i), column_indexB);
    end
end


for i = 1:length(tempmatrix_C)
    if end_grC(i) ~= 0
        column_indexC(i) = 6+end_grC(i); % Hangi sütuna erişeceğimizi hesaplıyoruz
        ConsumedEnergyC(i) = energy_to_be_consumedALL(index_nodeC(i), column_indexC(i));
        ConsumedEnergy_DPRC(i)=nodes_overhead_energy_consumption_CI_ALL(index_nodeC(i), column_indexC(i));
        ConsumedEnergy_ENCC(i)=encryption_energy_ALL(index_nodeC(i), column_indexC(i));
    end
end



%enerji tuketiminden sonraki enerjileri buldum
threematrix(:,5)=tempmatrix_A(:,5)-ConsumedEnergyA;
threematrix(:,11)=tempmatrix_B(:,5)-ConsumedEnergyB;
threematrix(:,17)=tempmatrix_C(:,5)-ConsumedEnergyC;

%yeni yerlestikleri grupları yazdim
threematrix(:,2)=nextstate(:,6);  
threematrix(:,8)=nextstate(:,12);
threematrix(:,14)=nextstate(:,18);

for j=1:nodeNo  
    if threematrix(j,2)==1
        threematrix(j,3:4)=target_CI1;
    elseif threematrix(j,2)==2
        threematrix(j,3:4)=target_CI2;
    elseif threematrix(j,2)==3
        threematrix(j,3:4)=target_CI3;
    end

    if threematrix(j,8)==1
        threematrix(j,9:10)=target_CI1;
    elseif threematrix(j,8)==2
        threematrix(j,9:10)=target_CI2;
    elseif threematrix(j,8)==3
        threematrix(j,9:10)=target_CI3;
    end

     if threematrix(j,14)==1
        threematrix(j,15:16)=target_CI1;
    elseif threematrix(j,14)==2
        threematrix(j,15:16)=target_CI2;
    elseif threematrix(j,14)==3
        threematrix(j,15:16)=target_CI3;
    end

end


changedmatrix2= threematrix;



ConsumedEnergies    =[ConsumedEnergyA,ConsumedEnergyB,ConsumedEnergyC];
ConsumedEnergies_DPR  =[ConsumedEnergy_DPRA,ConsumedEnergy_DPRB,ConsumedEnergy_DPRC];
ConsumedEnergies_ENC  =[ConsumedEnergy_ENCA,ConsumedEnergy_ENCB,ConsumedEnergy_ENCC];


end