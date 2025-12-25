function [ used_node_IDs1,...
            used_node_GRs1,...
            used_node_specs1,...
            other_ID2,...
            other_ID3,...
            additionlly_accepted_node_IDs1,...
            additionlly_accepted_node_GRs1,...
            additionlly_accepted_node_specs,...
            Allplaced_afterMincov1,coverageaftermincovto1] = usednodes_mincov(allpossible_node_IDs1to1,grno_a,...    %highest cov
                        allpossible_node_IDs2to1,grno_b,...
                        allpossible_node_IDs3to1,grno_c,...                 %lowesr cov
                        ALLplacednodes_w_passives,av_a,av_b,av_c)

%
nodeNO=size(ALLplacednodes_w_passives,1);
acceptable_nodes1 = makes1(nodeNO,allpossible_node_IDs1to1); %grno_a
acceptable_nodes2=makes1(nodeNO,allpossible_node_IDs2to1); %grno_b
acceptable_nodes3=makes1(nodeNO,allpossible_node_IDs3to1); %grno_c


%selected nodes that will be used in network
[used_nodes_list,used_nodes_groups,Allplaced_afterMincov1,other2,other3]=...
    kontrolFonksiyonu_mincov(acceptable_nodes1,grno_a, acceptable_nodes2,grno_b,acceptable_nodes3,grno_c,...
    ALLplacednodes_w_passives,av_a,av_b,av_c);

is_used=used_nodes_list';
used_gr=used_nodes_groups';
idx = find(is_used);
idx_gr=nonzeros(used_gr)';

other_ID2=find(other2);
other_ID3=find(other3);


used_node_specs1=zeros(length(idx),6);
for j=1:1:length(idx)
used_node_specs1(j, 1:6)=ALLplacednodes_w_passives(idx(j),(6*idx_gr(j)-5):(6*idx_gr(j)));
end


% generate_CI3=target_CIA_in_av_order(3,[1 2]);   


used_node_IDs1=used_node_specs1(:,1);
used_node_GRs1=used_node_specs1(:,2);
% used_node_GRs
% usednodenumber=sum(is_used);


additionlly_accepted_node_IDs1=setdiff(used_node_IDs1, allpossible_node_IDs1to1);
[~,membindex]=ismember(additionlly_accepted_node_IDs1,used_node_specs1(:,1));
additionlly_accepted_node_specs = used_node_specs1(membindex, :);
additionlly_accepted_node_GRs1=additionlly_accepted_node_specs(:,2);


coverage1aftermincovto1= calculatecoverage_no_consumtpion(Allplaced_afterMincov1,grno_a,nodeNO);
coverage2aftermincovto1= calculatecoverage_no_consumtpion(Allplaced_afterMincov1,grno_b,nodeNO);
coverage3aftermincovto1= calculatecoverage_no_consumtpion(Allplaced_afterMincov1,grno_c,nodeNO);
coverageaftermincovto1=[coverage1aftermincovto1,coverage2aftermincovto1,coverage3aftermincovto1];