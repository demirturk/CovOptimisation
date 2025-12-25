function plot_coverage(baseline, optimized)
figure(100); clf; hold on;
title('Coverage Comparison (Baseline vs Optimized)');
xlabel('Round');
ylabel('Coverage (%)');
grid on;

plot(baseline.round_actual, baseline.coverage_pct(:,1), 'LineWidth', 1, 'DisplayName', 'Baseline G1');
plot(baseline.round_actual, baseline.coverage_pct(:,2), 'LineWidth', 1, 'DisplayName', 'Baseline G2');
plot(baseline.round_actual, baseline.coverage_pct(:,3), 'LineWidth', 1, 'DisplayName', 'Baseline G3');

plot(optimized.round_actual, optimized.coverage_pct(:,1), '--', 'LineWidth', 1, 'DisplayName', 'Optimized G1');
plot(optimized.round_actual, optimized.coverage_pct(:,2), '--', 'LineWidth', 1, 'DisplayName', 'Optimized G2');
plot(optimized.round_actual, optimized.coverage_pct(:,3), '--', 'LineWidth', 1, 'DisplayName', 'Optimized G3');

legend('Location','best');
hold off;
end
