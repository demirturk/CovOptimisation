% src/main.m
close all;
clearvars;

% Path setup
root = fileparts(mfilename('fullpath'));
addpath(root);  % src klasörü (neo_call_energy_info burada)
addpath(genpath(fullfile(root,'functions')));
addpath(genpath(fullfile(root,'utils')));


% Config
cfg = simulation_inputs();

% Run baseline (without optimisation)
baseline = run_baseline(cfg);

% Run optimised (existing script neo_opt_best.m is wrapped)
optimized = run_optimized(cfg);

% Sample points (index-based, matches your old main.m intention)
values = [1, 500, 1000, 1500, 2000, 2500, 3000, 3500, 4000, 4500, 5000];

be_baseline = sample_by_index(baseline.coverage_pct, values);
be_optimized = sample_by_index(optimized.coverage_pct, values);

% Compare plot
plot_coverage(baseline, optimized);

% Save outputs
results_dir = fullfile(root, '..', 'results');
if ~exist(results_dir, 'dir'), mkdir(results_dir); end
save(fullfile(results_dir, 'run_results.mat'), 'cfg', 'baseline', 'optimized', 'values', 'be_baseline', 'be_optimized');

disp('Done. Results saved to results/run_results.mat');
