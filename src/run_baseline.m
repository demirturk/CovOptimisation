function result = run_baseline(cfg)
% src/run_baseline.m
% Baseline scenario (without optimisation) - functionized

arguments
    cfg (1,1) struct
end

rng(cfg.rngSeed);

% Keep variable names aligned with original scripts
israndom     = cfg.israndom;
node_number  = cfg.node_number;
budget       = cfg.budget;
total_blocks = cfg.total_blocks;
M            = cfg.M;
B            = cfg.B;
time         = cfg.time;

potentialimpact_n1 = cfg.potentialimpact_n1;
potentialimpact_n2 = cfg.potentialimpact_n2;
potentialimpact_n3 = cfg.potentialimpact_n3;


[grno_a,grno_b,grno_c,generate_CI1,generate_CI2,generate_CI3, ...
    node_group1,node_group2,node_group3,target_CIA_in_av_order] = ...
    neoGenerateNodesFunction(node_number, israndom, budget, ...
                             potentialimpact_n1, potentialimpact_n2, potentialimpact_n3);


% create ALLNODES matrix for decision input
placezero = zeros(node_number,1);
ALLNODES = [node_group1, placezero, node_group2, placezero, node_group3, placezero];
NodesAtStart = ALLNODES;
changedmatrix2 = ALLNODES;

round_actual = (0:M:time).';
nRounds = numel(round_actual);

init_cov_mat = zeros(nRounds, 3);
row_ind = 1;

for i = 0:M:time
    ALLNODES = changedmatrix2;

    % Clear "used" flags in columns 6,12,18 (as in your script)
    places = [6, 12, 18];
    ALLNODES(:,places) = 0;

    initialstate = ALLNODES;

    node_group1p = ALLNODES(:,1:5);
    node_group2p = ALLNODES(:,7:11);
    node_group3p = ALLNODES(:,13:17);

    [av1,av2,av3,target_CI1,target_CI2,target_CI3, ...
        node_CI1, node_CI2,node_CI3, energy_to_be_consumedALL, ...
        nodes_overhead_energy_consumption_CI_ALL, encryption_energy_ALL, OverheadMatrix128192256] = ...
        neoCalculateNeededEnergiesFunction(total_blocks, target_CIA_in_av_order, ...
                                           generate_CI1, generate_CI2, generate_CI3, ...
                                           node_group1p, node_group2p, node_group3p);

    %#ok<NASGU> av1 av2 av3 node_CI1 node_CI2 node_CI3 OverheadMatrix128192256

    % Legacy scripts (still scripts)
    energyisimleriatama;
    neo_findallpossiblenodes;

    [used_node_specs1, used_node_specs2, used_node_specs3, nextstate, initcoverages] = ...
        neo_InitialActiveNodes( ozellikleri_saglayan_nodelarin_spec1to1, ...
                                ozellikleri_saglayan_nodelarin_spec3to1, ...
                                ozellikleri_saglayan_nodelarin_spec2to1, ...
                                ozellikleri_saglayan_nodelarin_spec2to2, ...
                                ozellikleri_saglayan_nodelarin_spec3to2, ...
                                ozellikleri_saglayan_nodelarin_spec1to2, ...
                                ozellikleri_saglayan_nodelarin_spec3to3, ...
                                ozellikleri_saglayan_nodelarin_spec2to3, ...
                                ozellikleri_saglayan_nodelarin_spec1to3, ...
                                initialstate, grno_a, grno_b, grno_c);

    %#ok<NASGU> used_node_specs1 used_node_specs2 used_node_specs3

    coverage_before_opt = initcoverages;

    [changedmatrix2, ConsumedEnergies, ConsumedEnergies_DPR, ConsumedEnergies_ENC] = ...
        neo_finalized(nextstate, ...
                      energy_to_be_consumedALL, ...
                      nodes_overhead_energy_consumption_CI_ALL, ...
                      encryption_energy_ALL, ...
                      target_CI1, target_CI2, target_CI3);

    %#ok<NASGU> ConsumedEnergies ConsumedEnergies_DPR ConsumedEnergies_ENC

    init_cov_mat(row_ind,:) = coverage_before_opt * 100;
    row_ind = row_ind + 1;
end

coverage_pct = init_cov_mat;             % [nRounds x 3]
round_idx = (1:nRounds).';

result = struct();
result.name = "baseline";
result.cfg = cfg;
result.round_actual = round_actual;      % 0..B step M
result.round_idx = round_idx;            % 1..nRounds
result.coverage_pct = coverage_pct;      % columns: group1/group2/group3
result.NodesAtStart = NodesAtStart;

if isfield(cfg, 'doPlotBaseline') && cfg.doPlotBaseline
    figure(1); clf; hold on;
    title('WITHOUT OPTIMISATION');
    set(gca, 'ylim', [0 100]);
    set(gca, 'xlim', [0 B/M]);
    xticks(0:500:5000);
    yticks(0:25:100);
    xlabel('Round number');
    ylabel('Network coverage percentage');
    plot(round_actual, coverage_pct(:,1), 'LineWidth', 1, 'DisplayName', 'Coverage of group 1');
    plot(round_actual, coverage_pct(:,2), 'LineWidth', 1, 'DisplayName', 'Coverage of group 2');
    plot(round_actual, coverage_pct(:,3), 'LineWidth', 1, 'DisplayName', 'Coverage of group 3');
    legend; grid on; hold off;
end
end
