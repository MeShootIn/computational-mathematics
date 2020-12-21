function [time_win_rcm, nz_win_rcm, time_win_amd, nz_win_amd] = test(n, proportion)
% Генерация положительно определённой разреженной матрицы
A = sprand(n, n, proportion);
A = A + A';
A = A + 100 * speye(n);

% Разложение Холецкого исходной матрицы
start_time = get_time();
R = chol(A);
time_chol = get_time() - start_time;
nz_chol = nnz(R);

% Алгоритм Катхилла-Макки
start_time = get_time();
perm = symrcm(A);
A_rcm = A(perm, perm);
R_rcm = chol(A_rcm);
time_rcm = get_time() - start_time;
nz_rcm = nnz(R_rcm);

% Алгоритм минимальной степени
start_time = get_time();
perm = symamd(A);
A_amd = A(perm, perm);
R_amd = chol(A_amd);
time_amd = get_time() - start_time;
nz_amd = nnz(R_amd);

% Находим коэффициенты выигрышей
time_win_rcm = time_chol / time_rcm;
nz_win_rcm = nz_chol / nz_rcm;
time_win_amd = time_chol / time_amd;
nz_win_amd = nz_chol / nz_amd;

% Визуализируем шаблоны матриц
fig = figure();

subplot(3, 2, 1), spy(A), title('A');
subplot(3, 2, 2), spy(R), title('R: A = R^T * R');
subplot(3, 2, 3), spy(A_rcm), title('A после symrcm');
subplot(3, 2, 4), spy(R_rcm), title('R после symrcm');
subplot(3, 2, 5), spy(A_amd), title('A после symamd');
subplot(3, 2, 6), spy(R_amd), title('R после symamd');
hold on;

saveas(fig, sprintf('amd_%d.png', n));

end