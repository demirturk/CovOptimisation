function [  used_passive_node_IDs1,...
            used_passive_node_GRs1,...
            used_passive_node_specs1,...
            other_ID2,...
            other_ID3,...
            placedpassiveNODES_w_consumptionsto1,initcov,optcov]...
            = neo_UsedPassiveNodes(ozellikleri_saglayabilecek_node_IDs1to1,grno_a,...
                        ozellikleri_saglayabilecek_node_IDs2to1,grno_b,...
                        ozellikleri_saglayabilecek_node_IDs3to1,grno_c,...
                        ActiveNodesAtStart,av1,av2,av3)


%
nodeNO=size(ActiveNodesAtStart,1);
acceptable_nodes1 = makes1(nodeNO,ozellikleri_saglayabilecek_node_IDs1to1);
acceptable_nodes2=makes1(nodeNO,ozellikleri_saglayabilecek_node_IDs2to1);
acceptable_nodes3=makes1(nodeNO,ozellikleri_saglayabilecek_node_IDs3to1);


%selected nodes that will be used in network
[placedpassiveNODES_w_consumptionsto1,used_nodes_list,used_nodes_groups,other2,other3,initcov,optcov]=...
    neo_kontrolpassivenodes(acceptable_nodes1,grno_a, acceptable_nodes2,grno_b,acceptable_nodes3,grno_c,ActiveNodesAtStart,av1,av2,av3);

is_used=used_nodes_list';
used_gr=used_nodes_groups';
idx = find(is_used);
idx_gr=nonzeros(used_gr)';

other_ID2=find(other2);
other_ID3=find(other3);
% used_node_specs= ALLNODES_w_consumptions (all(is_used ,2),:);


used_passive_node_specs1=zeros(length(idx),6);
for j=1:1:length(idx)
used_passive_node_specs1(j, 1:6)=ActiveNodesAtStart(idx(j),(6*idx_gr(j)-5):(6*idx_gr(j)));
end


% generate_CI3=target_CIA_in_av_order(3,[1 2]);   


used_passive_node_IDs1=used_passive_node_specs1(:,1);
used_passive_node_GRs1=used_passive_node_specs1(:,2);
% used_node_GRs
% usednodenumber=sum(is_used);

