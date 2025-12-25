% src/sim_INPUTS.m  (SCRIPT - do not convert to function)
% Backward-compatible shim for legacy scripts calling "sim_INPUTS;"

cfg = getappdata(0, 'SIM_CFG_OVERRIDE');
if isempty(cfg)
    cfg = simulation_inputs();
end

rng(cfg.rngSeed);

israndom     = cfg.israndom;
node_number  = cfg.node_number;

LOWav  = cfg.av.LOW;
MEDav  = cfg.av.MED;
HIGHav = cfg.av.HIGH;

NA   = cfg.impact.NA;
LOW  = cfg.impact.LOW;
MED  = cfg.impact.MED;
HIGH = cfg.impact.HIGH;

network_behaviour = cfg.network_behaviour;
potentialimpact_n1 = cfg.potentialimpact_n1;
potentialimpact_n2 = cfg.potentialimpact_n2;
potentialimpact_n3 = cfg.potentialimpact_n3;


B = cfg.B;
M = cfg.M;
time = cfg.time;

budget = cfg.budget;
total_blocks = cfg.total_blocks;
mes_len = cfg.mes_len;
