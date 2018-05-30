function t=find_nearest_t(state, z)

zn = z-state;
t = atan2(zn(2),zn(1));