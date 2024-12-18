clear all; clc;
syms x1 x2 x3 x4 x5 x6 tau1 tau2 % theta1, theta1_dot, theta2, theta2_dot, theta1_dot_dot, theta2_dot_dot
syms J1 J2 m1 m2 l1 l2 lg1 lg2 g % Thông số hệ thống

% Gán giá trị cho các tham số
m1 = 1; m2 = 1;
l1 = 0.5; l2 = 0.4;
J1 = 0.5; J2 = 0.5;
lg1 = 0.25; lg2 = 0.2;
g = 9.8;
theta1_init = 0;
theta1_dot_init = 0;
theta2_init = 0;
theta2_dot_init = 0;
% Biểu thức cho M1
M1 = (m1*lg1^2 + J1 + m2*(l1^2 + lg2^2 + 2*l1*lg2*cos(x3)) + J2)*x5 ...
   + (m2*(lg2^2 + l1*lg2*cos(x3)) + J2)*x6 ...
   - m2*l1*lg2*sin(x3)*(2*x2*x4 + x4^2) ...
   + m1*g*lg1*cos(x1) + m2*g*(l1*cos(x1) + lg2*cos(x1 + x3));

% Biểu thức cho M2
M2 = (m2*(lg2^2 + l1*lg2*cos(x3)) + J2)*x5 ...
   + (m2*lg2^2 + J2)*x6 ...
   + m2*l1*lg2*sin(x3)*x2^2 ...
   + m2*g*lg2*cos(x1 + x3);
%fprintf('Kết quả M1 là:\n');
%disp(M1);
%fprintf('Kết quả M2 là:\n');
%disp(M2);
% Tạo hệ phương trình
ham1 = M1 - tau1; % Giả sử tau1 là mô-men xoắn từ phương trình M1
ham2 = M2 - tau2; % Giả sử tau2 là mô-men xoắn từ phương trình M2

% Giải hệ phương trình để tìm x5 (theta1_dot_dot) và x6 (theta2_dot_dot)
sol = solve([ham1, ham2], [x5, x6]);

% Lấy kết quả x5 và x6
x5 = simplify(sol.x5);
x6 = simplify(sol.x6);

% Hiển thị kết quả
fprintf('Kết quả x5 là:\n');
disp(x5);
fprintf('Kết quả x6 là:\n');
disp(x6);
