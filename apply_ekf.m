function [state,state_cov] = apply_ekf(state_old, state_cov_old, observations, observations_cov)

state = state_old;
state_cov = state_cov_old;

y_count = size(observations,2);
for i=1:y_count
    z = observations(:,i);
    z_cov = observations_cov{i};
    [y,dy] = apply_observation_model(state,z);

    S = dy*state_cov*dy' + z_cov;
    K = state_cov*dy'*inv(S);
    state = state + K*y;
    state_cov = (eye(size(state_cov)) - K*dy)*state_cov;
end
