% Initialization of arrays and variables
sizes = [500, 1500, 5000, 10000, 15000];
num = length(sizes);
proportion = zeros(1, num);
rcm_algo = 'Катхилла-Макки';
amd_algo = 'Алгоритм минимальной степени';

for i = 1:num
  proportion(i) = 1 / sizes(i);
end

time_wins_rcm = zeros(1, num);
nz_wins_rcm = zeros(1, num);
time_wins_amd = zeros(1, num);
nz_wins_amd = zeros(1, num);

% Running all algorithms and getting results
for i = 1:num
  [time_win_rcm, nz_win_rcm, time_win_amd, nz_win_amd] = test(sizes(i), proportion(i));

  time_wins_rcm(i) = time_win_rcm;
  nz_wins_rcm(i) = nz_win_rcm;
  time_wins_amd(i) = time_win_amd;
  nz_wins_amd(i) = nz_win_amd;
end

% Results table
print_win_table(rcm_algo, sizes, time_wins_rcm, nz_wins_rcm);
print_win_table(amd_algo, sizes, time_wins_amd, nz_wins_amd);

% Graphs of dependencies of coefficients of winnings on the variable "n"
fig = figure();

subplot(2, 1, 1);
plot(sizes, time_wins_rcm, '-or', sizes, time_wins_amd, '-og');
legend(rcm_algo, amd_algo);
xlabel('n');
ylabel('w_{t}');

subplot(2, 1, 2);
plot(sizes, nz_wins_rcm, '-or', sizes, nz_wins_amd, '-og');
legend(rcm_algo, amd_algo);
xlabel('n');
ylabel('w_{nz}');

saveas(fig, 'win.png');
