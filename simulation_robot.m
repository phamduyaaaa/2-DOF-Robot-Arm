clc; clear; close all;
% Thông số robot
m1 = 1; l1 = 0.5; lg1 = 0.25; J1 = 0.5; % Khớp 1
m2 = 1; l2 = 0.4; lg2 = 0.2; J2 = 0.5; % Khớp 2

% Thông số quỹ đạo
t_f = 4; % Thời gian tổng (s)
t_c = 1; % Thời gian tăng tốc (s)
q1_i = 0; q1_f = pi/2; % Góc khớp 1 (rad)
q2_i = pi/6; q2_f = pi/2; % Góc khớp 2 (rad)
q1_ddot_c = pi/6; % Gia tốc cực đại khớp 1 (rad/s^2)
q2_ddot_c = pi/9; % Gia tốc cực đại khớp 2 (rad/s^2)
%q2_f = 0 --> q2_ddot_c = -pi/18
% Chia trục thời gian thành 1000 phần đều nhau từ 0s --> 4s
t = linspace(0, t_f, 1000);

% Khởi tạo quỹ đạo
q1 = zeros(size(t));
q2 = zeros(size(t));

for i = 1:length(t)
    if t(i) <= t_c
        % Giai đoạn tăng tốc
        q1(i) = q1_i + 0.5 * q1_ddot_c * t(i)^2;
        q2(i) = q2_i + 0.5 * q2_ddot_c * t(i)^2;
    elseif t(i) > t_c && t(i) <= t_f - t_c
        % Giai đoạn chuyển động đều
        q1(i) = q1_i + q1_ddot_c * t_c * (t(i) - t_c / 2);
        q2(i) = q2_i + q2_ddot_c * t_c * (t(i) - t_c / 2);
    else
        % Giai đoạn giảm tốc
        q1(i) = q1_f - 0.5 * q1_ddot_c * (t_f - t(i))^2;
        q2(i) = q2_f - 0.5 * q2_ddot_c * (t_f - t(i))^2;
    end
end

% Vẽ robot và mô phỏng real-time
figure; hold on; grid on;
axis([-1, 1, -1, 1]); % Đặt trục
xlabel('X-axis'); ylabel('Y-axis');
title('Mô phỏng Robot 2 bậc tự do (Real-Time)');

% Vẽ khung robot
link1 = plot([0, 0], [0, 0], 'r', 'LineWidth', 3); % Thanh 1
link2 = plot([0, 0], [0, 0], 'b', 'LineWidth', 3); % Thanh 2
joint = plot(0, 0, 'ko', 'MarkerSize', 6, 'MarkerFaceColor', 'k'); % Khớp
end_effector = plot(0, 0, 'go', 'MarkerSize', 6, 'MarkerFaceColor', 'g'); % Đầu cuối

% Hiển thị thời gian
time_display = text(-0.9, 0.9, 'Time: 0.00s', 'FontSize', 12, 'Color', 'k'); % Vị trí và màu chữ

% Mô phỏng chuyển động
disp(q1);
for i = 1:length(t)
    % Góc hiện tại
    theta1 = q1(i);
    theta2 = q2(i);
    
    % Tính tọa độ các điểm
    x1 = l1 * cos(theta1); % Đầu cuối thanh nối 1
    y1 = l1 * sin(theta1);
    x2 = x1 + l2 * cos(theta1 + theta2); % Đầu cuối thanh nối 2
    y2 = y1 + l2 * sin(theta1 + theta2);
    
    % Cập nhật vẽ robot
    set(link1, 'XData', [0, x1], 'YData', [0, y1]); % Thanh 1
    set(link2, 'XData', [x1, x2], 'YData', [y1, y2]); % Thanh 2
    set(joint, 'XData', [0, x1], 'YData', [0, y1]); % Khớp
    set(end_effector, 'XData', x2, 'YData', y2); % Đầu cuối
    
    % Cập nhật hiển thị thời gian
    set(time_display, 'String', sprintf('Time: %.2fs', t(i))); % Hiển thị thời gian thực
    
    % Vẽ real-time
    pause(0.01); % Dừng để hiển thị theo thời gian thực
end
