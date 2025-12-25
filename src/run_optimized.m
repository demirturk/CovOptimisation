function result = run_optimized(cfg)
% src/run_optimized.m
% Wrapper for legacy optimised script (neo_opt_best.m)

arguments
    cfg (1,1) struct
end

% Make cfg visible to sim_INPUTS shim via appdata (survives "clear")
setappdata(0, 'SIM_CFG_OVERRIDE', cfg);

% Run legacy script (must be on path)
run('neo_opt_best.m');

% Clean override
rmappdata(0, 'SIM_CFG_OVERRIDE');

% Collect standard outputs (neo_opt_best defines these in its workspace)
% Expecting: B_column1, B_column2, B_column3
coverage_pct = [B_column1(:), B_column2(:), B_column3(:)];

nRounds = size(coverage_pct, 1);
round_idx = (1:nRounds).';

% Try to infer actual rounds from cfg (safe)
round_actual = (0:cfg.M:cfg.time).';
if numel(round_actual) ~= nRounds
    round_actual = round_idx; % fallback
end

result = struct();
result.name = "optimized";
result.cfg = cfg;
result.round_actual = round_actual;
result.round_idx = round_idx;
result.coverage_pct = coverage_pct;
end
