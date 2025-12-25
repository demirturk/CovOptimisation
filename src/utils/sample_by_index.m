function samples = sample_by_index(coverage_pct, idx)
% coverage_pct: [N x 3]
% idx: indices you want to sample (1-based)
% returns: [numel(idx) x 3]

N = size(coverage_pct, 1);
idx = idx(:);

% Clamp indices to [1, N] to avoid crashes
idx(idx < 1) = 1;
idx(idx > N) = N;

samples = coverage_pct(idx, :);
end
