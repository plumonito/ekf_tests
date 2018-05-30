function [z,z_cov]=get_random_observation(state_gt)

t = 2*pi*rand(1);
z = state_gt + [cos(t); sin(t)];

variance = 0.1;
z = z+randn(2,1)*variance;
z_cov = eye(2)*variance;