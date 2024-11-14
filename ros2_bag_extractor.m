

%bag = ros2("bag","info",'D:\data\straight\test1'); % add the location of bag file in parenthesis between the quotes

bag=ros2bagreader('D:\data\straight\test2');% add the location of bag file in parenthesis between the quotes
%msgs=readMessages(bag);

left=select(bag,"Topic","/motor_rpm_left_front");% choose the topic and save in an object
right=select(bag,"Topic","/motor_rpm_right_front");

rpm_l=readMessages(left);%save messages in cell array
rpm_r=readMessages(right);

phi_L_dot_motor=cellfun(@(x) x.data,rpm_l), %converts cell array to matrix-vector
phi_R_dot_motor=cellfun(@(x) x.data,rpm_r),

phi_R_dot_wheels = phi_R_dot_motor / 9.67;
phi_L_dot_wheels = phi_L_dot_motor / 9.67;

l = length(phi_R_dot_wheels);
time = ((0:0.1:(l - 1) * 0.1))';

phi_R_dot = [time, phi_R_dot_wheels];
phi_L_dot = [time, phi_L_dot_wheels];

phi_L_dot(:, 2) = -phi_L_dot(:, 2);

save('Test11.mat', 'phi_R_dot', 'phi_L_dot');