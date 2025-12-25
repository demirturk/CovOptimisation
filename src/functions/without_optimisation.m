
% clear
% clc
% sim_INPUTS;

[grno_a,grno_b,grno_c,generate_CI1,generate_CI2,generate_CI3,...
    node_group1,node_group2,node_group3,target_CIA_in_av_order]=...
    neoGenerateNodesFunction(node_number,israndom,budget,potentialimpact_n1,potentialimpact_n2,potentialimpact_n3);     %test icin icerde deger ver


%create ALLNODES matrix for decision input
placezero=zeros(node_number,1);
ALLNODES=[node_group1,placezero,node_group2,placezero,node_group3,placezero];
NodesAtStart=ALLNODES;
changedmatrix2=ALLNODES;

boy=size(1:M:B ,2);
init_cov_mat=zeros(boy,3);
outp_cov_mat=zeros(boy,3);
row_ind=1;
%FOR LOOP BURAYA GELECEK

for i=0:M:time
    ALLNODES=changedmatrix2;
    places=[6, 12, 18];
    ALLNODES(:,places)=0;
    initialstate=ALLNODES;
        node_group1p=ALLNODES(:,1:5);
        node_group2p=ALLNODES(:,7:11);
        node_group3p=ALLNODES(:,13:17);
    
    [av1,av2,av3,target_CI1,target_CI2,target_CI3,...
        node_CI1, node_CI2,node_CI3 ,energy_to_be_consumedALL,...
        nodes_overhead_energy_consumption_CI_ALL,encryption_energy_ALL,OverheadMatrix128192256]=...
        neoCalculateNeededEnergiesFunction(total_blocks,target_CIA_in_av_order,...
                                            generate_CI1,generate_CI2,generate_CI3,...
                                            node_group1p,node_group2p,node_group3p);
    energyisimleriatama
    
    %ALLNODES
    % tic
    neo_findallpossiblenodes   %%findallpossiblenodes1 dersen sadece 1incileri bulur
    disp('find node complete');
    
    [used_node_specs1,used_node_specs2,used_node_specs3,...
                nextstate,initcoverages]=...
                neo_InitialActiveNodes( ozellikleri_saglayan_nodelarin_spec1to1,...
                                        ozellikleri_saglayan_nodelarin_spec3to1,...
                                        ozellikleri_saglayan_nodelarin_spec2to1,...
                                        ozellikleri_saglayan_nodelarin_spec2to2,...
                                        ozellikleri_saglayan_nodelarin_spec3to2,...
                                        ozellikleri_saglayan_nodelarin_spec1to2,...
                                        ozellikleri_saglayan_nodelarin_spec3to3,...
                                        ozellikleri_saglayan_nodelarin_spec2to3,...
                                        ozellikleri_saglayan_nodelarin_spec1to3,...
                                        initialstate,grno_a,grno_b,grno_c);

    coverage_before_opt=initcoverages
    
      [changedmatrix2,ConsumedEnergies,ConsumedEnergies_DPR,ConsumedEnergies_ENC]=...
         neo_finalized(nextstate,...
         energy_to_be_consumedALL,...
         nodes_overhead_energy_consumption_CI_ALL,...
         encryption_energy_ALL,target_CI1,target_CI2,target_CI3);
incov=coverage_before_opt*100;
init_cov_mat(row_ind,:)=incov;
row_ind = row_ind + 1;
display(i);
end

B_column1 = init_cov_mat(:, 1);
B_column2 = init_cov_mat(:, 2);
B_column3 = init_cov_mat(:, 3);


% X ekseni olarak satır numaralarını oluşturmak
x = 1:size(init_cov_mat, 1);

% A ve B'nin birinci sütunlarını aynı grafikte çizmek
figure(1);
clf;
hold on
title('WITHOUT OPTIMISATION');
set(gca, 'ylim', [0 100]);
set(gca, 'xlim', [0 B/M]);
xticks(0:500:5000); % X ekseninde 500'de bir kılavuz çizgileri (0, 500, 1000, ... 5000)
yticks(0:25:100);
xlabel('Round number');
ylabel('Network coverage percentage');
plot(x, B_column1, 'r','LineWidth', 1, 'DisplayName', 'Coverage of group 1 (AES-192)');
plot(x, B_column2, 'b', 'LineWidth', 1,'DisplayName', 'Coverage of group 2 (AES-256)');
plot(x, B_column3, 'k', 'LineWidth', 1,'DisplayName', 'Coverage of group 3 (AES-128)');
legend
grid on;
hold off;


