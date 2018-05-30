function [state,state_cov] = apply_lsqnonlin(state_old, state_cov_old, observations, observations_cov)
    state_cov_old_sqrt = sqrtm(state_cov_old);

    z_count = length(observations_cov);
    observations_cov_sqrt = cell(z_count);
    for i=1:z_count
        observations_cov_sqrt{i} = sqrtm(observations_cov{i});
    end
    
    t = zeros(z_count,1);
    for i=1:z_count
        t(i) = find_nearest_t(state_old, observations(:,i));
    end

    x0 = [state_old;t];

    options = optimoptions('lsqnonlin');
    options.Display = 'none';
    [x,~,~,~,~,~,J] = lsqnonlin(@(x) cost(x,state_old, state_cov_old_sqrt, observations, observations_cov_sqrt, t), x0, [], [], options);
    state = x(1:2,1);
    J_state = J(:,1:2);
    state_cov = full(inv(J_state'*J_state))*2; % 2 because residuals are squared
end

function residuals = cost(x, state_old, state_cov_old_sqrt, observations, observations_cov_sqrt, t)
    state = x(1:2,1);
    t = x(3:end,1);
    
    residuals_s = state_cov_old_sqrt\(state-state_old);
    
    z_count = length(observations_cov_sqrt);
    residuals_z = zeros(0,1);
    for i=1:z_count
        z = observations(:,i);
        z_cov_sqrt = observations_cov_sqrt{i};
        
        h = state + [cos(t(i)); sin(t(i))];
        r = z_cov_sqrt\(z-h);
        residuals_z = [residuals_z; r];
    end
    
    residuals = [residuals_s; residuals_z];
end