function [y, dy] = apply_observation_model(state, z)

t = find_nearest_t(state,z);

h = state + [cos(t); sin(t)];
y = z-h;
dy(:,1) = [1;0];
dy(:,2) = [0;1];