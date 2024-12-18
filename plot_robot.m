% Thông số
t_f = 4; % Thời gian tổng (s)
t_c = 1; % Thời gian tăng tốc (s)
q1_i = 0; q1_f = pi/2; % Góc khớp 1 (rad)
q2_i = pi/6; q2_f = pi/2; % Góc khớp 2 (rad)
q1_ddot_c = pi/6; % Gia tốc cực đại khớp 1 (rad/s^2)
q2_ddot_c = pi/9; % Gia tốc cực đại khớp 2 (rad/s^2)

% Khởi tạo t là 1 mảng gồn 1000 phần tử cách đều nhau 0.01 từ 0s --> 4s
t = linspace(0, t_f, 1000);

% Khởi tạo quỹ đạo
q1 = zeros(size(t));
q2 = zeros(size(t));
dq1 = zeros(size(t));
dq2 = zeros(size(t));
ddq1 = zeros(size(t));
ddq2 = zeros(size(t));
% ddq1(1) = 0; ddq1(end) = 0;  % Gia tốc tại t=0 và t=t_f là 0
% ddq2(1) = 0; ddq2(end) = 0;  % Gia tốc tại t=0 và t=t_f là 0
% Tính toán quỹ đạo
for i = 1:length(t)
    if t(i) <= t_c
        % Giai đoạn tăng tốc
        q1(i) = q1_i + 0.5 * q1_ddot_c * t(i)^2;
        q2(i) = q2_i + 0.5 * q2_ddot_c * t(i)^2;
        dq1(i) = q1_ddot_c * t(i);
        dq2(i) = q2_ddot_c * t(i);
        ddq1(i) = q1_ddot_c;
        ddq2(i) = q2_ddot_c;
    elseif t(i) > t_c && t(i) <= t_f - t_c
        % Giai đoạn chuyển động đều
        q1(i) = q1_i + q1_ddot_c * t_c * (t(i) - t_c / 2);
        q2(i) = q2_i + q2_ddot_c * t_c * (t(i) - t_c / 2);
        dq1(i) = q1_ddot_c * t_c;
        dq2(i) = q2_ddot_c * t_c;
        ddq1(i) = 0;
        ddq2(i) = 0;
    else
        % Giai đoạn giảm tốc
        q1(i) = q1_f - 0.5 * q1_ddot_c * (t_f - t(i))^2;
        q2(i) = q2_f - 0.5 * q2_ddot_c * (t_f - t(i))^2;
        dq1(i) = q1_ddot_c * (t_f - t(i));
        dq2(i) = q2_ddot_c * (t_f - t(i));
        ddq1(i) = -q1_ddot_c;
        ddq2(i) = -q2_ddot_c;
    end
end
ddq1(1) = 0;
ddq1(end) = 0;
ddq2(1) = 0;
ddq2(end) = 0;
% Vẽ đồ thị quỹ đạo, vận tốc và gia tốc
figure;

% Quỹ đạo
subplot(3, 1, 1);
plot(t, q1, 'r', 'LineWidth', 1.5); hold on;
plot(t, q2, 'b', 'LineWidth', 1.5);
xlabel('Thời gian (s)');
ylabel('Góc quay (rad)');
title('Quỹ đạo chuyển động của các khớp');
legend('Khớp 1 (q1)', 'Khớp 2 (q2)');
grid on;

% Vận tốc
subplot(3, 1, 2);
plot(t, dq1, 'r', 'LineWidth', 1.5); hold on;
plot(t, dq2, 'b', 'LineWidth', 1.5);
xlabel('Thời gian (s)');
ylabel('Vận tốc góc (rad/s)');
title('Vận tốc góc của các khớp');
legend('Vận tốc góc Khớp 1', 'Vận tốc góc Khớp 2');
grid on;

% Gia tốc
subplot(3, 1, 3);
plot(t, ddq1, 'r', 'LineWidth', 1.5); hold on;
plot(t, ddq2, 'b', 'LineWidth', 1.5);


xlabel('Thời gian (s)');
ylabel('Gia tốc góc (rad/s^2)');
title('Gia tốc góc của các khớp');
legend('Gia tốc góc Khớp 1', 'Gia tốc góc Khớp 2');
grid on;

