function cfg = simulation_inputs()
% src/sim_inputs.m
% Central configuration for the simulation

cfg = struct();

% Reproducibility
cfg.rngSeed = 61;

% Node generation
cfg.israndom   = 1;   % 1: random initial battery, 0: full
cfg.node_number = 50;

% Availability requirements
cfg.av = struct();
cfg.av.LOW  = 0.25;
cfg.av.MED  = 0.50;
cfg.av.HIGH = 0.75;

% Impact levels (as used in your scripts)
cfg.impact = struct();
cfg.impact.NA   = 1;
cfg.impact.LOW  = 1;
cfg.impact.MED  = 2;
cfg.impact.HIGH = 3;

% Network behaviour / trust (kept as-is)
cfg.network_behaviour = 0; % neutral

% (passed into neoGenerateNodesFunction)
% Potential impacts for three node groups [C, I, A]
% (orijinal sim_INPUTS.m ile aynı)
cfg.potentialimpact_n1 = [cfg.impact.LOW,  cfg.impact.NA, cfg.av.LOW];   % gr3
cfg.potentialimpact_n2 = [cfg.impact.MED,  cfg.impact.NA, cfg.av.HIGH];  % gr1
cfg.potentialimpact_n3 = [cfg.impact.HIGH, cfg.impact.NA, cfg.av.MED];   % gr2

% Rounds / budget model
cfg.B = 5000;         % total rounds * M blocks
cfg.M = 1;            % blocks per round
cfg.time = cfg.B;     % loop: 0:M:time

% Energy budget (your original line: budget = B*M*5.05)
cfg.budget = cfg.B * cfg.M * 5.05;

% Message length
cfg.total_blocks = cfg.M;
cfg.mes_len = cfg.total_blocks * 128;

% Plot control (baseline is controlled; optimized script still plots unless edited)
cfg.doPlotBaseline = true;
end
