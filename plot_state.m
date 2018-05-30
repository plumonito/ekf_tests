function plot_state(state_gt, state, state_cov, observations)

t = linspace(0,2*pi,100);
real_points = [cos(t);sin(t)];

error_ellipse(state_cov,state)
hold on
plot(state_gt(1), state_gt(2), 'xg', 'DisplayName', 'Position (gt)')
plot(state(1), state(2), 'or', 'DisplayName', 'Position (estimated)')
plot(observations(1,:), observations(2,:), '*b', 'DisplayName', 'Observations')
plot(state_gt(1)+real_points(1,:), state_gt(2)+real_points(2,:), '-k', 'DisplayName', 'Real object')
plot(state(1)+real_points(1,:), state(2)+real_points(2,:), '-k', 'DisplayName', 'Estimated object')
ylim([-5,5])
xlim([-5,5])
axis equal
grid
