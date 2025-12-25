% nodes data generation for simulation
function [grno_a,grno_b,grno_c,generate_CI1,generate_CI2,generate_CI3,...
    node_group1,node_group2,node_group3,target_CIA_in_av_order]=...
    neoGenerateNodesFunction(node_number,israndom,budget,potentialimpact_n1,potentialimpact_n2,potentialimpact_n3)


groups=3;
total_node_number=node_number*groups ;        % node_number must be divisible with 3

target_CIA_n1=[potentialimpact_n1,1];
target_CIA_n2=[potentialimpact_n2,2];
target_CIA_n3=[potentialimpact_n3,3];

target_CIA_all=[target_CIA_n1;target_CIA_n2;target_CIA_n3];
target_CIA_in_av_order= sortrows(target_CIA_all,3,'descend'); %we sort the target CIA according to availability
grno_a=1; %target_CIA_in_av_order(1,4);
grno_b=2;%target_CIA_in_av_order(2,4);
grno_c=3;%target_CIA_in_av_order(3,4);

%generate 3 node group according to availability order
generate_CI1=target_CIA_in_av_order(grno_a,[1 2]);           %highest availability impact group grno=1
[node_group1]=neo_generate_group(node_number,grno_a,generate_CI1,budget,israndom);

%buralar sırasıyla b ve c olacaktı hepsini grno_a yaptım
generate_CI2=target_CIA_in_av_order(grno_b,[1 2]);           %medium availability impact group grno=2
[node_group2]=neo_generate_group(node_number,grno_b,generate_CI2,budget,israndom);

generate_CI3=target_CIA_in_av_order(grno_c,[1 2]);           %lowest availability impact group grno=3
[node_group3]=neo_generate_group(node_number,grno_c,generate_CI3,budget,israndom);


% % % %TEST icin koydum
% node_group1(1,2)= 2;
% node_group1(1,3:4)= [3 1];
% node_group1(1,5)= 14000;
% 
% node_group3(1,2)= 2;
% node_group3(1,3)= 3;
% node_group3(1,5)= 14000;
% 
% node_group2(1,2)= 1;
% node_group2(1,3)= 2;
% 
% node_group2(1,5)= 13000;


end