function [ozellikleri_saglayan_nodelarin_spec,...
    ozellikleri_saglayan_node_IDs, ...
    ozellikleri_saglayabilecek_nodelarin_spec,...
    ozellikleri_saglayabilecek_node_IDs,...
    ozellikleri_saglayamayan_nodelarin_spec,...
    ozellikleri_saglayamayan_node_IDs,...
    allpossible_node_IDs,...                % accepted + acceptable
    allpossible_node_specs...
        ]= neo_find_nodes(node_group1,target_CI1,energy_to_be_consumed1to1,encryption_energy_1to1)
    % used_node_IDs,...
    % used_node_specs,...
    % additionlly_accepted_node_IDs,...
    % additionlly_accepted_node_specs node_group1,target_CI1,energy_to_be_consumed1to1

deviation= 6.66;%3*6.66+2*2776.29;   % iki kez dpr üç kez aes256 yapacak kadar daha enerjisi olsun diye deviation ekledik
    
node_number=size(node_group1,1);

node_all_with_consumption=[node_group1,energy_to_be_consumed1to1,encryption_energy_1to1];

% ozellikleri_saglayan_node_spec = node_all(all(node_all > target_spec, 2), :);
%giren matriste node_CI == targetCI olup energy budget >energy threshold olan nodelar 
ozellikleri_saglayan_nodelarin_spec=...
    node_all_with_consumption (all(node_all_with_consumption(:,3) == target_CI1(1) ...
                & node_all_with_consumption(:,4) == target_CI1(2) ...
                & node_all_with_consumption(:,5) > (node_all_with_consumption(:,6)+deviation)  ,2),:);
ozellikleri_saglayan_node_IDs=ozellikleri_saglayan_nodelarin_spec(:,1);

geriye_kalan_nodelar_with_consumption = node_all_with_consumption;
geriye_kalan_nodelar_with_consumption(ozellikleri_saglayan_node_IDs(:),:)=[];

% 4. eleman ve 5. elemanı karşılaştırıyorum yani var olan erneji ve
% harcanacak enerji
ozellikleri_saglayabilecek_nodelarin_spec= ...
    geriye_kalan_nodelar_with_consumption (all(geriye_kalan_nodelar_with_consumption(:,5) > (geriye_kalan_nodelar_with_consumption(:,6)+deviation) ,2),:);
ozellikleri_saglayabilecek_node_IDs=ozellikleri_saglayabilecek_nodelarin_spec(:,1);




ozellikleri_saglayamayan_nodelarin_spec= node_all_with_consumption (all(node_all_with_consumption(:,5) < (node_all_with_consumption(:,6)+deviation) ,2),:);
ozellikleri_saglayamayan_node_IDs=ozellikleri_saglayamayan_nodelarin_spec(:,1);



%all possible nodes that can be used in network accepted + acceptable
allpossible_nodes= node_group1(:,5) >= (energy_to_be_consumed1to1+deviation);
allpossible_node_specs= node_group1 (all(node_group1(:,5) > (energy_to_be_consumed1to1+deviation) ,2),:);
allpossible_node_IDs=allpossible_node_specs(:,1);

%
% accepted_nodes = makes1(node_number, ozellikleri_saglayan_node_IDs);
notaccepted_nodes = makes1(node_number, ozellikleri_saglayamayan_node_IDs);
% acceptable_nodes=makes1(node_number, ozellikleri_saglayabilecek_node_IDs);


% %selected nodes that will be used in network
% used_nodes_list=kontrolFonksiyonu(accepted_nodes, acceptable_nodes)';
% is_used=used_nodes_list';
% used_node_specs= node_all (all(is_used ,2),:);
% used_node_IDs=used_node_specs(:,1);
% usednodenumber=sum(is_used);
% not_used=notaccepted_nodes;
% 
% additionlly_accepted_node_IDs=setdiff(used_node_IDs, ozellikleri_saglayan_node_IDs);
% additionlly_accepted_node_specs=node_all_with_consumption(ismember(node_all_with_consumption(:, 1), additionlly_accepted_node_IDs), :);

end