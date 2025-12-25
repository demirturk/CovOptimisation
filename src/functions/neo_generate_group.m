function [node_group]=neo_generate_group(node_number,grno_in,generate_CI,budget,israndom)

indices=(1:1:node_number)';
grnos=repmat(grno_in,node_number,1);
initial_security_lvl_of_nodes=repmat(generate_CI,node_number,1);
C_lvls= initial_security_lvl_of_nodes(:,1);
I_lvls      = initial_security_lvl_of_nodes(:,2);
if israndom==1;
    inb=randi([0 100],1,node_number)';
    initial_battery_charge_levels= inb/100; % yuzde gosteren charge
elseif israndom==0;
    inb=100*ones(1,node_number)';
    initial_battery_charge_levels= inb/100; % yuzde gosteren charge
end

max_energy=  budget;  %nj
Charge=initial_battery_charge_levels*max_energy; %nano joule cinsinden charge


node_group=[indices, grnos, C_lvls, I_lvls, Charge];  %C: confid I: integrity, B: Battery
end