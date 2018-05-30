%% Init
rng(1);
state_gt =[0;0];

state_ekf = state_gt+[1;1];
state_cov_ekf = eye(2);
state_nonlin = state_gt+[1;1];
state_cov_nonlin = eye(2);

observations = zeros(2,0);

%% Loop
for k=1:10
    % Plot
    figure(1);
    clf;
    subplot(1,2,1);
    plot_state(state_gt, state_ekf, state_cov_ekf, observations);
    title('EKF');
    
    subplot(1,2,2);
    plot_state(state_gt, state_nonlin, state_cov_ekf, observations);
    title('Non-linear optimization');
    
    pause(0.5)

    % State prediction
    state_cov_ekf = state_cov_ekf+eye(2)*0.1;
    state_cov_nonlin = state_cov_nonlin+eye(2)*0.1;
    
    % Generate observations
    Y_COUNT = 5;
    observations=zeros(2,Y_COUNT);
    observations_cov = cell(Y_COUNT,1);
    for i=1:Y_COUNT
        [z,z_cov] = get_random_observation(state_gt);
        observations(:,i)=z;
        observations_cov{i} = z_cov;
    end
    
    % Update
    [state_ekf,state_cov_ekf] = apply_ekf(state_ekf, state_cov_ekf, observations, observations_cov);
    [state_nonlin,state_cov_nonlin] = apply_lsqnonlin(state_nonlin, state_cov_nonlin, observations, observations_cov);
end